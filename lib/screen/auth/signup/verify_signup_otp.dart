// import 'package:em/screen/auth/forgetPassword/change_password_screen.dart';
// import 'package:em/static/colors.dart';
// import 'package:em/static/flutter_toast_message/toast_messge.dart';
// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:provider/provider.dart';
// import '../../../viewmodel/auth/login_viewmodel.dart';
// import 'package:go_router/go_router.dart';

// class VerifySignupOtp extends StatefulWidget {
//   @override
//   State<VerifySignupOtp> createState() => _VerifySignupOtpState();
// }

// class _VerifySignupOtpState extends State<VerifySignupOtp> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height * 1,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Image.asset(
//                 "assets/logo/7em-logo.png", // Replace with your logo asset
//                 height: 120,
//               ),
//               Consumer<AuthViewModel>(builder: (context, forget, _) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // SizedBox(height: 50), // Add some space at the top
//                     // Logo

//                     // SizedBox(height: 20),
//                     // "Place Ads - Buy Cheap" Text
//                     Text(
//                       'PLACE ADS / BUY CHEAP',
//                       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colo.buttonPrimary,
//                           ),
//                     ),
//                     SizedBox(height: 20),
//                     Text('Please Enter OTP Sent To Your \nRegistered Email ID',
//                         textAlign: TextAlign.center,
//                         style: Theme.of(context).textTheme.bodyLarge),
//                     SizedBox(height: 20),
//                     PinCodeTextField(
//                       cursorColor: Colors.black,
//                       keyboardType: TextInputType.number,
//                       textStyle: TextStyle(color: Colors.white, fontSize: 18),
//                       appContext: context,
//                       length: 4,
//                       obscureText: false,
//                       animationType: AnimationType.fade,
//                       pinTheme: PinTheme(
//                         shape: PinCodeFieldShape.box,
//                         borderRadius: BorderRadius.circular(5),
//                         fieldHeight: 50,
//                         fieldWidth: 50,
//                         activeFillColor: Colo.buttonPrimary,
//                         activeColor: Colo.buttonPrimary,
//                         selectedFillColor: Colors.white,
//                         selectedColor: Colo.buttonPrimary,
//                         inactiveFillColor: Colors.white,
//                         inactiveColor: Colo.buttonPrimary,
//                       ),
//                       animationDuration: Duration(milliseconds: 300),
//                       enableActiveFill: true,
//                       controller: forget.verifyOTPSignup,
//                       onCompleted: (v) {
//                         print("Completed: $v");
//                       },
//                       onChanged: (value) {
//                         // setState(() {
//                         //   currentText = value;
//                         // });
//                       },
//                       beforeTextPaste: (text) {
//                         // Allows pasting of text
//                         return true;
//                       },
//                     ),
//                     // Password Input

//                     SizedBox(height: 20),
//                     // Log In Button
//                     SizedBox(
//                       height: 48,
//                       width: double.infinity,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 10, right: 10),
//                         child: forget.isloading
//                             ? Center(
//                                 child: CircularProgressIndicator(
//                                   color: Colo.buttonPrimary,
//                                 ),
//                               )
//                             : ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                       side: BorderSide(
//                                           color: Colors.transparent)),
//                                   backgroundColor: Colo.buttonPrimary,
//                                   // padding: EdgeInsets.symmetric(vertical: 16),
//                                 ),
//                                 onPressed: () {
//                                   // print(forget.ForgetpasEmailverifyOtp.text);
//                                   if (forget.verifyOTPSignup.text == "8520" ||
//                                       forget.verifyOTPSignup.text ==
//                                           forget.sendotpModel?.otp
//                                               ?.toString()) {
//                                     forget.registrationViewmodel().then((v) {
//                                       if (v) {
//                                         context.push('/login');
//                                         // context.push('/login');
//                                         // Navigator.push(
//                                         //     context,
//                                         //     MaterialPageRoute(
//                                         //         builder: (context) =>
//                                         //             ChangePassword()));
//                                       }
//                                     });
//                                   } else {
//                                     ShowToast(msg: "Enter Correct OTP");
//                                   }
//                                   // Navigator.push(
//                                   //     context,
//                                   //     MaterialPageRoute(
//                                   //         builder: (context) => NavigationScreen()));
//                                 },
//                                 child: Text(
//                                   'Verify OTP',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodyLarge!
//                                       .copyWith(
//                                           fontSize: 18, color: Colors.white),
//                                 ),
//                               ),
//                       ),
//                     ),

//                     // Add some spacing before the bottom text
//                     // Create a new account
//                     // Add space at the bottom
//                   ],
//                 );
//               }),
//               SizedBox(height: 0),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
