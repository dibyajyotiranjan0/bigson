
import 'package:dio/dio.dart';

import '../../data/network/api_helper.dart';
import '../../static/aapp_url-endpoint.dart';

class ParkingRepository {
  Future<dynamic> viewAllParking() async {
    late var response;

    try {
      // FormData formData = FormData.fromMap({
      //   'user_id': userID,
      // });
      response = await NetworkApiService()
          .getApi(urll: AppUrl.parkingList);
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

  Future<dynamic> bookPark(
      {required String userID,
      String? vehicle_no,
      String? parking_id,
      String? parking_date,
      String? payment_status,
      String? parkingprice_id,
      String? parking_date_2,
      String? amount,}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'user_id':userID,
        'vehicle_no':vehicle_no,
        'parking_data_id':parking_id,
        'parking_price_data_id':parkingprice_id,
        'parking_date':parking_date,
        'parking_date_2':parking_date_2,
        'payment_price':amount,
        'payment_status':payment_status
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.bookParking, formData: formData);
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

  Future<dynamic> myParking({required String userID}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'vowner_id': userID,
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.userparking, formData: formData);
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
