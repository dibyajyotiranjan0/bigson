import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bigsangrup/model/profie_model.dart';
import 'package:bigsangrup/repository/profile/profile_repository.dart';
import 'package:bigsangrup/static/aapp_url-endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/login_model.dart';
import '../../model/showbank_model.dart';
import '../../model/viewVehiclemodel.dart';
import '../../repository/auth/auth_repository.dart';
import '../../static/flutter_toast_message/toast_messge.dart';
import 'package:path/path.dart' as path;

class ProfileViewmodel extends ChangeNotifier {
  bool isloading = false;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController panNum = TextEditingController();
  TextEditingController aadharNo = TextEditingController();
  ProfileModel? profile;
  final ImagePicker _picker = ImagePicker();
  File? uploadpick;
  String? profileimg;
  File? pancardPick;
  String? pancardImage;
  String? aadharFont;
  File? aadharfontFile;
  String? aadharBack;
  File? aadharbackFile;

  //vehcle
  ShowVehicleModel? vehicleModel;
  TextEditingController vehicleNumber = TextEditingController();
  TextEditingController licenceNumber = TextEditingController();
  File? vehicleAdd;
  File? licenceAdd;
  String? vehicleimg;
  String? licenceimg;
  //bank
  ShowBankModel? bankModel;
  File? uploadpassbook;
  File? uploaCheque;
  TextEditingController bankAccountN = TextEditingController();
  TextEditingController bankAccountHolder = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController bankIfsc = TextEditingController();
  String? passbookImg;
  String? chequeImg;

  isLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  isLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  Future profileViewmodel() async {
    late bool log = false;
    isLoadingTrue();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = await preferences.getString('userId');
    // print(userId);
    var res = await ProfileRepository().viewProfile(userID: userId!);
    if (res["success"] == true) {
      profile = ProfileModel.fromJson(res);
      name.text = profile?.user?.name ?? "";
      email.text = profile?.user?.email ?? "";
      contact.text = profile?.user?.phone ?? "";
      profileimg = profile?.user?.imageUrl ?? "";
      panNum.text = profile?.user?.panCard ?? "";
      pancardImage = profile?.user?.panimagePath ?? "";
      notifyListeners();
      log = true;
    } else {
      print(res);
      // verifyOTPSignup.text = "";
      // ShowToast(msg: res['message']);
    }
    isLoadingFalse();
    return log;
  }

  Future editprofileViewmodel() async {
    late bool log = false;
    isLoadingTrue();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = await preferences.getString('userId');
    var res = await ProfileRepository().editProfile(
        userID: userId!,
        name: name.text,
        email: email.text,
        phone: contact.text,
        pan: panNum.text,
        image: uploadpick == null
            ? ""
            : MultipartFile.fromFileSync(uploadpick!.path,
                filename: uploadpick!.path.split('/').last),
        panImage: pancardPick == null
            ? ""
            : MultipartFile.fromFileSync(pancardPick!.path,
                filename: pancardPick!.path.split('/').last,
                ),
                 aadharFoont: aadharfontFile == null
            ? ""
            : MultipartFile.fromFileSync(aadharfontFile!.path,
                filename: aadharfontFile!.path.split('/').last,
                ),
                 aadharback: aadharbackFile == null
            ? ""
            : MultipartFile.fromFileSync(aadharbackFile!.path,
                filename: aadharbackFile!.path.split('/').last,
                ),aadhar: aadharNo.text);
      // print(res);
    if (res["success"] == true) {
      await profileViewmodel();
      ShowToast(msg: res["error"]);
      log = true;
    } else {
          ShowToast(msg: res["error"]);
      print(res);
      // verifyOTPSignup.text = "";
      // ShowToast(msg: res['message']);
    }
    isLoadingFalse();
    return log;
  }

  insertFituredImage(BuildContext context, String fileName) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Text("Choose the medium of your Image"),
            actions: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Photo Library'),
                onTap: () {
                  _pickImage(ImageSource.gallery, fileName);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera, fileName);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _pickImage(ImageSource source, fileN) async {
    final pickedFile = await _picker.pickImage(
        source: source, maxWidth: 400, imageQuality: 45);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final imageSize = await imageFile.length();
      final extension = path.extension(imageFile.path).toLowerCase();
      // ShowToast(msg: extension);
      if (extension == '.jpg' || extension == '.jpeg' || extension == '.png') {
        // &&
        checkImageSize(imageSize, pickedFile, fileN.toString());
        //()
      }
      // if (extension == '.jpg') {
      //   checkImageSize(imageSize, pickedFile);
      // }
      else {
        ShowToast(msg: "Image Only Support JPG,PNG, JPEG Extension");
        // Show an error message if the image is too large
      }
    } else {
      ShowToast(msg: 'No image selected.');
    }
  }

  checkImageSize(imageSize, pickedFile, String fileName) {
    if (imageSize <= 1 * 1024 * 1024) {
      if (fileName == "profile") {
        uploadpick = File(pickedFile.path);
      } else if (fileName == "vehicle") {
        vehicleAdd = File(pickedFile.path);
      } else if (fileName == "licence") {
        licenceAdd = File(pickedFile.path);
      } else if (fileName == "pancard") {
        pancardPick = File(pickedFile.path);
      } else if (fileName == "passbook") {
        uploadpassbook = File(pickedFile.path);
      } else if (fileName == "cheque") {
        uploaCheque = File(pickedFile.path);
      }else if (fileName == "aadharF") {
        aadharfontFile = File(pickedFile.path);
      }else if (fileName == "aadharB") {
        aadharbackFile = File(pickedFile.path);
      } else {
        ShowToast(msg: "No File Name Selected");
      }
      

      notifyListeners();
    } else {
      ShowToast(msg: "Image Only Support Less Than 1 MB");
    }
  }

  Future showVehicleViewmodel() async {
    late bool log = false;
    isLoadingTrue();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = await preferences.getString('userId');
    var res = await ProfileRepository().showVehicle(userID: userId!);
    if (res["success"] == true) {
      vehicleModel = ShowVehicleModel.fromJson(res);
      // vehicleNumber.text = vehicleModel?.data?.last.vehicleNo ?? "";
      // licenceNumber.text = vehicleModel?.data?.last.licienceNo ?? "";
      log = true;
      // vehicleimg = vehicleModel?.data?.last.vehicleImageUrl;
      // licenceimg = vehicleModel?.data?.last.licienceImageUrl;
      notifyListeners();
    } else {
      print(res);
      // verifyOTPSignup.text = "";
      // ShowToast(msg: res['message']);
    }
    isLoadingFalse();
    return log;
  }
  initVehicle({Datum? vehicle}){
    vehicleNumber.text = vehicle?.vehicleNo ?? "";
      licenceNumber.text = vehicle?.licienceNo ?? "";
      
      vehicleimg = vehicle?.vehicleImageUrl;
      licenceimg = vehicle?.licienceImageUrl;
      notifyListeners();
  }

  Future addVehicleViewmodel() async {
    late bool log = false;
    isLoadingTrue();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = await preferences.getString('userId');
    var res = await ProfileRepository().addVehicle(
        userID: userId!,
        vehicleNu: vehicleNumber.text,
        licenceNu: licenceNumber.text,
        vehicleImg: vehicleAdd == null
            ? ""
            : MultipartFile.fromFileSync(vehicleAdd!.path,
                filename: vehicleAdd!.path.split('/').last),
        licenceImg: licenceAdd == null
            ? ""
            : MultipartFile.fromFileSync(licenceAdd!.path,
                filename: licenceAdd!.path.split('/').last));
    // print(res);
    if (res["success"] == true) {
      showVehicleViewmodel();
      vehicleNumber.text =  "";
      licenceNumber.text =  "";
      
      vehicleimg = null;
      licenceimg = null;
      notifyListeners();
      // ShowToast(msg: "${res[]}")
      log = true;
    } else {
      print(res);
      // verifyOTPSignup.text = "";
      // ShowToast(msg: res['message']);
    }
    isLoadingFalse();
    return log;
  }

  Future showBankViewmodel() async {
    late bool log = false;
    isLoadingTrue();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = await preferences.getString('userId');
    var res = await ProfileRepository().showBankAccount(userID: userId!);
    if (res["success"] == true) {
      bankModel = ShowBankModel.fromJson(res);
      bankAccountN.text = bankModel!.data!.accountNo!.toString();
      bankName.text = bankModel?.data?.bankName ?? "";
      bankIfsc.text = bankModel?.data?.ifcCode ?? "";
      passbookImg = bankModel?.data?.passbookImageUrl ?? "";
      chequeImg = bankModel?.data?.checkImageUrl ?? "";
      bankAccountHolder.text = bankModel?.data?.accountHolderName ?? "";
      // aadharFont= bankModel?.data?. ?? "";
      //     aadharBack= bankModel?.data?.accountHolderName ?? "";
      log = true;
    } else {
      print(res);
      // verifyOTPSignup.text = "";
      // ShowToast(msg: res['message']);
    }
    isLoadingFalse();
    return log;
  }

  Future addBankViewmodel() async {
    late bool log = false;
    isLoadingTrue();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = await preferences.getString('userId');
    var res = await ProfileRepository().addBankAccount(
        userID: userId!,
        bankN: bankName.text,
        accountN: bankAccountN.text,
        ifscNu: bankIfsc.text,
          holderrName: bankAccountHolder.text,
        passbook_image: uploadpassbook == null
            ? ""
            : MultipartFile.fromFileSync(uploadpassbook!.path,
                filename: uploadpassbook!.path.split('/').last),
        check_image: uploaCheque == null
            ? ""
            : MultipartFile.fromFileSync(uploaCheque!.path,
                filename: uploaCheque!.path.split('/').last));
    // print(res);
    if (res["success"] == true) {
      showBankViewmodel();
      log = true;
    } else {
      print(res);
      // verifyOTPSignup.text = "";
      // ShowToast(msg: res['message']);
    }
    isLoadingFalse();
    return log;
  }

  Future updateBankViewmodel() async {
    late bool log = false;
    isLoadingTrue();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = await preferences.getString('userId');
    var res = await ProfileRepository().updateBankAccount(
        id: bankModel!.data!.id!.toString(),
        userID: userId!,
        bankN: bankName.text,
        accountN: bankAccountN.text,
        ifscNu: bankIfsc.text,
        passbook_image: uploadpassbook == null
            ? ""
            : MultipartFile.fromFileSync(uploadpassbook!.path,
                filename: uploadpassbook!.path.split('/').last),
        check_image: uploaCheque == null
            ? ""
            : MultipartFile.fromFileSync(uploaCheque!.path,
                filename: uploaCheque!.path.split('/').last),
                holderrName: bankAccountHolder.text);
    // print(res);
    if (res["success"] == true) {
      await showBankViewmodel();
      log = true;
    } else {
      print(res);
      // verifyOTPSignup.text = "";
      // ShowToast(msg: res['message']);
    }
    isLoadingFalse();
    return log;
  }

  Future updateVehicleViewmodel() async {
    late bool log = false;
    isLoadingTrue();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = await preferences.getString('userId');
    var res = await ProfileRepository().updateVehicle(
        id: vehicleModel!.data!.last!.toString(),
        userID: userId!,
        vehicleNu: vehicleNumber.text,
        licenceNu: licenceNumber.text,
        vehicleImg: vehicleAdd == null
            ? ""
            : MultipartFile.fromFileSync(vehicleAdd!.path,
                filename: vehicleAdd!.path.split('/').last),
        licenceImg: licenceAdd == null
            ? ""
            : MultipartFile.fromFileSync(licenceAdd!.path,
                filename: licenceAdd!.path.split('/').last));
    print(res);
    if (res["success"] == true) {
      showVehicleViewmodel();
      log = true;
    } else {
      print(res);
      // verifyOTPSignup.text = "";
      // ShowToast(msg: res['message']);
    }
    isLoadingFalse();
    return log;
  }
}
