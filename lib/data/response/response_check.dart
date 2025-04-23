import 'package:bigsangrup/data/response/exception.dart';
import 'package:flutter/material.dart';

dynamic checkREsponse(response) {
  // debugPrint(response.toString());
  // print(response.statusCode);
  if (response.statusCode == 200) {
    var data = response.data;
    // ShowToast(msg: data);\
    // debugPrint(data);
    return data;
  } else if (response.statusCode == 400) {
    return BadRequestException(response.data.toString());
  } else {
    return FetchDataException(
        "Error Occured while communicate the server with status code: ${response.statusCode}");
  }
}
