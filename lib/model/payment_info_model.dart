// To parse this JSON data, do
//
//     final paymentInfoModel = paymentInfoModelFromJson(jsonString);

import 'dart:convert';

PaymentInfoModel paymentInfoModelFromJson(String str) =>
    PaymentInfoModel.fromJson(json.decode(str));

String paymentInfoModelToJson(PaymentInfoModel data) =>
    json.encode(data.toJson());

class PaymentInfoModel {
  bool? success;
  dynamic error;
  String? message;
  Data? data;

  PaymentInfoModel({
    this.success,
    this.error,
    this.message,
    this.data,
  });

  factory PaymentInfoModel.fromJson(Map<String, dynamic> json) =>
      PaymentInfoModel(
        success: json["success"],
        error: json["error"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "error": error,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  dynamic totalPayment;
  dynamic pendingMoney;
  dynamic commissionMoney;

  Data({
    this.totalPayment,
    this.pendingMoney,
    this.commissionMoney,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalPayment: json["total_payment"],
        pendingMoney: json["pending_money"],
        commissionMoney: json["commission_money"],
      );

  Map<String, dynamic> toJson() => {
        "total_payment": totalPayment,
        "pending_money": pendingMoney,
        "commission_money": commissionMoney,
      };
}
