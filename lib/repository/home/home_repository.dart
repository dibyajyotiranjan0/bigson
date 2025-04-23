import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../data/network/api_helper.dart';
import '../../static/aapp_url-endpoint.dart';

class HomeRepository {
  Future<dynamic> showHistory({required String userId}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({'vowner_id': userId});
      response = await NetworkApiService()
          .postApi(url: AppUrl.slipList, formData: formData);
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
    Future<dynamic> commisionmodel() async {
    late var response;

    try {
      // FormData formData = FormData.fromMap({'vowner_id': userId});
      response = await NetworkApiService().getApi(urll: AppUrl.commision);
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

  Future<dynamic> transporter() async {
    late var response;

    try {
      response = await NetworkApiService().getApi(urll: AppUrl.transporter);
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

  Future<dynamic> addSlip(
      {required String vowner_id,
      required String vehicle_no,
      required String transporter_id,
      required String date,
      required String tdsNo,
      required image,
      required String price,
      required String paid_amountt,
      required String paymentSts,
      required weightImage}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'vowner_id': vowner_id,
        'vehicle_no': vehicle_no,
        'image': image,
        'date': date,
        'tds_no': tdsNo,
        'transporter_id': transporter_id,
        'weight_image': weightImage,
        'price' :price,
        'paid_amount' :paid_amountt,
        'payment_status' :paymentSts
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.addSlip, formData: formData);
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

  Future<dynamic> updateSlip(
      {required String slip_id,
      required String vowner_id,
      required String vehicle_no,
      required String transporter_id,
      required String date,
      required String tdsNo,
      required image,
      required weightImage}) async {
    var response;
    // print(vehicle_no);

    try {
      FormData formData = FormData.fromMap({
        'slip_id': slip_id,
        'vowner_id': vowner_id,
        'vehicle_no': vehicle_no,
        'image': image,
        'date': date,
        'tds_no': tdsNo,
        'transporter_id': transporter_id,
        'weight_image': weightImage
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.slipUpdate, formData: formData);
    
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
  Future<dynamic> deletSlip({required String slipId}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'id': slipId,
      });
      response = await NetworkApiService().postApi(url: AppUrl.deletSllip, formData: formData);
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
  Future<dynamic> discountSlipAdd(
      {required String vowner_id,
      required String vehicle_no,
      required String transporter_id,
      required String token_charge,
      required String total_amnt,
      required String cash_advance,
      required weight_image,
required chalana_image,
required slip_image,}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'transporter_id': transporter_id,
        'vowner_id': vowner_id,
        'vehicle_no': vehicle_no,
        'cash_advance':cash_advance,
        'token_charge':token_charge,
        'total_amount':total_amnt,
        'weight_image':weight_image,
        'chalana_image':chalana_image,
        'slip_image':slip_image,
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.chalanDiscount, formData: formData);
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

  Future<dynamic> showPayment({required String userId}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({'vowner_id': userId});
      response = await NetworkApiService()
          .postApi(url: AppUrl.paymentInfo, formData: formData);
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
    Future<dynamic> getLifetimeMemberRepo() async {
    late var response;

    try {
      // FormData formData = FormData.fromMap({'vowner_id': userId});
      response = await NetworkApiService()
          .getApi(urll: AppUrl.getLifetimeUsers);
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
    Future<dynamic> lifetimeSubscription() async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        // 'id': slipId,
      });
      response = await NetworkApiService().postApi(url: AppUrl.lifetimeSub,formData: formData);
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
      Future<dynamic> buySubscription({required String vendrId,String? amount, String?payAmount,String? sts}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'vowner_id': vendrId,
        'lifetimeOffer_ammount':amount,
        'payment_amount':payAmount,
        'payment_status':sts
      });
      response = await NetworkApiService().postApi(url: AppUrl.buyPackage,formData: formData);
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
