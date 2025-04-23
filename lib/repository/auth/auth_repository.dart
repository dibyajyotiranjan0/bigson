import 'package:bigsangrup/screen/auth/forgetPassword/change_password_screen.dart';
import 'package:bigsangrup/screen/auth/forgetPassword/forget_password_screen.dart';
import 'package:dio/dio.dart';

import '../../data/network/api_helper.dart';
import '../../static/aapp_url-endpoint.dart';

class AuthApiRepository {
  Future<dynamic> signup(
      {required String name,
      required String mobilleNo,
      required String email,
      required String password}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'name': name,
        'email': email,
        'phone': mobilleNo,
        'password': password,
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.registration, formData: formData);
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

  Future<dynamic> loginApi(
      {required String email, required String password}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'email': email,
        'password': password,
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.login, formData: formData);
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

  Future<dynamic> ForgetPassword({required String email}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({'email': email});
      response = await NetworkApiService()
          .postApi(url: AppUrl.forgetPassword, formData: formData);
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

  Future<dynamic> ChangePassword(
      {required String userId,
      required String updatePass,
      required String retypePass}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'user_id': userId,
        'new_password': updatePass,
        'confirm_password': retypePass
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.updatePassword, formData: formData);
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
