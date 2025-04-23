import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../static/flutter_toast_message/toast_messge.dart';

class backTocloseApp {
  static DateTime? _lastBackPressed;
  BuildContext context;
  backTocloseApp(this.context);
  Future<bool> myInterceptor(
      bool stopDefaultButtonEvent, RouteInfo info) async {
    DateTime now = DateTime.now();
    if (_lastBackPressed == null ||
        now.difference(_lastBackPressed!) > Duration(seconds: 2)) {
      _lastBackPressed = now;
      // final GoRouter router = GoRouter.of(context);

      //  final GoRouterState currentState = router.routerDelegate.currentConfiguration!;
      // final currentRouteName = routerState.;
      var currentRouteName = GoRouterState.of(context).uri.toString();
      // ShowToast(msg: currentLocation.toString());
      // var routeName =
      //     BackButtonInterceptor.getCurrentNavigatorRouteName(context);
      if (currentRouteName == "/home" ||
          currentRouteName == "/profie" ||
          currentRouteName == "/history") {
        ShowToast(msg: "Press back again to exit");
        return true;
      } else {
        // ShowToast(msg: currentRouteName.toString());
        return false;
      }
      //
      // return true;
      // Do not exit the app
    }
    SystemNavigator.pop();

    return false; // Exit the app
  }
}
