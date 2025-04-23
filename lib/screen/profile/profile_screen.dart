import 'package:bigsangrup/screen/profile/profile_edit_form.dart';
import 'package:bigsangrup/screen/profile/profile_widget.dart';
import 'package:bigsangrup/static/aapp_url-endpoint.dart';
import 'package:bigsangrup/static/colors.dart';
import 'package:bigsangrup/static/flutter_toast_message/toast_messge.dart';
import 'package:bigsangrup/viewmodel/auth/login_viewmodel.dart';
import 'package:bigsangrup/viewmodel/profile/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../static/appbar_widget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // Your function that needs to run after context is available
      Provider.of<ProfileViewmodel>(context, listen: false).showBankViewmodel();
    });
  }

  @override
  Widget build(BuildContext context) {
    // var prof = Provider.of<ProfileViewmodel>(context, listen: false);
    void _showLogoutDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Logout"),
            content: Text("Are you sure you want to log out?"),
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
                  onPressed: () {
                    login.Logout().then((v) {
                      if (v) {
                        context.go('/login');
                      }
                    });
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

    return Scaffold(
      appBar:  appBar(context: context,img: true,title: "Profile"),
  //     appBar: AppBar(
  //        shape: Border(
  //   bottom: BorderSide(
  //     color: Colors.orange,
  //     width: 1
  //   )
  // ),
  // elevation: 4,
  //       automaticallyImplyLeading: false,
  //       centerTitle: true,
  //       title: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Text(
  //             "Profile",
  //             style: Theme.of(context).textTheme.titleLarge,
  //           ),
  //           SizedBox(
  //             width: 10,
  //           ),
  //           SizedBox(
  //             height: 50,
  //             width: 50,
  //             child: Image.asset(
  //               "assets/bigsangrup_logo.png",
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
     
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Consumer<ProfileViewmodel>(builder: (context, proile, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Card
                SizedBox(
                  height: 10,
                ),
                profileWidget(),
                SizedBox(height: 20),

                // Exam Management Section
                SizedBox(height: 10),

                Column(
                  children: [
                    // Divider(
                    //   thickness: 1,
                    //   color: Colors.black12,
                    // ),
                    ListTile(
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        leading:
                            // Image.asset(
                            //   "assets/logo/delete.png",
                            //   height: 30,
                            //   width: 30,
                            //   color: Colors.grey,
                            Icon(
                          Icons.lock_open_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                        minLeadingWidth: 0,
                        titleTextStyle: Theme.of(context).textTheme.bodyMedium,
                        title: Text('Change Password'),
                        onTap: () {
                          context.push('/profie/changePassword',
                              extra: {'id': "3"});
                        }),
                    const Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Divider(
                        thickness: 1,
                        color: Colors.black12,
                      ),
                    ),
                    ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      leading:
                          // Image.asset(
                          //   "assets/logo/delete.png",
                          //   height: 30,
                          //   width: 30,
                          //   color: Colors.grey,
                          const Icon(
                        Icons.account_balance_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
                      title: Text('Bank'),
                      onTap: () {
                        context.push('/profie/allbank', extra: {'id': "3",'book':false});
                      },
                    ),
                     const Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Divider(
                        thickness: 1,
                        color: Colors.black12,
                      ),
                    ),
                    ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      leading:
                          // Image.asset(
                          //   "assets/logo/delete.png",
                          //   height: 30,
                          //   width: 30,
                          //   color: Colors.grey,
                          const Icon(
                        Icons.local_taxi_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
                      title: Text('Vehicle'),
                      onTap: () {
                        context.push('/profie/vehicle', extra: {'id': "3",'book':false});
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 50),
                      child: const Divider(
                        thickness: 1,
                        color: Colors.black12,
                      ),
                    ),//viewroute
                       ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      leading:
                          // Image.asset(
                          //   "assets/logo/delete.png",
                          //   height: 30,
                          //   width: 30,
                          //   color: Colors.grey,
                          const Icon(
                        Icons.currency_rupee_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
                      title:const Text('Rate Info'),
                      onTap: () {
                        context.push('/profie/viewroute', extra: {'id': "3"});
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 50),
                      child: const Divider(
                        thickness: 1,
                        color: Colors.black12,
                      ),
                    ),//
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      leading:
                          // Image.asset(
                          //   "assets/logo/delete.png",
                          //   height: 30,
                          //   width: 30,
                          //   color: Colors.grey,
                          Icon(
                        Icons.person_pin_circle_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
                      title: Text('Parking Assistance'),
                      onTap: () {
                        // ShowToast(msg: "Coming Soon...");
                         context.push('/home/parking', extra: {'id': "3"});
                      },
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.black12,
                    ),
                      ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      leading: Icon(
                        Icons.lock_outline,
                        color: Colors.black,
                        size: 30,
                      ),
                      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
                      title: Text('Privacy Policy'),
                      onTap: () {
                      context.push('/profie/web',
                              extra: {'id': "3",'url':AppUrl.privacy_policy});
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 50),
                      child: Divider(
                        thickness: 1,
                        color: Colors.black12,
                      ),
                    ),
                      ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      leading: Icon(
                        Icons.description_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
                      title: Text('Terms & Conditions'),
                      onTap: () {
                          context.push('/profie/web',
                              extra: {'id': "3",'url':AppUrl.terms});
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 50),
                      child: Divider(
                        thickness: 1,
                        color: Colors.black12,
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      leading: Icon(
                        Icons.delete_sweep_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
                      title: Text('Data Deletion'),
                      onTap: () {
                           context.push('/profie/web',
                              extra: {'id': "3",'url':AppUrl.delition});
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 50),
                      child: Divider(
                        thickness: 1,
                        color: Colors.black12,
                      ),
                    ),
                  
                  

                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      leading: Icon(
                        Icons.logout_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
                      title: Text('Logout'),
                      onTap: () {
                        _showLogoutDialog(context);

                        // showDeleteAccountDialog(
                        //     context,
                        //     Provider.of<HomeViewModel>(context, listen: false)
                        //             .profile
                        //             ?.data!
                        //             .email ??
                        //         "");

                        // context.push('/profie/deleteAc', extra: {
                        //   'id': '3',
                        //   'deleteEmail':
                        //       Provider.of<HomeViewModel>(context, listen: false)
                        //               .profile
                        //               ?.data!
                        //               .email ??
                        //           ""
                        // });
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 50),
                      child: Divider(
                        thickness: 1,
                        color: Colors.black12,
                      ),
                    ),
                  ],
                )
              ],
            );
          })
          // snapshot.data  :- get your object which is pass from your downloadData() function

          ),
    );
  }

  // Method to build performance cards (e.g. Accuracy, Avg Time Per Question)
  Widget _buildStatCard(
      String value, String subText, String title, Color color) {
    return Expanded(
      child: Container(
        height: 100,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
            SizedBox(height: 8),
            Text(
              subText,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build small attempted, correct, incorrect cards
  Widget _buildAttemptedCard(String value, String title) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
