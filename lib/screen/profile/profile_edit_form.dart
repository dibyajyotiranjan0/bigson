import 'package:bigsangrup/model/profie_model.dart';
import 'package:bigsangrup/static/aapp_url-endpoint.dart';
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

class EditProfile extends StatelessWidget {
  EditProfile({super.key});
  final formkeyProfile = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context,img: false,title: "Edit profile"),
      // appBar: AppBar(
      //   automaticallyImplyLeading: true,
      //   title: Text('Edit profile',
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
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey),
                          color: Colo.primaryColor,
                          // borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: profile.uploadpick != null
                                  ? FileImage(
                                      profile.uploadpick!,
                                    )
                                  : profile.profileimg != null
                                      ? NetworkImage(
                                          "${profile.profileimg}",
                                        )
                                      : AssetImage(""))),
                      height: 150,
                      width: 160,
                      padding: EdgeInsets.all(5),
                      child: Stack(
                        fit: StackFit.loose,
                        children: [
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                  style: IconButton.styleFrom(
                                      backgroundColor: Colo.black),
                                  onPressed: () {
                                    profile.insertFituredImage(
                                        context, "profile");
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    size: 30,
                                    color: Colo.white,
                                  )))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? "Enter Name" : null,
                      controller: profile.name,
                      decoration: InputDecoration(
                        labelText: 'Name',
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
                      validator: (value) => Validator().validateMobile(value),
                      controller: profile.contact,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
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
                      validator: (value) => Validator().validateEmail(value),
                      keyboardType: TextInputType.text,
                      controller: profile.email,
                      decoration: InputDecoration(
                        //                       IntlPhoneField(
                        //                   ...
                        //                   onChanged: (phone) {
                        //                     print(countries.firstWhere((element) => element['code'] == phone.countryISOCode)['max_length']);
                        //                   },zzzz
                        // ),
                        labelText: 'Email',
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
                      // validator: (value) => value!.isEmpty ? "Enter PanCard Number" : null,
                      keyboardType: TextInputType.text,
                      controller: profile.panNum,
                      decoration: InputDecoration(
                        //                       IntlPhoneField(
                        //                   ...
                        //                   onChanged: (phone) {
                        //                     print(countries.firstWhere((element) => element['code'] == phone.countryISOCode)['max_length']);
                        //                   },
                        // ),
                        labelText: 'Pancard',
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
                    TextFormField(
                      // validator: (value) => value!.isEmpty ? "Enter PanCard Number" : null,
                      keyboardType: TextInputType.number,
                      controller: profile.aadharNo,
                      decoration: InputDecoration(
                        //                       IntlPhoneField(
                        //                   ...
                        //                   onChanged: (phone) {
                        //                     print(countries.firstWhere((element) => element['code'] == phone.countryISOCode)['max_length']);
                        //                   },
                        // ),
                        labelText: 'Aadhar',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Pancard Image",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(
                          height: 32,
                          child: ElevatedButton(
                              onPressed: () {
                                profile.insertFituredImage(context, 'pancard');
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
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 150,
                      child: Center(
                        child: profile.pancardPick != null
                            ? Image.file(
                                profile.pancardPick!,
                              )
                            : profile.pancardImage != null
                                ? Image.network(profile.pancardImage.toString())
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Upload Pancard Image',
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
                   //aadhar font
                     SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Aadhar Font Image",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(
                          height: 32,
                          child: ElevatedButton(
                              onPressed: () {
                                profile.insertFituredImage(context, 'aadharF');
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
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 150,
                      child: Center(
                        child: profile.aadharfontFile != null
                            ? Image.file(
                                profile.aadharfontFile!,
                              )
                            : profile.aadharFont != null
                                ? Image.network(profile.aadharFont.toString())
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Upload Aadhar Font Image',
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
                    //aadchar back
                      SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Aadhar Back Image",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(
                          height: 32,
                          child: ElevatedButton(
                              onPressed: () {
                                profile.insertFituredImage(context, 'aadharB');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colo.primaryColor,
                                foregroundColor: Colo.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Text("Upload Aadhar Back Image")),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 150,
                      child: Center(
                        child: profile.aadharbackFile != null
                            ? Image.file(
                                profile.aadharbackFile!,
                              )
                            : profile.aadharBack != null
                                ? Image.network(profile.aadharBack.toString())
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Upload Aadhar Back Image',
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
                    
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(height: 20),

                    customElevatedButton(
                      context: context,
                      buttonname: profile.isloading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              "Update",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colo.primaryColorSecond),
                            ),
                      onpressed: () {
                        if (formkeyProfile.currentState!.validate()) {
                          profile.editprofileViewmodel().then((v) {
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
                    SizedBox(
                      height: 20,
                    ),
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
