import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../model/login_model.dart';
import '../../model/passwordmodel.dart';
import '../../repository/auth/auth_repository.dart';
import '../../static/flutter_toast_message/toast_messge.dart';

class AuthViewModel extends ChangeNotifier {
  bool _visible = false;
  bool isloading = false;

  // final formkeypass = GlobalKey<FormState>();
  bool get visible => _visible;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController ForgetpasEmail = TextEditingController();
  TextEditingController ForgetpasEmailverifyOtp = TextEditingController();
  LogiModel? loginmodoel;
  //resistation
  TextEditingController verifyOTPSignup = TextEditingController();
  TextEditingController nameSignup = TextEditingController();
  TextEditingController emailSignup = TextEditingController();
  TextEditingController contactSignup = TextEditingController();
  TextEditingController passwordSignup = TextEditingController();
  TextEditingController newpassword = TextEditingController();
  TextEditingController retypenewPass = TextEditingController();
  TextEditingController newpasswordlog = TextEditingController();
  TextEditingController retypenewPassloog = TextEditingController();
  bool _visibleSignup = false;
  bool get visibleSignup => _visibleSignup;
  //changepassword
  PasswordModel? forgetPasswordModel;
  TextEditingController forgetPass = TextEditingController();
  String forgetp = "";
  TextEditingController newupdatepassword = TextEditingController();
  TextEditingController retypeupdatepassword = TextEditingController();

  passwordVisible() {
    _visible = !_visible;
    notifyListeners();
  }

  passwordVisibleSignup() {
    _visibleSignup = !_visibleSignup;
    notifyListeners();
  }

  isLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  isLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  registrationViewmodel() async {
    late bool log = false;
    isLoadingTrue();
    var res = await AuthApiRepository().signup(
        name: nameSignup.text,
        mobilleNo: contactSignup.text,
        email: emailSignup.text,
        password: passwordSignup.text);
    // print(res);
    if (res["success"] == true) {
      // loginModel = LoginModel.fromJson(res);
      ShowToast(msg: res["message"].toString() ?? "");
      // print(res);
      // verifyOTPSignup.text = "";
      nameSignup.text = "";
      contactSignup.text = "";
      emailSignup.text = "";
      passwordSignup.text = "";
      log = true;
      clearResistation();
    } else {
      print(res);
      // verifyOTPSignup.text = "";
      ShowToast(msg: res['message']);
    }
    isLoadingFalse();
    return log;
  }

  // Future verifyOtpSignup() async {
  //   late bool log = false;
  //   isLoadingTrue();
  //   var res = await AuthApiRepository()
  //       .verifySignup(email: emailSignup.text, name: nameSignup.text);
  //   // print(res);
  //   if (res["status"] == "error") {
  //     // print("Error");
  //     // print(res["message"]);
  //     ShowToast(msg: res["message"] ?? "");
  //   } else if (res["status"] == "success") {
  //     sendotpModel = SendOtpModel.fromJson(res);
  //     // ShowToast(msg: res["message"] ?? "");
  //     // verifyOTPSignup.text = res["otp"].toString();
  //     // // ShowToast(msg: res["otp"] ?? "");
  //     // print(res);
  //     // forgotPasswordModel = ForgotPasswordModel.fromJson(res);
  //     // ShowToast(msg: forgotPasswordModel!.otp.toString());
  //     log = true;
  //   } else {
  //     // print(res);
  //     ShowToast(msg: res);
  //   }
  //   isLoadingFalse();
  //   return log;
  // }

  loginviewmodel() async {
    late bool log = false;
    isLoadingTrue();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var res = await AuthApiRepository()
        .loginApi(email: email.text, password: password.text);
    // print(res);
    if (res["success"] == true) {
      loginmodoel = LogiModel.fromJson(res);
      log = true;
      email.text = "";
      password.text = "";
      await preferences.setString('userId', loginmodoel!.user!.id.toString());
    } else {
      print(res);
      ShowToast(msg: res['error'].toString());
    }
    isLoadingFalse();
    return log;
  }

  changePassword() async {
    late bool log = false;
    isLoadingTrue();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userId = await preferences.getString('userId');
    var res = await AuthApiRepository().ChangePassword(
        userId: userId ?? forgetp,
        updatePass: newupdatepassword.text,
        retypePass: retypeupdatepassword.text);
    print(res);
    if (res["success"] == true) {
      // print("Error");
      // print(res["message"]);
      retypeupdatepassword.text = "";
      newupdatepassword.text = "";
      ShowToast(msg: res["message"] ?? "");
      log =true;
    } else {
      // print(res);
      // ShowToast(msg: res["message"]);
    }
    isLoadingFalse();
    return log;
  }

  Future validateemail() async {
    bool log = false;
    isLoadingTrue();
    // Future.delayed(Duration(seconds: 2), () {

    var res = await AuthApiRepository().ForgetPassword(email: forgetPass.text);
    forgetPass.text = "";
    if (res["success"] == true) {
      // print("Error");
      // print(res["message"]);
      // ShowToast(msg: res["message"] ?? "");
      forgetp = res['vehicleOwner']['id'].toString();
      log = true;
    } else {
      print(res);
      ShowToast(msg: res["message"]);
    }
    isLoadingFalse();
    return log;
  }

  Future UpdatePassword() async {
    late bool log = false;
    isLoadingTrue();
    // print(retypeupdatepassword.text);
    var res = await AuthApiRepository().ChangePassword(
        userId: forgetp,
        updatePass: newupdatepassword.text,
        retypePass: retypeupdatepassword.text);
    print(res);
    if (res["success"] == true) {
      forgetp = "";
      retypeupdatepassword.text = "";
      newupdatepassword.text = "";
      // print("Error");
      // print(res["message"]);
      ShowToast(msg: res["message"] ?? "");
    } else {
      print(res);
      // ShowToast(msg: res);
    }
    isLoadingFalse();
    return log;
  }

  // changePassword() async {
  //   late bool log = false;
  //   isLoadingTrue();
  //   var res = await AuthApiRepository().passwordChange(
  //       email: ForgetpasEmail.text,
  //       new_password: newpassword.text,
  //       new_confirm_password: retypenewPass.text);
  //   // print(res);
  //   if (res["status"] == "error") {
  //     // print("Error");
  //     // print(res["message"]);
  //     ShowToast(msg: res["errors"].toString() ?? "");
  //   } else if (res["status"] == "success") {
  //     // loginModel = LoginModel.fromJson(res);
  //     ShowToast(msg: res["message"].toString() ?? "");
  //     // ShowToast(msg: res["otp"] ?? "");
  //     print(res);
  //     // forgotPasswordModel = ForgotPasswordModel.fromJson(res);
  //     log = true;
  //   } else {
  //     // print(res);
  //     ShowToast(msg: res);
  //   }
  //   isLoadingFalse();
  //   return log;
  // }

  // Future verifyEmail() async {
  //   late bool log = false;
  //   isLoadingTrue();
  //   var res = await AuthApiRepository().checkEmail(email: emailSignup.text);
  //   // print(res);
  //   if (res["status"] == "warning") {
  //     // print("Error");
  //     // print(res["message"]);
  //     ShowToast(msg: res["message"].toString() ?? "");
  //   } else if (res["status"] == "success") {
  //     // loginModel = LoginModel.fromJson(res);
  //     // ShowToast(msg: res["message"].toString() ?? "");
  //     // ShowToast(msg: res["otp"] ?? "");
  //     // print(res);
  //     // forgotPasswordModel = ForgotPasswordModel.fromJson(res);
  //     log = true;
  //   } else {
  //     // print(res);
  //     ShowToast(msg: res);
  //   }
  //   isLoadingFalse();
  //   return log;
  // }

  // // change password login
  // changePasswordlog() async {
  //   isLoadingTrue();
  //   late bool log = false;
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var email = await preferences.getString('email');

  //   var res = await AuthApiRepository().passwordChange(
  //       email: email!,
  //       new_password: newpasswordlog.text,
  //       new_confirm_password: retypenewPassloog.text);
  //   // print(res);
  //   if (res["status"] == "error") {
  //     // print("Error");
  //     // print(res["message"]);
  //     ShowToast(msg: res["errors"].toString() ?? "");
  //   } else if (res["status"] == "success") {
  //     // loginModel = LoginModel.fromJson(res);
  //     ShowToast(msg: res["message"].toString() ?? "");
  //     // ShowToast(msg: res["otp"] ?? "");
  //     print(res);
  //     // forgotPasswordModel = ForgotPasswordModel.fromJson(res);
  //     log = true;
  //   } else {
  //     // print(res);
  //     ShowToast(msg: res);
  //   }
  //   isLoadingFalse();
  //   return log;
  // }

  Future Logout() async {
    bool log = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('userId');
    await preferences.remove('name');
    await preferences.remove('email');
    await preferences.remove('phone');
    log = true;
    return log;
  }

  clearResistation() {
    nameSignup.text = '';
    contactSignup.text = '';
    emailSignup.text = '';
    passwordSignup.text = '';
    notifyListeners();
  }

  verifyEmail() {}
}
