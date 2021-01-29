import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elysium_tech/Helpers/utils.dart';
import 'package:elysium_tech/Widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final firestoreInstance = FirebaseFirestore.instance;

  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _onSubmit(BuildContext context) {
    if (_formKey.currentState.validate()) {
      firestoreInstance.collection("users").add({
        "fName": fNameController.text,
        "lName": lNameController.text,
        "email": emailController.text,
        "mobile": mobileController.text,
        "password": passwordController.text,
      }).then((value) {
        Utils.showToastMsg('User registered successfully'.tr(), context);
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Screen'.tr()),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                placeholder: "First Name".tr(),
                controller: fNameController,
                validator: _validate,
              ),
              SizedBox(height: 12),
              CustomTextField(
                placeholder: "Last Name".tr(),
                controller: lNameController,
                validator: _validate,
              ),
              SizedBox(height: 12),
              CustomTextField(
                placeholder: "Email Address".tr(),
                controller: emailController,
                validator: validateEmail,
              ),
              SizedBox(height: 12),
              CustomTextField(
                placeholder: "Mobile Number".tr(),
                controller: mobileController,
                validator: _validate,
              ),
              SizedBox(height: 12),
              CustomTextField(
                placeholder: "Password".tr(),
                obscureText: true,
                controller: passwordController,
                validator: _validate,
              ),
              SizedBox(height: 36),
              RaisedButton(
                onPressed: (){
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

  static String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter valid email address';
    else
      return null;
  }
}
