// To parse this JSON data, do
//
//     final showBankModel = showBankModelFromJson(jsonString);

import 'dart:convert';

ShowBankModel showBankModelFromJson(String str) => ShowBankModel.fromJson(json.decode(str));

String showBankModelToJson(ShowBankModel data) => json.encode(data.toJson());

class ShowBankModel {
    bool? success;
    dynamic error;
    String? message;
    Data? data;

    ShowBankModel({
        this.success,
        this.error,
        this.message,
        this.data,
    });

    factory ShowBankModel.fromJson(Map<String, dynamic> json) => ShowBankModel(
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
    int? ownerId;
    String? bankName;
    int? accountNo;
    dynamic accountHolderName;
    String? ifcCode;
    String? passbookImageUrl;
    String? checkImageUrl;

    Data({
        this.id,
        this.ownerId,
        this.bankName,
        this.accountNo,
        this.accountHolderName,
        this.ifcCode,
        this.passbookImageUrl,
        this.checkImageUrl,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        ownerId: json["owner_id"],
        bankName: json["bank_name"],
        accountNo: json["account_no"],
        accountHolderName: json["account_holder_name"],
        ifcCode: json["ifc_code"],
        passbookImageUrl: json["passbook_image_url"],
        checkImageUrl: json["check_image_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "owner_id": ownerId,
        "bank_name": bankName,
        "account_no": accountNo,
        "account_holder_name": accountHolderName,
        "ifc_code": ifcCode,
        "passbook_image_url": passbookImageUrl,
        "check_image_url": checkImageUrl,
    };
}
