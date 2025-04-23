// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    bool? success;
    dynamic error;
    User? user;
    PrimumUser? primumUser;

    ProfileModel({
        this.success,
        this.error,
        this.user,
        this.primumUser,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        success: json["success"],
        error: json["error"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        primumUser: json["primumUser"] == null ? null : PrimumUser.fromJson(json["primumUser"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "error": error,
        "user": user?.toJson(),
        "primumUser": primumUser?.toJson(),
    };
}

class PrimumUser {
    int? lifetimeOfferAmmount;
    int? paymentAmount;
    String? paymentStatus;
    String? txnId;

    PrimumUser({
        this.lifetimeOfferAmmount,
        this.paymentAmount,
        this.paymentStatus,
        this.txnId,
    });

    factory PrimumUser.fromJson(Map<String, dynamic> json) => PrimumUser(
        lifetimeOfferAmmount: json["lifetimeOffer_ammount"],
        paymentAmount: json["payment_amount"],
        paymentStatus: json["payment_status"],
        txnId: json["txn_id"],
    );

    Map<String, dynamic> toJson() => {
        "lifetimeOffer_ammount": lifetimeOfferAmmount,
        "payment_amount": paymentAmount,
        "payment_status": paymentStatus,
        "txn_id": txnId,
    };
}

class User {
    int? id;
    String? name;
    String? email;
    String? phone;
    dynamic altPhone;
    String? panCard;
    String? adharNo;
    String? adharImage;
    String? adharBackImage;
    String? imageUrl;
    String? panimagePath;

    User({
        this.id,
        this.name,
        this.email,
        this.phone,
        this.altPhone,
        this.panCard,
        this.adharNo,
        this.adharImage,
        this.adharBackImage,
        this.imageUrl,
        this.panimagePath,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        altPhone: json["alt_phone"],
        panCard: json["pan_card"],
        adharNo: json["adhar_no"],
        adharImage: json["adhar_image"],
        adharBackImage: json["adhar_back_image"],
        imageUrl: json["image_url"],
        panimagePath: json["panimagePath"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "alt_phone": altPhone,
        "pan_card": panCard,
        "adhar_no": adharNo,
        "adhar_image": adharImage,
        "adhar_back_image": adharBackImage,
        "image_url": imageUrl,
        "panimagePath": panimagePath,
    };
}
