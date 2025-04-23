// To parse this JSON data, do
//
//     final commisionModel = commisionModelFromJson(jsonString);

import 'dart:convert';

CommisionModel commisionModelFromJson(String str) => CommisionModel.fromJson(json.decode(str));

String commisionModelToJson(CommisionModel data) => json.encode(data.toJson());

class CommisionModel {
    bool? success;
    dynamic error;
    String? message;
    Data? data;

    CommisionModel({
        this.success,
        this.error,
        this.message,
        this.data,
    });

    factory CommisionModel.fromJson(Map<String, dynamic> json) => CommisionModel(
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
    int? id;
    String? commisionKey;
    int? value;
    String? description;
    DateTime? createdAt;
    DateTime? updatedAt;

    Data({
        this.id,
        this.commisionKey,
        this.value,
        this.description,
        this.createdAt,
        this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        commisionKey: json["commision_key"],
        value: json["value"],
        description: json["Description"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "commision_key": commisionKey,
        "value": value,
        "Description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
