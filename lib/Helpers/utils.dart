import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Utils {

  static void showToastMsg(String msg, BuildContext context) {
    Toast.show(
      msg,
      context,
      duration: 2,
    );
  }
}
