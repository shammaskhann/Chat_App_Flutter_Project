import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constant/colors.dart';

class Utils {
  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.black,
      textColor: AppColors.white,
      fontSize: 16.0,
    );
  }
}
