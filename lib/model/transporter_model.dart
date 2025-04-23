// To parse this JSON data, do
//
//     final transporterModel = transporterModelFromJson(jsonString);

import 'dart:convert';

TransporterModel transporterModelFromJson(String str) =>
    TransporterModel.fromJson(json.decode(str));

String transporterModelToJson(TransporterModel data) =>
    json.encode(data.toJson());

class TransporterModel {
  bool? success;
  dynamic error;
  List<Transporter>? transporters;

  TransporterModel({
    this.success,
    this.error,
    this.transporters,
  });

  factory TransporterModel.fromJson(Map<String, dynamic> json) =>
      TransporterModel(
        success: json["success"],
        error: json["error"],
        transporters: json["transporters"] == null
            ? []
            : List<Transporter>.from(
                json["transporters"]!.map((x) => Transporter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "error": error,
        "transporters": transporters == null
            ? []
            : List<dynamic>.from(transporters!.map((x) => x.toJson())),
      };
}

class Transporter {
  int? id;
  String? name;

  Transporter({
    this.id,
    this.name,
  });

  factory Transporter.fromJson(Map<String, dynamic> json) => Transporter(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
