// To parse this JSON data, do
//
//     final historyModel = historyModelFromJson(jsonString);

import 'dart:convert';

HistoryModel historyModelFromJson(String str) =>
    HistoryModel.fromJson(json.decode(str));

String historyModelToJson(HistoryModel data) => json.encode(data.toJson());

class HistoryModel {
  bool? success;
  dynamic error;
  List<Datum>? data;

  HistoryModel({
    this.success,
    this.error,
    this.data,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        success: json["success"],
        error: json["error"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "error": error,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  int? transporterId;
  String? tdsNo;
  int? vownerId;
  DateTime? date;
  String? vehicleNo;
  String? truckNo;
  dynamic paidAmount;
  int? isPaid;
  dynamic commisionAmount;
  dynamic commisionPaid;
  String? imageUrl;
  String? weightImageUrl;

  Datum({
    this.id,
    this.transporterId,
    this.tdsNo,
    this.vownerId,
    this.date,
    this.vehicleNo,
    this.truckNo,
    this.paidAmount,
    this.isPaid,
    this.commisionAmount,
    this.commisionPaid,
    this.imageUrl,
    this.weightImageUrl,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        transporterId: json["transporter_id"],
        tdsNo: json["tds_no"],
        vownerId: json["vowner_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        vehicleNo: json["vehicle_no"],
        truckNo: json["truck_no"],
        paidAmount: json["paid_amount"],
        isPaid: json["is_paid"],
        commisionAmount: json["commision_amount"],
        commisionPaid: json["commision_paid"],
        imageUrl: json["image_url"],
        weightImageUrl: json["weight_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transporter_id": transporterId,
        "tds_no": tdsNo,
        "vowner_id": vownerId,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "vehicle_no": vehicleNo,
        "truck_no": truckNo,
        "paid_amount": paidAmount,
        "is_paid": isPaid,
        "commision_amount": commisionAmount,
        "commision_paid": commisionPaid,
        "image_url": imageUrl,
        "weight_image_url": weightImageUrl,
      };
}
