import 'package:bigsangrup/model/quicksupport_list_model.dart';
import 'package:bigsangrup/repository/support/support_report.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupportViewmodel extends ChangeNotifier {
  bool isloading = false;
  QuickSupport? support;
  
 TextEditingController phone =TextEditingController();

 TextEditingController query =TextEditingController();

 TextEditingController vechicleno =TextEditingController();
 isLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  isLoadingFalse() {
    isloading = false;
    notifyListeners();
  }
  Future supportViewmodel() async {
    late bool log = false;
    isLoadingTrue();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = await preferences.getString('userId');
    var res = await SupportRepository().viewAllsupport(userID: userId!);
    if (res["success"] == true) {
      support = QuickSupport.fromJson(res);
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
  
  Future addSupportViewmodel() async {
    late bool log = false;
    isLoadingTrue();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = await preferences.getString('userId');
    var res = await SupportRepository().addSupport(userID: userId!,phoneNo: phone.text.toString(),vehicleNo: vechicleno.text.toString(),query: query.text.toString());
    if (res["success"] == true) {
supportViewmodel();
phone.text="";
vechicleno.text ="";
query.text ="";
notifyListeners();
      // bankModel = ShowBankModel.fromJson(res);
      // bankAccountN.text = bankModel!.data!.accountNo!.toString();
      // bankName.text = bankModel?.data?.bankName ?? "";
      // bankIfsc.text = bankModel?.data?.ifcCode ?? "";
      // passbookImg = bankModel?.data?.passbookImageUrl ?? "";
      // chequeImg = bankModel?.data?.checkImageUrl ?? "";
      // bankAccountHolder.text = bankModel?.data?.accountHolderName ?? "";
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
  
}