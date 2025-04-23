import 'package:bigsangrup/model/profie_model.dart';
import 'package:bigsangrup/viewmodel/profile/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../static/colors.dart';
import '../../../static/custom_elevated_button.dart';
import '../../../static/flutter_toast_message/toast_messge.dart';
import '../../../static/textfield_controller/textfieldValidator.dart';
import '../../../viewmodel/auth/login_viewmodel.dart';
import 'package:go_router/go_router.dart';

import '../../static/appbar_widget.dart';

class AddBankAccount extends StatelessWidget {
  AddBankAccount({super.key});
  final formkeyProfile = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBar(context: context,img: false,title: "Bank Account"),
      //  AppBar(
      //   automaticallyImplyLeading: true,
      //   title: Text('Bank Account',
      //       style: Theme.of(context).textTheme.titleMedium),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox(
            // height: MediaQuery.of(context).size.height * 0.8,
            child: Consumer<ProfileViewmodel>(builder: (context, profile, _) {
              return Form(
                key: formkeyProfile,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),

                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? "Enter Bank Name" : null,
                      controller: profile.bankName,
                      decoration: InputDecoration(
                        labelText: 'Bank Name',
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colo.greycolorCode, width: 1.5),
                          //  BorderSide(
                          //   color: Colo.buttonPrimary,
                          //   width: 2.0,
                          // ),
                        ),
                      ),
                    ),
                     SizedBox(height: 20),
                    // Email Input
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? "Enter Account Holder Number" : null,
                      controller: profile.bankAccountHolder,
                      keyboardType: TextInputType.text,
                      // inputFormatters: <TextInputFormatter>[
                      //   LengthLimitingTextInputFormatter(16),
                      //   FilteringTextInputFormatter.digitsOnly,
                      // ],
                      decoration: InputDecoration(
                        labelText: 'Account Holder Name',
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colo.greycolorCode, width: 1.5),
                          //  BorderSide(
                          //   color: Colo.buttonPrimary,
                          //   width: 2.0,
                          // ),
                        ),
                      ),
                    ),
                   
                    SizedBox(height: 20),
                    // Email Input
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? "Enter Account Number" : null,
                      controller: profile.bankAccountN,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(16),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        labelText: 'Account Number',
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colo.greycolorCode, width: 1.5),
                          //  BorderSide(
                          //   color: Colo.buttonPrimary,
                          //   width: 2.0,
                          // ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Phone Input
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? "Enter IFSC Code" : null,
                      // keyboardType: TextInputType.number,
                      controller: profile.bankIfsc,
                      decoration: InputDecoration(
                        //                       IntlPhoneField(
                        //                   ...
                        //                   onChanged: (phone) {
                        //                     print(countries.firstWhere((element) => element['code'] == phone.countryISOCode)['max_length']);
                        //                   },
                        // ),
                        labelText: 'IFSC code',
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colo.greycolorCode, width: 1.5),
                          //  BorderSide(
                          //   color: Colo.buttonPrimary,
                          //   width: 2.0,
                          // ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // InkWell(
                    //   onTap: () => profile.insertFituredImage(context),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       border: Border.all(color: Colors.grey),
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     height: 150,
                    //     child: Center(
                    //       child: profile.uploadpick != null
                    //           ? Image.file(
                    //               profile.uploadpick!,
                    //             )
                    //           : Column(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: [
                    //                 Text('Upload Featured Image',
                    //                     style: Theme.of(context)
                    //                         .textTheme
                    //                         .bodyMedium),
                    //                 SizedBox(height: 10),
                    //                 Icon(
                    //                   Icons.file_upload_outlined,
                    //                   color: Colo.buttonPrimary,
                    //                   size: 40,
                    //                 ),
                    //               ],
                    //             ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    SizedBox(height: 20),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       "Passbook Image",
                    //       style: Theme.of(context).textTheme.bodySmall,
                    //     ),
                    //     SizedBox(
                    //       height: 32,
                    //       child: ElevatedButton(
                    //           onPressed: () {
                    //             profile.insertFituredImage(context, 'passbook');
                    //           },
                    //           style: ElevatedButton.styleFrom(
                    //             backgroundColor: Colo.primaryColor,
                    //             foregroundColor: Colo.white,
                    //             shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(10.0),
                    //             ),
                    //           ),
                    //           child: Text("Upload")),
                    //     )
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // InkWell(
                    //   // onTap: () => slip.insertFituredImage(context, 'f'),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       border: Border.all(color: Colors.grey),
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     height: 150,
                    //     child: Center(
                    //       child: profile.uploadpassbook != null
                    //           ? Image.file(
                    //               profile.uploadpassbook!,
                    //             )
                    //           : profile.passbookImg != null
                    //               ? Image.network(
                    //                   profile.passbookImg.toString())
                    //               : Column(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.center,
                    //                   children: [
                    //                     Text('Upload PassBook Image',
                    //                         style: Theme.of(context)
                    //                             .textTheme
                    //                             .bodyMedium),
                    //                     const SizedBox(height: 10),
                    //                     const Icon(
                    //                       Icons.file_upload_outlined,
                    //                       color: Colo.buttonPrimary,
                    //                       size: 40,
                    //                     ),
                    //                   ],
                    //                 ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Cheque Image",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(
                          height: 32,
                          child: ElevatedButton(
                              onPressed: () {
                                profile.insertFituredImage(context, 'cheque');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colo.primaryColor,
                                foregroundColor: Colo.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Text("Upload")),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      // onTap: () => slip.insertFituredImage(context, 'w'),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 150,
                        child: Center(
                          child: profile.uploaCheque != null
                              ? Image.file(
                                  profile.uploaCheque!,
                                )
                              : profile.chequeImg != null
                                  ? Image.network(profile.chequeImg.toString())
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Upload Cheque Image',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                        SizedBox(height: 10),
                                        Icon(
                                          Icons.file_upload_outlined,
                                          color: Colo.buttonPrimary,
                                          size: 40,
                                        ),
                                      ],
                                    ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    customElevatedButton(
                      context: context,
                      buttonname: profile.isloading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              "${profile.bankModel == null ? "Submit" : "Update"}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colo.primaryColorSecond),
                            ),
                      onpressed: () {
                        if (formkeyProfile.currentState!.validate()) {
                          if (profile.bankModel == null) {
                            profile.addBankViewmodel().then((v) {
                              if (v) {
                                context.pop();
                                // context
                                //     .pushReplacement('/home', extra: {'id': "0"});
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             NavigationScreen()));
                              }
                            });
                          } else {
                            profile.updateBankViewmodel().then((v) {
                              if (v) {
                                context.pop();
                                // context
                                //     .pushReplacement('/home', extra: {'id': "0"});
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             NavigationScreen()));
                              }
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // SizedBox(
                    //   height: 48,
                    //   width: double.infinity,
                    //   child: signup.isloading
                    //       ? Center(
                    //           child: CircularProgressIndicator(
                    //             color: Colo.buttonPrimary,
                    //           ),
                    //         )
                    //       : ElevatedButton(
                    //           style: ElevatedButton.styleFrom(
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(10),
                    //                 side: BorderSide(
                    //                     color: Colors.transparent)),
                    //             backgroundColor: Colo.buttonPrimary,
                    //             // padding: EdgeInsets.symmetric(vertical: 16),
                    //           ),
                    //           onPressed: () {
                    //             if (formkeySignup.currentState!.validate()) {
                    //               // signup.verifyEmail().then((v) {
                    //               //   if (v) {
                    //               //     signup.verifyOtpSignup().then((v) {
                    //               //       if (v) {
                    //               //         context.push('/otpVerifySignup');

                    //               //         // Navigator.push(
                    //               //         //     context,
                    //               //         //     MaterialPageRoute(
                    //               //         //         builder: (context) =>
                    //               //         //             LoginScreen()));
                    //               //       }
                    //               //     });
                    //               //   }
                    //               // });
                    //             } else {
                    //               ShowToast(msg: "Enter all Field");
                    //             }
                    //           },
                    //           child: Text(
                    //             'Proceed',
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .bodyLarge!
                    //                 .copyWith(
                    //                     fontSize: 18, color: Colors.white),
                    //           ),
                    //         ),
                    // ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
