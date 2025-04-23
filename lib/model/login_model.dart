// To parse this JSON data, do
//
//     final logiModel = logiModelFromJson(jsonString);

import 'dart:convert';

LogiModel logiModelFromJson(String str) => LogiModel.fromJson(json.decode(str));

String logiModelToJson(LogiModel data) => json.encode(data.toJson());

class LogiModel {
  bool? success;
  dynamic error;
  String? message;
  String? token;
  User? user;

  LogiModel({
    this.success,
    this.error,
    this.message,
    this.token,
    this.user,
  });

  factory LogiModel.fromJson(Map<String, dynamic> json) => LogiModel(
        success: json["success"],
        error: json["error"],
        message: json["message"],
        token: json["token"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "error": error,
        "message": message,
        "token": token,
        "user": user?.toJson(),
      };
}

class User {
  int? id;
  dynamic userId;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? altPhone;
  int? isActive;
  int? isDelete;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  User({
    this.id,
    this.userId,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.altPhone,
    this.isActive,
    this.isDelete,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        altPhone: json["alt_phone"],
        isActive: json["is_active"],
        isDelete: json["is_delete"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "alt_phone": altPhone,
        "is_active": isActive,
        "is_delete": isDelete,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
