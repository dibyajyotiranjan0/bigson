import 'dart:math' as math;
import 'package:bigsangrup/model/history_model.dart';
import 'package:bigsangrup/static/aapp_url-endpoint.dart';
import 'package:bigsangrup/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../history/show_delet_dialog.dart';

class CustomCard extends StatelessWidget {
  bool edit;
  Datum data;
  CustomCard({
    required this.data,
    this.edit = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
          color: Colo.primaryColor.withOpacity(0.8),
          // color:
          //     Colors.primaries[math.Random().nextInt(Colors.primaries.length)],
          //Colo.primaryColor.withOpacity(0.7), // Orange background color
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colo.greycolorCode, blurRadius: 4)]),
      child: Column(
        children: [
          SizedBox(
            height: 30,
            width: double.maxFinite,
            child: Padding(
              padding: EdgeInsets.only(left: 16, top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Date : ${DateFormat('dd-MM-yyyy').format(DateFormat('yyyy-MM-dd').parse(data.date.toString()))}"),
                  edit &&data.isPaid.toString() == "0"
                      ?  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.translate(
                          offset: Offset(0, -10),
                          child: IconButton(
                              onPressed: () {
                                showLogoutDialog(context,data.id.toString());
                                // context.push('/home/addSlap',
                                //     extra: {'id': "1", 'slip': data});
                              },
                              icon: Icon(Icons.delete,)))
                          , Transform.translate(
                          offset: Offset(0, -10),
                          child: IconButton(
                              onPressed: () {
                                context.push('/home/addSlap',
                                    extra: {'id': "1", 'slip': data});
                              },
                              icon: Icon(Icons.edit)))

                    ],
                  ):SizedBox(),

                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.zero,
            color: Colo.white,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding: EdgeInsets.only(left: 0.0, right: 0.0,top: 4,bottom: 4),
                  leading: Image.network(
                    fit: BoxFit.cover,

                    data.imageUrl ?? "",
                    // "${AppUrl.imageUrl}${image}",
                    height: 50,
                    width: 50,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error);
                    },
                  ),
                  title: Text(
                    '${data.tdsNo ?? ""}',
                  ),
                  // subtitle: Text('\u{20B9} $amount'),
                  trailing: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: data.isPaid.toString() == "0"
                          ? Colo.white
                          : Colors.green,
                      boxShadow: [
                        BoxShadow(color: Colo.greycolorCode, blurRadius: 4)
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${data.isPaid.toString() == "0" ? "Pending" : "Done"}',
                      style: TextStyle(
                        color: data.isPaid.toString() == "0"
                            ? Color(0xFFFF6E40)
                            : Colors.white, // Orange text color
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           '${tddNo}',
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 18,
                //             fontWeight: FontWeight.bold,
                //             letterSpacing: 1.5,
                //           ),
                //         ),
                //         SizedBox(height: 8),
                //         Row(
                //           children: [
                //             Image.network(
                //               "https://collegeprojectz.com/minetracks/public/img/no-image_img.png",
                //               // "${AppUrl.imageUrl}${image}",
                //               height: 50,
                //               width: 50,
                //               errorBuilder: (context, error, stackTrace) {
                //                 return Icon(Icons.error);
                //               },
                //             ),
                //             SizedBox(
                //               width: 10,
                //             ),
                //             Text(
                //               '${DateFormat('dd/MM/yyyy').format(DateTime.parse(date ?? ""))}',
                //               style: TextStyle(
                //                 color: Colors.white,
                //                 fontSize: 12,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ],
                //     ),
                //     Container(
                //       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                //       decoration: BoxDecoration(
                //         color: sts == "0" ? Colors.white : Colors.green,
                //         borderRadius: BorderRadius.circular(12),
                //       ),
                //       child: Text(
                //         '${sts == "0" ? "Pending" : "Done"}',
                //         style: TextStyle(
                //           color: sts == "0"
                //               ? Color(0xFFFF6E40)
                //               : Colors.white, // Orange text color
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),

                ),
          ),
        ],
      ),
    );
  }
}
