import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bigsangrup/model/history_model.dart';
import 'package:bigsangrup/repository/home/home_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../model/commision_charge_model.dart';
import '../../model/lifetime_members_model.dart';
import '../../model/lifetime_subscription.dart';
import '../../model/login_model.dart';
import '../../model/payment_info_model.dart';
import '../../model/transporter_model.dart';
import '../../repository/auth/auth_repository.dart';
import '../../screen/home/phonepay_pg_class.dart';
import '../../static/flutter_toast_message/toast_messge.dart';
import 'package:path/path.dart' as path;


class HomeViewmodel extends ChangeNotifier {
  bool isloading = false;
  HistoryModel? historyModel;
  TextEditingController tddNo = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController date = TextEditingController();
   final TextEditingController slipCopntroller = TextEditingController();
  List<Datum?>? historyTrans;
  TransporterModel? transporterModel;
  Transporter? transporter;
  final ImagePicker _picker = ImagePicker();
  File? uploadpick;
  File? weightImage;
  File? slipImage;
  String? uploadpickUrl;
  String? weightImageUrl;
  String? slipImageUrl;
  PaymentInfoModel? paymentInfoModel;
  LifetimeModel? subscription;
  LifetimeMemberrs? lifetimeMeberModel;
  CommisionModel? commisionCharge;

  // challan Discountform field
  TextEditingController distruckNo = TextEditingController();
  TextEditingController dischallanNo = TextEditingController();
  TextEditingController discashAdvance = TextEditingController();
  TextEditingController distokenchar = TextEditingController();
   File? uploaddischallan;
  File? uploaddisweightImage;
  File? uploaddisslipImage;

  isLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  isLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  Future ComissionView() async {
    isLoadingTrue();
    late bool log = false;
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // var userId = await preferences.getString('userId');

    var res = await HomeRepository().commisionmodel();
    // print(res);
    // if (res["success"] == true) {
     if (res["success"] == true) {
      commisionCharge =CommisionModel.fromJson(res);
      log = true;
    } else {
      print(res);
      // ShowToast(msg: res);
    }
    isLoadingFalse();
    return log;
  }
  filterHistory({sts}) {
    if (sts == "Done") {
      historyTrans =
          historyModel!.data!.where((item) => item.isPaid == 1).toList();
      notifyListeners();
    } else if (sts == "Pending") {
      historyTrans =
          historyModel!.data!.where((item) => item.isPaid != 1).toList();
      notifyListeners();
    }
    //  else if (sts == "Commission Received") {
    //   historyTrans =
    //       historyModel!.data!.where((item) => item.commisionPaid == 1).toList();
    //   notifyListeners();
    // }
    else {
      historyTrans = historyModel!.data;
      notifyListeners();
    }
    notifyListeners();
  }

  Future showhistoryViewmodel() async {
    isLoadingTrue();
    late bool log = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userId = await preferences.getString('userId');

    var res = await HomeRepository().showHistory(userId: userId!);
    // print(res);
    // if (res["success"] == true) {
    historyModel = HistoryModel.fromJson(res);
    notifyListeners();
    log = true;
    // } else {
    //   print(res);
    //   // ShowToast(msg: res);
    // }
    isLoadingFalse();
    return log;
  }

  Future transporterViewmodel() async {
    isLoadingTrue();
    late bool log = false;

    var res = await HomeRepository().transporter();
    // print(res);
    if (res["success"] == true) {
      transporterModel = TransporterModel.fromJson(res);
      log = true;
    } else {
      print(res);
      // ShowToast(msg: res);
    }
    isLoadingFalse();
    return log;
  }
    Future discountaddSlipViewmodel() async {
    isLoadingTrue();
    late bool log = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userId = await preferences.getString('userId');

    var res = await HomeRepository().discountSlipAdd(
        vowner_id: userId!,
        vehicle_no: distruckNo.text,
        transporter_id: transporter!.id.toString(),
        cash_advance: discashAdvance.text,
        token_charge: distokenchar.text,
        total_amnt: "",
        slip_image: uploaddisslipImage == null
            ? ""
            : MultipartFile.fromFileSync(uploaddisslipImage!.path,
                filename: uploaddisslipImage!.path.split('/').last),
        chalana_image: uploaddischallan == null
            ? ""
            : MultipartFile.fromFileSync(uploaddischallan!.path,
                filename: uploaddischallan!.path.split('/').last),
        weight_image: uploaddisweightImage == null
            ? ""
            : MultipartFile.fromFileSync(uploaddisweightImage!.path,
                filename: uploaddisweightImage!.path.split('/').last));
    // print(res);
    if (res["success"] == true) {
      clearSlipDiscount();
      
      // clearslip();
      // showhistoryViewmodel();
      log = true;
      ShowToast(msg: res["message"].toString());
    } else {
      print(res);
      ShowToast(msg: res["error"].toString());
    }
    isLoadingFalse();
    return log;
  }

  clearSlipDiscount() {
    distruckNo.text = "";
    discashAdvance.text = "";
    dischallanNo.text = "";
    distokenchar.text="";
    uploadpick = null;
    uploaddisslipImage = null;
    uploaddischallan = null;
    uploaddisweightImage = null;
    notifyListeners();
  }

  Future addSlipViewmodel({required String price, required String paid_am, required String payment_sts}) async {
    isLoadingTrue();
    late bool log = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userId = await preferences.getString('userId');

    var res = await HomeRepository().addSlip(
        vowner_id: userId!,
        vehicle_no: amount.text,
        transporter_id: transporter!.id.toString(),
        date: DateFormat('yyyy-MM-dd')
            .format(DateFormat('dd-MM-yyyy').parse(date.text)),
        tdsNo: tddNo.text,
        price: price,
        paid_amountt: paid_am,
        paymentSts: payment_sts,
        image: uploadpick == null
            ? ""
            : MultipartFile.fromFileSync(uploadpick!.path,
                filename: uploadpick!.path.split('/').last),
        weightImage: weightImage == null
            ? ""
            : MultipartFile.fromFileSync(weightImage!.path,
                filename: weightImage!.path.split('/').last));
    // print(res);
    if (res["success"] == true) {
      clearSlip();
      clearslip();
      showhistoryViewmodel();
      log = true;
    } else {
      print(res);
      ShowToast(msg: res["error"].toString());
    }
    isLoadingFalse();
    return log;
  }

  clearSlip() {
    date.text = "";
    amount.text = "";
    tddNo.text = "";
    uploadpick = null;
    weightImage = null;
    uploadpickUrl = null;
    weightImageUrl = null;
    notifyListeners();
  }

  Future showhpaymentViewmodel() async {
    isLoadingTrue();
    late bool log = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userId = await preferences.getString('userId');

    var res = await HomeRepository().showPayment(userId: userId!);
    // print(res);
    if (res["success"] == true) {
      paymentInfoModel = PaymentInfoModel.fromJson(res);
      log = true;
    } else {
      print(res);
      // ShowToast(msg: res);
    }
    isLoadingFalse();
    return log;
  }

  Future selecthouseholdAge({required Transporter releast}) async {
   
    transporter = releast;
    slipCopntroller.text = releast.name??"";
    notifyListeners();
  }

  insertFituredImage(BuildContext context, imgName) {
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
                  _pickImage(ImageSource.gallery, imgName);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera, imgName);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _pickImage(ImageSource source, imgName) async {
    final pickedFile = await _picker.pickImage(
        source: source, maxWidth: 400, imageQuality: 45);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final imageSize = await imageFile.length();
      final extension = path.extension(imageFile.path).toLowerCase();
      // ShowToast(msg: extension);
      if (extension == '.jpg' || extension == '.jpeg' || extension == '.png') {
        // &&
        checkImageSize(imageSize, pickedFile, imgName);
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

  checkImageSize(imageSize, pickedFile, imgName) {
    if (imageSize <= 1 * 1024 * 1024) {
      if (imgName == "f") {
        uploadpick = File(pickedFile.path);
      } else if (imgName == 'w') {
        weightImage = File(pickedFile.path);
      }else if(imgName=="ch"){
        slipImage=File(pickedFile.path);
      }else if(imgName=="dch"){
        uploaddisslipImage=File(pickedFile.path);
      }else if(imgName=="dw"){
        uploaddisweightImage=File(pickedFile.path);
      }else if(imgName=="df"){
        uploaddischallan=File(pickedFile.path);
      }

      notifyListeners();
    } else {
      ShowToast(msg: "Image Only Support Less Than 1 MB");
    }
  }

  selectavailableformDate(context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);

      date.text = formattedDate;
    }
    //  else {
    //   Navigator.pop(context);
    // }
  }

  initloadAddslip(Datum data) {
    if (data.transporterId != null &&
        transporterModel!.transporters!.isNotEmpty) {
      transporter = transporterModel!.transporters!.firstWhere(
        (element) => element.id == data.transporterId,
        orElse: () => Transporter(), // Default empty Transporter
      );

      // Make sure you are notifying listeners or refreshing the state in your UI
      notifyListeners();
    }
    amount.text = data.vehicleNo ?? ""; //vechicle Numbner
    // transporter = Transporter(); //transporter
    // print(data.toJson());
    date.text = DateFormat('dd-MM-yyyy')
        .format(DateFormat('yyyy-MM-dd').parse(data.date.toString()));
    tddNo.text = data.tdsNo.toString(); //tddno
    uploadpickUrl = data.imageUrl ?? "";
    weightImageUrl = data.weightImageUrl ?? "";
    // image: uploadpick == null
    //     ? ""
    //     : MultipartFile.fromFileSync(uploadpick!.path,
    //         filename: uploadpick!.path.split('/').last),
    // weightImage: weightImage == null
    //     ? ""
    //     : MultipartFile.fromFileSync(weightImage!.path,
    //         filename: weightImage!.path.split('/').last)
    notifyListeners();
  }
  clearslip() {
      transporter = null;
    amount.text = ""; //vechicle Numbner
    // transporter = Transporter(); //transporter
    // print(data.toJson());
    date.text = "";
    tddNo.text = ""; //tddno
    uploadpickUrl =  "";
    weightImageUrl = "";
    // image: uploadpick == null
    //     ? ""
    //     : MultipartFile.fromFileSync(uploadpick!.path,
    //         filename: uploadpick!.path.split('/').last),
    // weightImage: weightImage == null
    //     ? ""
    //     : MultipartFile.fromFileSync(weightImage!.path,
    //         filename: weightImage!.path.split('/').last)
    notifyListeners();
  }

  Future updateSlipViewmodel({required String slipId}) async {
    // print(amount.text);
    isLoadingTrue();
    late bool log = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userId = await preferences.getString('userId');

    var res = await HomeRepository().updateSlip(
        vowner_id: userId!,
        vehicle_no: amount.text.toString(),
        transporter_id: transporter!.id.toString(),
        date: DateFormat('yyyy-MM-dd')
            .format(DateFormat('dd-MM-yyyy').parse(date.text)),
        tdsNo: tddNo.text,
        image: uploadpick == null
            ? ""
            : MultipartFile.fromFileSync(uploadpick!.path,
                filename: uploadpick!.path.split('/').last),
        weightImage: weightImage == null
            ? ""
            : MultipartFile.fromFileSync(weightImage!.path,
                filename: weightImage!.path.split('/').last),
        slip_id: slipId);
    // debugPrint(res);
    if (res["success"] == true) {
      clearSlip();
      showhistoryViewmodel();
      
      log = true;
    } else {
      ShowToast(msg: res["error"].toString());
      // print(res);
      // ShowToast(msg: res);
    }
    isLoadingFalse();
    return log;
  }

  Future deleteslipViewmodel({required String slipId}) async {
    isLoadingTrue();
    late bool log = false;
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // var userId = await preferences.getString('userId');

    var res = await HomeRepository().deletSlip(
        slipId: slipId);
    // print(res);
    if (res["success"] == true) {
      // clearSlip();
    await  showhistoryViewmodel();
      log = true;
    } else {
      print(res);
      // ShowToast(msg: res);
    }
    isLoadingFalse();
    return log;
  }
  
    Future getAllLifetimeMembers() async {
    isLoadingTrue();
    late bool log = false;
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // var userId = await preferences.getString('userId');

    var res = await HomeRepository().getLifetimeMemberRepo();
    // print(res);
    if (res["success"] == true) {
      // clearSlip();
    // await  showhistoryViewmodel();
    lifetimeMeberModel=LifetimeMemberrs.fromJson(res);
      log = true;
    } else {
      print(res);
      // ShowToast(msg: res);
    }
    isLoadingFalse();
    return log;
  }
    Future showSubscription() async {
    isLoadingTrue();
    late bool log = false;
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // var userId = await preferences.getString('userId');

    var res = await HomeRepository().lifetimeSubscription();
    // print(res);
    if (res["success"] == true) {
      // clearSlip();
    subscription = LifetimeModel.fromJson(res);
    notifyListeners();
      log = true;
    } else {
      print(res);
      // ShowToast(msg: res);
    }
    isLoadingFalse();
    notifyListeners();
    return log;
  }
  Future addSubscription({String? amount,String? payamount,String? paymentress}) async {
    isLoadingTrue();
    late bool log = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userId = await preferences.getString('userId');
  //  await PhonepePg(amount: 500,context: context).init().then((v)async{
  //     for (var i = 0; i < 10; i++) {
  //       print("This is the payment status of the resulth  of the  $v"); 
  //     }
     
  //     if (v) {
    var res=  await HomeRepository().buySubscription(vendrId: userId!,amount:amount??"",payAmount: payamount??"",sts: paymentress);
    
    // print(res);
    if (res["success"] == true) {
      // clearSlip();
    // subscription = LifetimeModel.fromJson(res);
          log = true;
    notifyListeners();

    } else {
      print(res);
      // ShowToast(msg: res);
    }
    //   }
    // });
    
    isLoadingFalse();
    notifyListeners();
    return log;
  }

}
