
import 'dart:convert' show base64Encode, jsonEncode, utf8;
import 'dart:developer';

import 'package:bigsangrup/viewmodel/home/home_viewmodel.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:provider/provider.dart';

class PhonepePg {
  double amount;
  // BuildContext context;
  PhonepePg({ required this.amount});
  String marchentId = "M22ISAYPRL4MV"; //PGTESTPAYUAT86
  // String salt = "96434309-7796-489d-8924-ab56988a6076";
  String salt = "7cb91255-8fc6-4db3-ac20-04c097dc78f1";
  int saltIndex = 1;
  String callbackURL = "https://www.webhook.site/callback-url";
  String apiEndPoint = "/pg/v1/pay";

  // this si sthe initial of requirement to instaall phomnepay PG in this response is design to versatile result where use has 
  //try to transation of X amount they have to use this and and init function where the return oif True can veryfy them it is s a valid trasation 
  // and they have to further move to the  api opf calling backewwnd 


  Future<bool> init() async{
    var returnV =false;
   returnV= await PhonePePaymentSdk.init("PRODUCTION", null, marchentId, true).then((val) async{ //UAT_SIM
      // print('PhonePe SDK Initialized - $val');
    return await startTransaction(amount: amount);
    // log(returnV.toString());
    // return true;
    }).catchError((error) {
      print('PhonePe SDK error - $error');
      returnV= false;
    });
    return returnV;
  }
// thi sis the trasation function of the phonepay where merchant is is PGTESTPAYUAT86 , salt id 96434309-7796-489d-8924-ab56988a6076 for  testing perposes
// in the case of real transation you have to chjange both of merchantid and salt
  Future<bool> startTransaction({required double amount}) async{
    var ret =false;
    Map body = {
  "merchantId": marchentId,
  "merchantTransactionId": DateTime.now().millisecondsSinceEpoch.toString(),
  "merchantUserId": "MUID123",
  "amount": 100*amount.toInt(),
  "mobileNumber": "8658478536",
  "callbackUrl": "https://webhook.site/callback-url",
  "paymentInstrument": {
    "type": "PAY_PAGE"
  //   "type": "UPI_INTENT",
  //   "targetApp": "com.phonepe.app"
  // },
  // "deviceContext": {
  //   "deviceOS": "ANDROID"
  }
};
    // log(body.toString());
    // base64
    // String bodyEncoded = base64Encode(utf8.encode(jsonEncode(body)));
    // checksum =
    // base64Body + apiEndPoint + salt
    // var byteCodes = utf8.encode(bodyEncoded + apiEndPoint + salt);
    // sha256
    // String checksum = "${sha256.convert(byteCodes).toString()}###$saltIndex";
String bodyBase64 = base64Encode(utf8.encode(jsonEncode(body)));

  // Generate checksum
  String checksumData = bodyBase64 + apiEndPoint + salt;
  String checksum = sha256.convert(utf8.encode(checksumData)).toString() + "###1";
  try {
   await PhonePePaymentSdk.startTransaction(bodyBase64, callbackURL, checksum, "com.transporter.bigsangroup").then((val){
  // log("Payment sucess: $v");
  //     log("Thi sis the sucess message off the payment gateway now you build accorrding to your requirement");
         if (val != null) {
            String status = val['status'].toString();
            String error = val['error'].toString();

            if (status == 'SUCCESS') {
              // Provider.of<HomeViewmodel>(context, listen: false).addSubscription();
              var result = "Flow complete - status : SUCCESS";
              ret =true;
print(result);
            //  await checkStatus();
            } else {
              
              var result =
              "Flow complete - status : $status and error $error";
              print(result);
            }
          } else {
            
            var result = "Flow Incomplete";
            print(result);
          }
   });
   
    //  if (result!["status"]=="SUCCESS") {
    //   print("Thi sis the sucess message off the payment gateway now you build accorrding to your requirement");
    //    ret= true;
    //  }
  } catch (e) {
     log("error: $e");
  }

  return ret; 
  }

}
