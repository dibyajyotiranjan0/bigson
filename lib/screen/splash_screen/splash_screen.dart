import 'dart:async';
import 'package:bigsangrup/screen/home/homeScreen.dart';
import 'package:bigsangrup/static/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/login/login_screen.dart';
import '../bootom_navigation.dart/botom_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isAnimated = false;

  @override
  void initState() {
    super.initState();
    // Start the animation after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(Duration(seconds: 3), () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        var userId = await preferences.getString('userId');
        if (userId != null) {
          context.go('/home', extra: {'id': "0"});

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => NavigationScreen(
          //               child: HomeScreen(),
          //               index: 0,
          //             )));
        } else {
          context.go('/login');
          //   //   // Navigator.push(
          //   //   //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: SizedBox(
                  height: 250,
                  width: 250,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colo.primaryColor, width: 2)),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Image.asset(
                        "assets/bigsangrup_logo.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  )),
            ),
          ),
       Padding(
         padding: const EdgeInsets.only(bottom: 5),
         child: Center(child: Text("Managed By GYANALOK PANDA",style: Theme.of(context).textTheme.bodySmall,),),
       ),
              // SizedBox(height: 5,)
        ],
      ),
    );
  }
}
