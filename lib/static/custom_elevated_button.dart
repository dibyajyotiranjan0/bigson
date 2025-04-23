import 'package:bigsangrup/static/colors.dart';
import 'package:flutter/material.dart';

Widget customElevatedButton(
    {required BuildContext context,
    required Widget buttonname,
    Function()? onpressed}) {
  return Container(
      height: 50,
      width: double.maxFinite,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            // Colors.yellow, Color(0xffad9c00)
            Colo.buttonSecondPrim,
            // Colo.buttonSecondPrim,
            Colo.buttonPrimary,
            // Colo.buttonSecondPrim,
            Colo.buttonSecondPrim,
            // Color(0xFFE6D0AE),
            // Color(0xFFD1AE7E)
            // A secondary color for the gradient
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          // stops: [0.3, 0.7, 0.2],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
          onPressed: onpressed,
          style: ElevatedButton.styleFrom(
            // foregroundColor: Colo.white,
            // surfaceTintColor: Colors.transparent,
            // disabledBackgroundColor: Colo.primaryColor,
            // disabledForegroundColor: Colo.black,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(20), // Rounded corners
            // ),
            // shape: MaterialStatePropertyAll(RoundedRectangleBorder(

            //     borderRadius: BorderRadius.circular(15),
            //     side: BorderSide(color: Colors.black38))),
            textStyle: TextStyle(fontSize: 18, color: Colo.white),
          ),
          child: buttonname));
}
