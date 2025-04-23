import 'package:dio/dio.dart';

import '../../data/network/api_helper.dart';
import '../../static/aapp_url-endpoint.dart';

class SupportRepository {
  Future<dynamic> viewAllsupport({required String userID}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'id': userID,
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.quicksupportList, formData: formData);
    } on DioException catch (e) {
      if (e.response != null) {
        response = e.response!.data;
      } else {
        response = e.message;
      }
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
  Future<dynamic> addSupport(
      {required String userID,
      String? phoneNo,
      vehicleNo,
      query}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'owner_id': userID,
        'phone_number': phoneNo,
        'text': query,
        'vehicle_no': vehicleNo
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.quicksupport, formData: formData);
    } on DioException catch (e) {
      if (e.response != null) {
        response = e.response!.data;
      } else {
        response = e.message;
      }
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
}