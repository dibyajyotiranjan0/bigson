import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

ShowToast({required String msg}) {
  return Fluttertoast.showToast(
      // backgroundColor: Colors.white,
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0);
}
