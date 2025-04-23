import 'package:bigsangrup/viewmodel/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../static/colors.dart';
import '../../viewmodel/auth/login_viewmodel.dart';

void showLogoutDialog(context,slipId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        // title: Text("Logout"),
        content: Text("Are you sure you want to Delete Challan"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(); // Close the dialog without action
            },
            child: Text("No"),
          ),
          Consumer<AuthViewModel>(builder: (context, login, _) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colo.primaryColor),
              onPressed: () async{
              await  Provider.of<HomeViewmodel>(context,listen: false).deleteslipViewmodel(slipId: slipId).then((v){
                if(v){
                  Navigator.of(context)
                      .pop();
                }
              });
                // login.Logout().then((v) {
                //   if (v) {
                //     context.go('/login');
                //   }
                // });
                // Perform the logout action here
                // Navigator.of(context).pop(); // Close the dialog
                // Add your logout logic here (e.g., navigating to login screen)
              },
              child: Text(
                "Yes",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colo.white),
              ),
            );
          }),
        ],
      );
    },
  );
}
