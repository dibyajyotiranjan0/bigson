import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../static/aapp_url-endpoint.dart';
import '../../static/colors.dart';
import '../../viewmodel/home/home_viewmodel.dart';
import '../../viewmodel/profile/profile_viewmodel.dart';

profileWidget({bool edit = true}) {
  List<Map<String, dynamic>> payList = [
    {
      'title': "Total Received",
    },
    // {
    //   'title': "Total Pending",
    // },
    {
      'title': "Service Charges",
    }
  ];
  
    List customClo = [
    Colo.liteColorPrimary,
    Colo.liteColorPrimary2,
    Colo.liteColorPrimary3,
  ];
  return Consumer<ProfileViewmodel>(builder: (context, profile, _) {
    return profile.profile == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colo.white,
                boxShadow: [BoxShadow(color: Colo.greycolorCode, blurRadius: 4)],
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(15),
                // ),
                // image: DecorationImage(
                //   fit: BoxFit.fill,
                //   image: AssetImage("assets/background_shape.png"))
                ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      // Profile Picture
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          '${profile.profile?.user?.imageUrl ?? ""}', // replace with your asset
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 16),

                      // Name and Contact Info
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '${profile.name.text}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text('${profile.email.text}',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14)),
                          SizedBox(height: 4),
                          Text(
                            '+91 ${profile.contact.text}',
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                           SizedBox(height: 4),
                         profile.profile?.primumUser==null?SizedBox(): Text(
                            '${profile.profile?.primumUser?.txnId!=null? "Lifetime Subscription Holder":""}',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              context.push('/profie/editProfile',
                                  extra: {'id': "3"});
                            },
                            child: edit
                                ? CircleAvatar(
                                    child: Icon(Icons.edit,
                                        color: Colo.primaryColorSecond))
                                : SizedBox(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(height: 16),

                  // // Profile Complete and Button
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     // Row(
                  //     //   children: [
                  //     //     Icon(Icons.verified, color: Colors.green),
                  //     //     SizedBox(width: 5),
                  //     //     Text(
                  //     //       'Profile Complete 60%',
                  //     //       style: TextStyle(
                  //     //         color: Colors.grey[700],
                  //     //       ),
                  //     //     ),
                  //     //   ],
                  //     // ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         context
                  //             .push('/profie/editProfile', extra: {'id': "3"});
                  //       },
                  //       child: CircleAvatar(
                  //           child: Icon(Icons.edit,
                  //               color: Colo.primaryColorSecond)),
                  //     ),
                  //     // Icon(Icons.account_circle_outlined, color: Colors.blue),
                  //   ],
                  // ),
                 edit?SizedBox(): Container(
                  height: 76,
                  // height: double.minPositive,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      // color: Colo.white,
                      // boxShadow: [
                      //   // BoxShadow(color: Colo.greycolorCode, blurRadius: 4,offset: Offset(-4, 4),)
                      // ]
                      
                      ),
                  child: Consumer<HomeViewmodel>(builder: (context, payment, _) {
                    return GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: payList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            crossAxisCount: 2,
                            childAspectRatio: 2.5 / 1),
                        itemBuilder: (context, int) {
                          return Card(
                            margin: EdgeInsets.zero,
                            color: customClo[int],
                            elevation: 0,
                            child: ListTile(
                              onTap: () {
                                if (int == 1) {
                                  context.push('/home/commision',
                                      extra: {'id': '0'});
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Colo.greycolorCode),
                              ),
                              // tileColor: Colo.black, //customClo[int],
                              minLeadingWidth: 0,
                              minVerticalPadding: 0,
                              contentPadding: EdgeInsets.only(left: 5, right: 5),
                              // tileColor: customClo[int],
                              horizontalTitleGap: 10,
                              leading: SizedBox(
                                height: 40,
                                width: 40,
                                child: CircleAvatar(
                                    backgroundColor: Colo.primaryColor,
                                    radius: 20,
                                    child: Icon(
                                      Icons.currency_rupee,
                                      color: Colo.white,
                                    )),
                              ),
                              title: Text(
                                "${payList[int]['title']}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              titleTextStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: 14),
                              subtitle: Text(
                                  maxLines: 1,
                                  "\u{20B9}${int == 0 ? payment.paymentInfoModel?.data?.totalPayment ?? "" : payment.paymentInfoModel?.data?.commissionMoney ?? ""}"), //${int == 1 ? payment.paymentInfoModel?.data?.totalPayment ?? 0 : int == 2 ? payment.paymentInfoModel?.data?.pendingMoney ?? 0 : payment.paymentInfoModel?.data?.commissionMoney ?? 0}
                              isThreeLine: false,
                              // trailing: SizedBox(
                              //   height: 40,
                              //   width: 40,
                              //   child: CircleAvatar(
                              //       backgroundColor: Colo.primaryColor,
                              //       radius: 20,
                              //       child: Icon(
                              //         Icons.currency_rupee,
                              //         color: Colo.white,
                              //       )),
                              // ),
                            ),
                          );
                        });
                  }),
                ),
                
                ],
              ),
            ),
          );
  });
}
