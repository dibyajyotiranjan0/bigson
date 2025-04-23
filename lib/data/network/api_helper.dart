import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../static/aapp_url-endpoint.dart';
import '../response/exception.dart';
import '../response/response_check.dart';

class NetworkApiService {
  var dio = Dio();
  Future<dynamic> getApi({required String urll}) async {
    late var jsonResponse;
    try {
      var response = await await dio.get("${AppUrl.baseUrl}${urll}");
      // print(response);
      jsonResponse = checkREsponse(response);
    } on SocketException {
      // print("No Internet");
      throw FetchDataException("No internet");
    }
    return jsonResponse;
  }

  Future postApi({required url, required FormData formData}) async {
    late var jsonResponse;

    try {
      var response = await dio.post("${AppUrl.baseUrl}${url}",
          options: Options(
            headers: {
              "Content-Type": "multipart/form-data",
            },
          ),
          data: formData);
      jsonResponse = checkREsponse(response);
    } on SocketException {
      // print("No Internet");
      throw FetchDataException("No internet");
    }
    return jsonResponse;
  }
}
