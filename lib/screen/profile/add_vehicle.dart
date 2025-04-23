import 'package:bigsangrup/model/profie_model.dart';
import 'package:bigsangrup/viewmodel/profile/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../static/colors.dart';
import '../../../static/custom_elevated_button.dart';
import '../../../static/flutter_toast_message/toast_messge.dart';
import '../../../static/textfield_controller/textfieldValidator.dart';
import '../../../viewmodel/auth/login_viewmodel.dart';
import 'package:go_router/go_router.dart';

import '../../model/history_model.dart';
import '../../static/aapp_url-endpoint.dart';
import '../../static/appbar_widget.dart';

class AddVehicle extends StatefulWidget {
  final Datum? vehicle;
  AddVehicle({required this.vehicle, super.key});

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // Your function that needs to run after context is available
      Provider.of<ProfileViewmodel>(context, listen: false)
          .initVehicle();
    });
  }

  final formkeyProfile = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context,img: false,title: "Add Vehicle"),
      // appBar: AppBar(
      //   automaticallyImplyLeading: true,
      //   title: Text(
      //     'Add Vehicle',
      //     style: Theme.of(context).textTheme.titleMedium,
      //   ),
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
                          value!.isEmpty ? "Enter Chassis Number" : null,
                      controller: profile.vehicleNumber,
                      decoration: InputDecoration(
                        labelText: 'Chassis Number',
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
                          value!.isEmpty ? "Enter RC Number" : null,
                      controller: profile.licenceNumber,
                      decoration: InputDecoration(
                        labelText: 'RC Number',
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Chassis Image",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () =>
                          profile.insertFituredImage(context, "vehicle"),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 150,
                        child: Center(
                          child: profile.vehicleAdd != null
                              ? Image.file(
                                  profile.vehicleAdd!,
                                )
                              : profile.vehicleimg != null
                                  ? Image.network(
                                      "${profile.vehicleimg}",
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Upload Chassis Image',
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "RC Image",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () =>
                          profile.insertFituredImage(context, "licence"),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 150,
                        child: Center(
                          child: profile.licenceAdd != null
                              ? Image.file(
                                  profile.licenceAdd!,
                                )
                              : profile.licenceimg != null
                                  ? Image.network("${profile.licenceimg}")
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Upload RC Image',
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
                              "${widget.vehicle == null ? "Add" : "Update"}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colo.primaryColorSecond),
                            ),
                      onpressed: () {
                        if (formkeyProfile.currentState!.validate()) {
                          if (widget.vehicle == null) {
                            profile.addVehicleViewmodel().then((v) {
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
                            profile.updateVehicleViewmodel().then((v) {
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
