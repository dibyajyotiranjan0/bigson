// To parse this JSON data, do
//
//     final showVehicleModel = showVehicleModelFromJson(jsonString);

import 'dart:convert';

ShowVehicleModel showVehicleModelFromJson(String str) =>
    ShowVehicleModel.fromJson(json.decode(str));

String showVehicleModelToJson(ShowVehicleModel data) =>
    json.encode(data.toJson());

class ShowVehicleModel {
  bool? success;
  dynamic error;
  List<Datum>? data;

  ShowVehicleModel({
    this.success,
    this.error,
    this.data,
  });

  factory ShowVehicleModel.fromJson(Map<String, dynamic> json) =>
      ShowVehicleModel(
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
  int? ownerId;
  String? vehicleNo;
  String? vehicleImageUrl;
  String? licienceNo;
  String? licienceImageUrl;

  Datum({
    this.id,
    this.ownerId,
    this.vehicleNo,
    this.vehicleImageUrl,
    this.licienceNo,
    this.licienceImageUrl,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        ownerId: json["owner_id"],
        vehicleNo: json["vehicle_no"],
        vehicleImageUrl: json["vehicle_image_url"],
        licienceNo: json["licience_no"],
        licienceImageUrl: json["licience_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "owner_id": ownerId,
        "vehicle_no": vehicleNo,
        "vehicle_image_url": vehicleImageUrl,
        "licience_no": licienceNo,
        "licience_image_url": licienceImageUrl,
      };
}
