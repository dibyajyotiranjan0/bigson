import 'dart:async';

import 'package:flutter/material.dart';

class TabUpdateViewmodel with ChangeNotifier {
  TabController? tabController;
  Future tabbarListin(context) async {
    // tabController!.addListener(() {
    //   if (tabController!.indexIsChanging) {
    //     switch (tabController!.index) {
    //       case 0:
    //         context.push('/home', extra: {'id': "0", 'sea': "home"});
    //         break;
    //       case 1:
    //         context.push('/sellScreen', extra: {'id': "1"});
    //         break;
    //       case 2:
    //         context.push('/myadd', extra: {'id': "2"});
    //         break;
    //       case 3:
    //         context.push('/profie', extra: {'id': "3"});
    //         break;
    //       default:
    //         context.push('/home', extra: {'id': "0"});
    //         break;
    //     }

    //     notifyListeners();
    //   }
    // });

    notifyListeners();
  }

  Future tabchangetoInd(int ind) async {
    tabController!.index = ind;
    notifyListeners();
  }
}
