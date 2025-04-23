import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import '../../static/back_to_close/systum_back_close_app.dart';
import '../../static/colors.dart';
import '../../static/internet_connection_cheaker.dart';

class NavigationScreen extends StatefulWidget {
  Widget child;
  int index;
  NavigationScreen({
    super.key,
    required this.child,
    required this.index,
  });

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  late int _selectedIndex;
  final navigatorKey = GlobalKey<NavigatorState>();
  List<Widget> nav = [
    Center(
      child: Text("Home"),
    ),
    Center(
      child: Text("rupee"),
    ),
    Center(
      child: Text("custom"),
    ),
    Center(
      child: Text("more"),
    )
  ];

  @override
  void initState() {
    BackButtonInterceptor.add(backTocloseApp(context).myInterceptor);
    super.initState();
    // notificationInit(context);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(backTocloseApp(context).myInterceptor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: Colo.primaryColor.withOpacity(0.4), width: 1.0))),
        child: BottomNavigationBar(
          elevation: 4,
          useLegacyColorScheme: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colo.white,
          currentIndex: widget.index,
          selectedItemColor: Colo.primaryColor,
          selectedIconTheme: IconThemeData(color: Colo.primaryColor),
          unselectedIconTheme:
              IconThemeData(color: Colo.blackShade45.withOpacity(0.6)),
          selectedLabelStyle: TextStyle(
              fontSize: 14,
              color: Colo.primaryColor,
              fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(
              fontSize: 12, color: Colo.black, fontWeight: FontWeight.bold),
          unselectedFontSize: 12,
          selectedFontSize: 14,
          unselectedItemColor: Colo.black,
          onTap: (index) {
            // setState(() {
            switch (index) {
              case 0:
                context.go('/home', extra: {'id': "0"});
                break;
              case 1:
                context.go('/history', extra: {'id': "1"});
                break;
                case 2:
                context.go('/supporrt', extra: {'id': "2"});
                break;
              case 3:
                context.go('/profie', extra: {'id': "3"});
                break;
              default:
                context.go('/home', extra: {'id': "0"});
                break;
            }
            setState(() {
              _selectedIndex = index;
            });

            //   //   _selectedIndex = index;
            //   //   // pageController.jumpToPage(index);
            //   // });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                weight: 5.0,
              ),
              label: 'Home',
              activeIcon: Icon(
                Icons.home,
                size: 30.0, // Use size to control the icon size
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_edu_outlined),
              label: 'Challan',
              activeIcon: Icon(
                Icons.history_edu_outlined,
                size: 30.0, // Use size to control the icon size
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_support_outlined),
              label: 'Road Side Assistance',
              activeIcon: Icon(
                Icons.contact_support_rounded,
                size: 30.0, // Use size to control the icon size
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: 'Profile',
              activeIcon: Icon(
                Icons.person_2_outlined,
                size: 30.0, // Use size to control the icon size
              ),
            ),
          ],
        ),
      ),
      //  body: nav[_selectedIndex]);
      // body: SafeArea(
      //   child:  widget.,//IndexedStack(index: _selectedIndex, children: nav),
      //),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
   
       Expanded(child: widget.child),
           Visibility(
              visible: Provider.of<InternetConnectionStatus>(context) ==
                  InternetConnectionStatus.disconnected,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: const InternetNotAvailable(),
              ),
            ),
            // InternetNotAvailable(),
            // Container(height: 50,child: Text("data"),color: Colors.red,)
         
         
        ],
      ),
    );
  }
}
