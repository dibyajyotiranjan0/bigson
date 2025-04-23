import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../static/appbar_widget.dart';
import '../../../static/colors.dart';
import '../../../static/flutter_toast_message/toast_messge.dart';
import '../../../viewmodel/auth/login_viewmodel.dart';
import 'package:go_router/go_router.dart';

class ChangePassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context,img: false,title: "Change Password"),
      // appBar: AppBar(
      //   automaticallyImplyLeading: true,
      //   title: Text('Change Password',
      //       style: Theme.of(context).textTheme.titleMedium),
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .7,
          child: Consumer<AuthViewModel>(builder: (context, login, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50), // Add some space at the top

                    // "Place Ads - Buy Cheap" Text

                    // Email Input
                    // Password Input

                    SizedBox(height: 20),
                    TextFormField(
                      controller: login.newupdatepassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        floatingLabelStyle: TextStyle(
                            color: Colo.buttonPrimary,
                            fontWeight: FontWeight.bold),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colo.buttonPrimary, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                            // borderSide: BorderSide(
                            //   color: Colo.buttonPrimary,
                            //   width: 2.0,
                            // ),
                            ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: login.retypeupdatepassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: Theme.of(context).textTheme.bodySmall,
                        floatingLabelStyle: TextStyle(
                            color: Colo.buttonPrimary,
                            fontWeight: FontWeight.bold),
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colo.buttonPrimary, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                            // borderSide: BorderSide(
                            //   color: Colo.buttonPrimary,
                            //   width: 2.0,
                            // ),
                            ),
                      ),
                    ),
                    SizedBox(height: 30),
                    // Log In Button
                    SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.transparent)),
                          backgroundColor: Colo.buttonPrimary,
                          // padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          if (login.newupdatepassword.text != "" &&
                              login.newupdatepassword.text.length >= 8) {
                            if (login.newupdatepassword.text ==
                                login.retypeupdatepassword.text) {
                              login.changePassword().then((v) {
                                if (v) {
                                  // context.push('/login');
                                  context.pop();
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => LoginScreen()));
                                }
                              });
                            } else {
                              ShowToast(msg: "Password Not Match");
                            }
                          } else {
                            ShowToast(msg: "Enter 8 Character");
                          }
                        },
                        child: Text(
                          'Change password',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Forgot Password
                    // Add some spacing before the bottom text
                    // Create a new account
                    // Add space at the bottom
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
