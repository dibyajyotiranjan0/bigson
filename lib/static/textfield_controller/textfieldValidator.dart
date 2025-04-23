import 'package:flutter/material.dart';

class Validator {
  validateEmail(value) {
    if (value.isEmpty) {
      return "Enter a Valid email";
    } else {
      if (!RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(value!)) {
        //value!.isEmpty
        return "Enter Cocrrect Email";
      }

      return null;
    }
  }

  validateMobile(value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter Phone Number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    } else if (value.length == 10) {
      if (!regExp.hasMatch(value)) {
        return 'Please enter valid mobile number';
      } else
        return null;
    }
  }
}
