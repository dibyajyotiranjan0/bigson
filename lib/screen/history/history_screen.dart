import 'package:bigsangrup/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../static/appbar_widget.dart';
import '../../viewmodel/home/home_viewmodel.dart';
import '../home/history_widget.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});
  final List<String> options = ["Done", "Pending", "All"];
  final GlobalKey _popupMenuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context,img: true,title: "History"),
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
  //             "History",
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
     
      body: SafeArea(
        child: Consumer<HomeViewmodel>(builder: (context, home, _) {
          return home.historyModel == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    home.showhistoryViewmodel();
                  },
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: PopupMenuButton<String>(
                            key: _popupMenuKey,
                            onSelected: (String value) {
                              home.filterHistory(sts: value);
                              // setState(() {
                              //   _selectedOption = value;
                              // });
                            },
                            itemBuilder: (BuildContext context) {
                              return options.map((String option) {
                                return PopupMenuItem<String>(
                                  value: option,
                                  child: Text(option),
                                );
                              }).toList();
                            },
                            child: SizedBox(
                              height: 45,
                              width: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Filter",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(color: Colo.black),
                                  ),
                                  Icon(Icons.filter_alt),
                                ],
                              ),
                            )),
                      ),
                      Expanded(
                        child: home.historyTrans == null
                            ? home.historyModel!.data!.length == 0
                                ? Center(
                                    child: Text("No Challan"),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 4),
                                    itemCount: home.historyModel!.data!.length,
                                    itemBuilder: (context, index) {
                                      return CustomCard(
                                        edit: true,
                                        data: home.historyModel!.data![index],
                                      );
                                    })
                            : home.historyTrans!.length == 0
                                ? Center(
                                    child: Text("No Challan"),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 4),
                                    itemCount: home.historyTrans!.length,
                                    itemBuilder: (context, index) {
                                      return CustomCard(
                                          edit: true,
                                          data: home.historyTrans![index]!);
                                    }),
                      ),
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
