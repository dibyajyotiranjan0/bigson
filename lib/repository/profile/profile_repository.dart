import 'package:bigsangrup/screen/profile/add_bank_account.dart';
import 'package:bigsangrup/screen/profile/add_vehicle.dart';
import 'package:dio/dio.dart';

import '../../data/network/api_helper.dart';
import '../../static/aapp_url-endpoint.dart';

class ProfileRepository {
  Future<dynamic> viewProfile({required String userID}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'user_id': userID,
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.profile, formData: formData);
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

  Future<dynamic> editProfile(
      {required String userID,
      String? name,
      String? email,
      String? phone,
      image,
      panImage,
      String? pan, aadharFoont,
      String? aadhar,aadharback}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'user_id': userID,
        'name': name,
        'email': email,
        'phone': phone,
        'image': image,
        'pan_image': panImage,
        'pan_card': pan,
        'adhar_no':aadhar,
        'adhar_image':aadharFoont,
        'adhar_back_image':aadharback
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.updateProfile, formData: formData);
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

  Future<dynamic> addVehicle(
      {required String userID,
      String? vehicleNu,
      String? licenceNu,
      licenceImg,
      vehicleImg}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'owner_id': userID,
        'vehicle_no': vehicleNu,
        'vehicle_image': vehicleImg,
        'licience_image': licenceImg,
        'licience_no': licenceNu
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.vehicleAdd, formData: formData);
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

  Future<dynamic> showVehicle({required String userID}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'id': userID,
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.showVehicle, formData: formData);
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

  Future<dynamic> addBankAccount(
      {required String userID,
      String? bankN,
      String? accountN,
      String? ifscNu,
       String? holderrName,
      dynamic check_image,
      dynamic passbook_image}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'owner_id': userID,
        'bank_name': bankN,
        'account_no': accountN,
        'ifc_code': ifscNu,
        'check_image': check_image,
        'passbook_image': passbook_image,
        'account_holder_name':holderrName
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.ownerBakDetail, formData: formData);
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

  Future<dynamic> showBankAccount({required String userID}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'id': userID,
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.showBankAccount, formData: formData);
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

  Future<dynamic> updateBankAccount(
      {required String id,
      required String userID,
      String? bankN,
      String? accountN,
      String? ifscNu,
      String? holderrName,
      dynamic check_image,
      dynamic passbook_image}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'id': id,
        'owner_id': userID,
        'bank_name': bankN,
        'account_no': accountN,
        'ifc_code': ifscNu,
        'check_image': check_image,
        'passbook_image': passbook_image,
        'account_holder_name':holderrName
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.bankUpdate, formData: formData);
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

  Future<dynamic> updateVehicle(
      {required String userID,
      String? vehicleNu,
      String? licenceNu,
      licenceImg,
      required String id,
      vehicleImg}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'owner_id': userID,
        'vehicle_no': vehicleNu,
        'vehicle_image': vehicleImg,
        'licience_image': licenceImg,
        'licience_no': licenceNu,
        'id': id
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.vehicleUpdate, formData: formData);
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
