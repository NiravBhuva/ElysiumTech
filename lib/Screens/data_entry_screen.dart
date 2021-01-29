import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elysium_tech/Helpers/utils.dart';
import 'package:elysium_tech/Widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class DataEntryScreen extends StatefulWidget {
  @override
  _DataEntryScreenState createState() => _DataEntryScreenState();
}

class _DataEntryScreenState extends State<DataEntryScreen> {
  final firestoreInstance = FirebaseFirestore.instance;

  final TextEditingController favDishController = TextEditingController();
  final TextEditingController favTeamController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  var gender = 'Male';
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dobController.text = "${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year}";
      });
  }

  void _onSubmit(BuildContext context) {
    if (_formKey.currentState.validate()) {
      if(selectedDate != null){
        firestoreInstance.collection("dataEntry").add({
          "gender": gender,
          "dob": selectedDate.toString(),
          "favDish": favDishController.text,
          "favTeam": favTeamController.text,
        }).then((value) {
          Utils.showToastMsg('Data submitted successfully'.tr(), context);
          Navigator.of(context).pop();
        });
      }else{
        Utils.showToastMsg('Please select date of birth'.tr(), context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Entry Screen'.tr()),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<String>(
                isExpanded: true,
                value: gender,
                items: <String>['Male', 'Female'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    gender = val;
                  });
                },
              ),
              SizedBox(height: 12),
              CustomTextField(
                placeholder: "Date of Birth".tr(),
                controller: dobController,
                onTap: () {
                  _selectDate(context);
                },
              ),
//              RaisedButton(
//                onPressed: () => _selectDate(context),
//                child: Text('Select date'),
//              ),
              SizedBox(height: 12),
              CustomTextField(
                placeholder: "Favourite dish".tr(),
                controller: favDishController,
                validator: _validate,
              ),
              SizedBox(height: 12),
              CustomTextField(
                placeholder: "Favourite soccer team".tr(),
                controller: favTeamController,
                validator: _validate,
              ),
              SizedBox(height: 36),
              RaisedButton(
                onPressed: () {
                  this._onSubmit(context);
                },
                child: Text('Submit'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _validate(String text) {
    print(text);
    if (text == null || text.isEmpty) {
      return 'Please fill this field'.tr();
    }
    return null;
  }
}
