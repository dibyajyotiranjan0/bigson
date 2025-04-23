// To parse this JSON data, do
//
//     final lifetimeModel = lifetimeModelFromJson(jsonString);

import 'dart:convert';

LifetimeModel lifetimeModelFromJson(String str) => LifetimeModel.fromJson(json.decode(str));

String lifetimeModelToJson(LifetimeModel data) => json.encode(data.toJson());

class LifetimeModel {
    bool? success;
    dynamic error;
    Data? data;

    LifetimeModel({
        this.success,
        this.error,
        this.data,
    });

    factory LifetimeModel.fromJson(Map<String, dynamic> json) => LifetimeModel(
        success: json["success"],
        error: json["error"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "error": error,
        "data": data?.toJson(),
    };
}

class Data {
    dynamic id;
    String? name;
    String? price;
    String? imageUrl;

    Data({
        this.id,
        this.name,
        this.price,
        this.imageUrl,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        imageUrl: json["image_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "image_url": imageUrl,
    };
}
