import 'dart:math' as math;
import 'package:bigsangrup/static/aapp_url-endpoint.dart';
import 'package:bigsangrup/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../static/appbar_widget.dart';
import '../../viewmodel/home/home_viewmodel.dart';

class CommisionHistory extends StatelessWidget {
  // String? tddNo;
  // String? sts;
  // String? date;
  // String? image;
  // String? amount;
  // CommisionHistory(
  //     {required this.tddNo,
  //     required this.sts,
  //     required this.date,
  //     required this.image,
  //     required this.amount});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context,img: false,title: "Service History"),
        // appBar: AppBar(
        //   automaticallyImplyLeading: true,
        //   centerTitle: true,
        //   title: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Text(
        //         "Commission History",
        //         style: Theme.of(context).textTheme.titleLarge,
        //       ),
        //       SizedBox(
        //         width: 10,
        //       ),
        //       SizedBox(
        //         height: 50,
        //         width: 50,
        //         child: Image.asset(
        //           "assets/bigsangrup_logo.png",
        //           fit: BoxFit.cover,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
       
        body: Consumer<HomeViewmodel>(builder: (context, commision, _) {
          return commision.historyModel == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: commision.historyModel!.data!.length,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  itemBuilder: (context, index) {
                    return commision.historyModel!.data![index].commisionPaid ==
                            null
                        ? SizedBox()
                        : Container(
                            margin: EdgeInsets.only(bottom: 12),
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: Colo.primaryColor.withOpacity(0.8),
                                // color:
                                //     Colors.primaries[math.Random().nextInt(Colors.primaries.length)],
                                //Colo.primaryColor.withOpacity(0.7), // Orange background color
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colo.greycolorCode, blurRadius: 4)
                                ]),
                            child: Column(children: [
                              
                              Card(
                                  margin: EdgeInsets.zero,
                                  color: Colo.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                height: 30,
                                width: double.maxFinite,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 0, top: 5, bottom: 5),
                                  child: Text(
                                      "Date : ${DateFormat('dd-MM-yyyy').format(commision.historyModel!.data![index].date!)}"),
                                ),
                              ),
                                        ListTile(
                                          visualDensity: VisualDensity(
                                              horizontal: 0, vertical: -4),
                                          contentPadding: EdgeInsets.only(
                                              left: 0.0, right: 0.0),
                                          // leading: Image.network(
                                          //   commision.historyModel.data[index].commisionAmount ?? "",
                                          //   // "${AppUrl.imageUrl}${image}",
                                          //   height: 50,
                                          //   width: 50,
                                          //   errorBuilder: (context, error, stackTrace) {
                                          //     return Icon(Icons.error);
                                          //   },
                                          // ),
                                          title:Text.rich(
                                            TextSpan(children: [
                                              TextSpan(
                                                text: 'Challan No :  ',
                                                style: Theme.of(context).textTheme.bodyMedium
                                              ),
                                              TextSpan(
                                                text: '${commision.historyModel!.data![index]
                                                    .tdsNo ??
                                                ""}',
                                                style: Theme.of(context).textTheme.bodyLarge
                                              )
                                            ])
                                          ),
                                          subtitle: Text.rich(
                                            TextSpan(children: [
                                              TextSpan(
                                                text: 'Amount : ',
                                                style: Theme.of(context).textTheme.bodyMedium
                                              ),
                                              TextSpan(
                                                text: '\u{20B9} ${commision.historyModel!.data![index].commisionAmount ?? ""}',
                                                style: Theme.of(context).textTheme.bodyLarge
                                              )
                                            ])
                                          ),
                                          // trailing: Container(
                                          //   padding: EdgeInsets.symmetric(
                                          //       horizontal: 12, vertical: 4),
                                          //   decoration: BoxDecoration(
                                          //     color: sts == "0" ? Colo.white : Colors.green,
                                          //     boxShadow: [
                                          //       BoxShadow(
                                          //           color: Colo.greycolorCode, blurRadius: 4)
                                          //     ],
                                          //     borderRadius: BorderRadius.circular(12),
                                          //   ),
                                          //   child: Text(
                                          //     '${sts == "0" ? "Pending" : "Done"}',
                                          //     style: TextStyle(
                                          //       color: sts == "0"
                                          //           ? Color(0xFFFF6E40)
                                          //           : Colors.white, // Orange text color
                                          //       fontWeight: FontWeight.bold,
                                          //     ),
                                          //   ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ]),
                          );
                  });
        }));
  }
}
