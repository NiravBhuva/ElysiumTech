import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elysium_tech/Helpers/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';

class UploadFileScreen extends StatefulWidget {
  @override
  _UploadFileScreenState createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  List<File> _images = [];
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _images.add(File(pickedFile.path));
      }
    });
  }

  void uploadImages(BuildContext context) async {
    if (this._images.isNotEmpty) {
      DocumentReference sightingRef =
          FirebaseFirestore.instance.collection('pictures').doc();
      await saveImages(_images, sightingRef).then(
        (value) => {
          Navigator.of(context).pop(),
          Utils.showToastMsg('Images Uploaded Successfully'.tr(), context),
        },
      );
    } else {}
  }

  Future<void> saveImages(List<File> _images, DocumentReference ref) async {
    _images.forEach((image) async {
      String imageURL = await uploadFile(image);
      ref.update({
        "images": FieldValue.arrayUnion([imageURL])
      });
    });
  }

  Future<String> uploadFile(File _image) async {
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    Reference storageReference =
        FirebaseStorage.instance.ref().child('doc_${getRandomString(7)}');
    await storageReference
        .putFile(_image)
        .then((val) => {print('File Uploaded')});

    String returnURL;
    await storageReference.getDownloadURL().then((fileURL) {
      returnURL = fileURL;
    });
    return returnURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload file Screen'.tr()),
        actions: [
          IconButton(
            onPressed: getImage,
            icon: Icon(Icons.camera_alt),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => uploadImages(context),
        child: Icon(Icons.file_upload),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        width: MediaQuery.of(context).size.width,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            //childAspectRatio: 1
          ),
          itemCount: _images.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Image.file(_images[index]),
                InkWell(
                  onTap: () {
                    setState(() {
                      _images.removeAt(index);
                    });
                  },
                  child: Container(
                    alignment: Alignment.topRight,
                    width: double.infinity,
                    child: Container(
                      height: 22,
                      width: 22,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close_outlined,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
