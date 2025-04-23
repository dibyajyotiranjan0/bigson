// To parse this JSON data, do
//
//     final lifetimeMemberrs = lifetimeMemberrsFromJson(jsonString);

import 'dart:convert';

LifetimeMemberrs lifetimeMemberrsFromJson(String str) => LifetimeMemberrs.fromJson(json.decode(str));

String lifetimeMemberrsToJson(LifetimeMemberrs data) => json.encode(data.toJson());

class LifetimeMemberrs {
    bool? success;
    dynamic error;
    String? message;
    List<Member>? data;

    LifetimeMemberrs({
        this.success,
        this.error,
        this.message,
        this.data,
    });

    factory LifetimeMemberrs.fromJson(Map<String, dynamic> json) => LifetimeMemberrs(
        success: json["success"],
        error: json["error"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Member>.from(json["data"]!.map((x) => Member.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "error": error,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Member {
    int? id;
    String? tdsNo;
    int? transporterId;
    int? vownerId;
    DateTime? date;
    String? image;
    String? weightImage;
    String? price;
    int? paidAmount;
    int? transporterPaidAmount;
    int? comisionIsPaid;
    int? isPaid;
    String? txnId;
    String? paymentStatus;
    String? vehicleNo;
    String? createdAt;
    String? updatedAt;
    dynamic deletedAt;
    VehicleOwner? vehicleOwner;

    Member({
        this.id,
        this.tdsNo,
        this.transporterId,
        this.vownerId,
        this.date,
        this.image,
        this.weightImage,
        this.price,
        this.paidAmount,
        this.transporterPaidAmount,
        this.comisionIsPaid,
        this.isPaid,
        this.txnId,
        this.paymentStatus,
        this.vehicleNo,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.vehicleOwner,
    });

    factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"],
        tdsNo: json["tds_no"],
        transporterId: json["transporter_id"],
        vownerId: json["vowner_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        image: json["image"],
        weightImage: json["weight_image"],
        price: json["price"],
        paidAmount: json["paid_amount"],
        transporterPaidAmount: json["transporter_paid_amount"],
        comisionIsPaid: json["comision_is_paid"],
        isPaid: json["is_paid"],
        txnId: json["txn_id"],
        paymentStatus: json["payment_status"],
        vehicleNo: json["vehicle_no"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        vehicleOwner: json["vehicle_owner"] == null ? null : VehicleOwner.fromJson(json["vehicle_owner"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tds_no": tdsNo,
        "transporter_id": transporterId,
        "vowner_id": vownerId,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "image": image,
        "weight_image": weightImage,
        "price": price,
        "paid_amount": paidAmount,
        "transporter_paid_amount": transporterPaidAmount,
        "comision_is_paid": comisionIsPaid,
        "is_paid": isPaid,
        "txn_id": txnId,
        "payment_status": paymentStatus,
        "vehicle_no": vehicleNo,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "vehicle_owner": vehicleOwner?.toJson(),
    };
}

class VehicleOwner {
    int? id;
    dynamic userId;
    String? name;
    String? email;
    String? password;
    String? textPassword;
    String? phone;
    String? altPhone;
    String? image;
    int? isActive;
    int? isDelete;
    int? isPrimiumMember;
    String? panCard;
    String? panImage;
    String? adharNo;
    String? adharImage;
    String? adharBackImage;
    String? createdAt;
    String? updatedAt;
    dynamic deletedAt;

    VehicleOwner({
        this.id,
        this.userId,
        this.name,
        this.email,
        this.password,
        this.textPassword,
        this.phone,
        this.altPhone,
        this.image,
        this.isActive,
        this.isDelete,
        this.isPrimiumMember,
        this.panCard,
        this.panImage,
        this.adharNo,
        this.adharImage,
        this.adharBackImage,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    factory VehicleOwner.fromJson(Map<String, dynamic> json) => VehicleOwner(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        textPassword: json["text_password"],
        phone: json["phone"],
        altPhone: json["alt_phone"],
        image: json["image"],
        isActive: json["is_active"],
        isDelete: json["is_delete"],
        isPrimiumMember: json["is_primium_member"],
        panCard: json["pan_card"],
        panImage: json["pan_image"],
        adharNo: json["adhar_no"],
        adharImage: json["adhar_image"],
        adharBackImage: json["adhar_back_image"],
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
        "text_password": textPassword,
        "phone": phone,
        "alt_phone": altPhone,
        "image": image,
        "is_active": isActive,
        "is_delete": isDelete,
        "is_primium_member": isPrimiumMember,
        "pan_card": panCard,
        "pan_image": panImage,
        "adhar_no": adharNo,
        "adhar_image": adharImage,
        "adhar_back_image": adharBackImage,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
    };
}
