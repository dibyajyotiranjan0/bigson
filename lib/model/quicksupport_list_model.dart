// To parse this JSON data, do
//
//     final quickSupport = quickSupportFromJson(jsonString);

import 'dart:convert';

QuickSupport quickSupportFromJson(String str) => QuickSupport.fromJson(json.decode(str));

String quickSupportToJson(QuickSupport data) => json.encode(data.toJson());

class QuickSupport {
    bool? success;
    dynamic error;
    List<Datum>? data;

    QuickSupport({
        this.success,
        this.error,
        this.data,
    });

    factory QuickSupport.fromJson(Map<String, dynamic> json) => QuickSupport(
        success: json["success"],
        error: json["error"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "error": error,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? id;
    int? ownerId;
    String? phoneNumber;
    String? text;
    String? vehicleNo;
    int? status;
    String? createdAt;

    Datum({
        this.id,
        this.ownerId,
        this.phoneNumber,
        this.text,
        this.vehicleNo,
        this.status,
        this.createdAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        ownerId: json["owner_id"],
        phoneNumber: json["phone_number"],
        text: json["text"],
        vehicleNo: json["vehicle_no"],
        status: json["status"],
        createdAt: json["created_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "owner_id": ownerId,
        "phone_number": phoneNumber,
        "text": text,
        "vehicle_no": vehicleNo,
        "status": status,
        "created_at": createdAt,
    };
}
