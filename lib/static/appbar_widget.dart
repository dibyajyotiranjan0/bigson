import 'package:bigsangrup/static/colors.dart';
import 'package:flutter/material.dart';

AppBar appBar({required BuildContext context,bool img=false,required String title}) {
  return AppBar(
       automaticallyImplyLeading: true,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colo.black),
        shape: Border(
    bottom: BorderSide(
      color: Colors.orange,
      width: 1
    )
  ),
  elevation: 0,
        title:img? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$title",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              height: 50,
              width: 50,
              child: Image.asset(
                "assets/bigsangrup_logo.png",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ):Text(title,style: Theme.of(context).textTheme.titleLarge,),);
}
