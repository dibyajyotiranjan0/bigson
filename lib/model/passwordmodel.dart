// To parse this JSON data, do
//
//     final passwordModel = passwordModelFromJson(jsonString);

import 'dart:convert';

PasswordModel passwordModelFromJson(String str) =>
    PasswordModel.fromJson(json.decode(str));

String passwordModelToJson(PasswordModel data) => json.encode(data.toJson());

class PasswordModel {
  bool success;
  String message;
  VehicleOwner vehicleOwner;

  PasswordModel({
    required this.success,
    required this.message,
    required this.vehicleOwner,
  });

  factory PasswordModel.fromJson(Map<String, dynamic> json) => PasswordModel(
        success: json["success"],
        message: json["message"],
        vehicleOwner: VehicleOwner.fromJson(json["vehicleOwner"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "vehicleOwner": vehicleOwner.toJson(),
      };
}

class VehicleOwner {
  int id;
  String email;

  VehicleOwner({
    required this.id,
    required this.email,
  });

  factory VehicleOwner.fromJson(Map<String, dynamic> json) => VehicleOwner(
        id: json["id"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
      };
}
