import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../static/colors.dart';
import '../../../static/custom_elevated_button.dart';
import '../../../static/textfield_controller/textfieldValidator.dart';
import '../../../viewmodel/auth/login_viewmodel.dart';
import '../signup/signup_screen.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  bool _isDropdownVisible = false;

  List<String> emailOptions = [
    'user1@example.com',
    'user2@example.com',
    'user3@example.com'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 20, left: 15, right: 15),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(height: 20,),
                Container(
                   decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colo.primaryColor, width: 2)),
                  child: Image.asset(
                    "assets/bigsangrup_logo.png", // Replace with your logo asset
                    height: 150,
                    // width: 1,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  // flex: 2,
                  child: Consumer<AuthViewModel>(builder: (context, login, _) {
                    return Form(
                      key: formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                              child: Text(
                            "Login your Account",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 18),
                          )),
                          SizedBox(height: 30),
                          // Email Input
                          TextFormField(
                            controller: login.email,
                            validator: (value){
                                const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);

  return value!.isNotEmpty && !regex.hasMatch(value)
      ? 'Enter a valid email address'
      : null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                              labelStyle: Theme.of(context).textTheme.bodySmall,
                              floatingLabelStyle: TextStyle(
                                  color: Colo.primaryColor,
                                  fontWeight: FontWeight.bold),
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colo.primaryColor, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colo.primaryColor, width: 1),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colo.red, width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colo.greycolorCode, width: 1.5),
                                //  BorderSide(
                                //   color: Colo.primaryColor,
                                //   width: 2.0,
                                // ),
                              ),
                              errorMaxLines:
                                  1, // Set the maximum lines for error message
                              errorStyle: TextStyle(height: 0.8),
                            ),
                            onTap: () {
                              // setState(() {
                              //   _showCustomDialog();
                              // });
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            validator: (value) =>
                                value!.isEmpty ? "Enter Password" : null,
                            controller: login.password,
                            obscureText: !login.visible,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  login.visible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  login.passwordVisible(); // Toggle visibility
                                },
                              ),
                              labelText: 'Password',
                              labelStyle: Theme.of(context).textTheme.bodySmall,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colo.primaryColor, width: 1.5),
                              ),
                              floatingLabelStyle: TextStyle(
                                  color: Colo.primaryColor,
                                  fontWeight: FontWeight.bold),
                              fillColor: Colors.white,
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colo.primaryColor, width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colo.primaryColor, width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colo.greycolorCode, width: 1.5),
                                // borderSide: BorderSide(
                                //   color: Colo.primaryColor,
                                //   width: 2.0,
                                // ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          // Log In Button
                          // SizedBox(
                          //     height: 48,
                          //     width: double.infinity,
                          //     child: login.isloading
                          //         ? Center(
                          //             child: CircularProgressIndicator(
                          //               color: Colo.buttonPrimary,
                          //             ),
                          //           )
                          //         :
                          customElevatedButton(
                            context: context,
                            buttonname: login.isloading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Text(
                                    'Log In',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: Colo.primaryColorSecond),
                                  ),
                            onpressed: () {
                              // print("Heelo you cllick button");
                              if (formkey.currentState!.validate()) {
                                login.loginviewmodel().then((v) {
                                  if (v) {
                                    context.go('/home', extra: {'id': "0"});
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
                          SizedBox(
                            height: 4,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                context.push('/forget');
                                // Navigator.ush(context,
                                //     MaterialPageRoute(builder: (context) => SignupScreen()));
                              },
                              child: Text(
                                'Forget Password ?',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                          //   ElevatedButton(
                          //   style: ElevatedButton.styleFrom(
                          //     shape: RoundedRectangleBorder(
                          //         borderRadius:
                          //             BorderRadius.circular(10),
                          //         side: BorderSide(
                          //             color: Colors.transparent)),
                          //     backgroundColor: Colo.buttonPrimary,
                          //     // padding: EdgeInsets.symmetric(vertical: 16),
                          //   ),
                          //   onPressed: child: Text(
                          //     'Log In',
                          //     style: TextStyle(
                          //         fontSize: 16, color: Colors.white),
                          //   ),
                          // ),

                          // ),
                          SizedBox(height: 30),
                          // Forgot Password
                          TextButton(
                                            onPressed: () {
                                              context.push('/signup');
                                              // Navigator.ush(context,
                                              //     MaterialPageRoute(builder: (context) => SignupScreen()));
                                            },
                                            child: Text(
                                              'Create a new account now?',
                                              style: Theme.of(context).textTheme.bodyMedium,
                                            ),
                                          ), // Add some spacing before the bottom text
                          // // Create a new account
                          // Add space at the bottom
                        ],
                      ),
                    );
                  }),
                ),
                
            //  SizedBox(height: 30,),
              Text("Managed By GYANALOK PANDA",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colo.black,fontSize: 10),),
              // 
              ],
            ),
          ),
        ),
      ),
    );
  }
}
