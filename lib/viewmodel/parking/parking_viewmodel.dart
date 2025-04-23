

import 'package:bigsangrup/repository/parkijng/parking_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/viewVehiclemodel.dart' as vehicle;
import '../../model/parking_list_model.dart';
import '../../model/user_parking_model.dart';
import '../../static/flutter_toast_message/toast_messge.dart';

class ParkingViewmodel extends ChangeNotifier {
  bool isloading = false;
ParkingModel? allParking;
UserparkingModel? myParking;
vehicle.Datum? myVehicle;
 DateTime? selectedDate;
 TimeOfDay? selectedTime;
 ParkingPriceDatum? selectPrice;
  

  isLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  isLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

void selectVehicle(vehicle.Datum? selectVech){
myVehicle =selectVech;
notifyListeners();
}

  Future allParkingViewmodel() async {
    late bool log = false;
    isLoadingTrue();
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? userId = await preferences.getString('userId');
    // print(userId);
    var res = await ParkingRepository().viewAllParking();
    if (res["success"] == true) {
allParking =ParkingModel.fromJson(res);
// print(allParking?.toJson());
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

  Future bookParkingViewmodel({
  String? vehicleno,
  String? parkingid,
  String? parkingdate,
  String? paymentstatus,
  String? parkingpriceid,
  String? parkingdate_2,
  String? amount,}) async {
    // print("  ${vehicleno}  ${parkingid}  ${parkingdate} ${paymentstatus}  ${parkingpriceid}  ${parkingdate_2}  ${amount}");
    late bool log = false;
    isLoadingTrue();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = await preferences.getString('userId');
    // print(userId);
    var res = await ParkingRepository().bookPark(
        userID: userId!,
        vehicle_no: vehicleno,
        parking_id: parkingid,
        parking_date: parkingdate ,
        parking_date_2: parkingdate_2,
        parkingprice_id: parkingpriceid ,
        payment_status: paymentstatus,
        amount: amount);
      print(res);
    if (res["success"] == true) {
      allParkingViewmodel();
      clearPark();
      // await profileViewmodel();
      // ShowToast(msg: res["error"]);
      log = true;
    } else {
          // ShowToast(msg: res["error"]);
      // print(res);
      // verifyOTPSignup.text = "";
      ShowToast(msg: res['message']);
    }
    isLoadingFalse();
    return log;
  }
  clearPark(){
    selectPrice=null;
    selectedDate=null;
    selectedTime=null;
    myVehicle=null;
    notifyListeners();
  }
    Future myParkingViewmodel() async {
    late bool log = false;
    isLoadingTrue();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = await preferences.getString('userId');
    // print(userId);
    var res = await ParkingRepository().myParking(userID: userId!);
    if (res["success"] == true) {
myParking =UserparkingModel.fromJson(res);
print(myParking?.toJson());
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
   Future<void> pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
  firstDate: DateTime(2000),
  lastDate: DateTime(2100),
  builder: (context, child) {
    return Theme(
      data: ThemeData.light().copyWith(
        primaryColor: Colors.blue, // Header color
        // accentColor: Colors.red, // Accent color
        colorScheme: ColorScheme.light(primary: Colors.blue), // Primary color
        buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
      ),
      child: child!,
    );
  },
    );

    if (pickedDate != null) {
      
        selectedDate = pickedDate;
     notifyListeners();
    }
  }
    Future<void> pickTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      
        selectedTime = pickedTime;
      notifyListeners();
    }
  }
  void selectparkingprriice(ParkingPriceDatum? selectPrc){
selectPrice =selectPrc;
notifyListeners();
}

}
