import 'package:bigsangrup/screen/home/history_widget.dart';
import 'package:bigsangrup/screen/home/phonepay_pg_class.dart';
import 'package:bigsangrup/static/colors.dart';
import 'package:bigsangrup/static/flutter_toast_message/toast_messge.dart';
import 'package:bigsangrup/viewmodel/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../../static/appbar_widget.dart';
import '../../viewmodel/profile/profile_viewmodel.dart';
import '../profile/profile_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  with WidgetsBindingObserver{
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      WidgetsBinding.instance.addObserver(this); 
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // Your function that needs to run after context is available
      Provider.of<ProfileViewmodel>(context, listen: false).profileViewmodel();
      Provider.of<HomeViewmodel>(context, listen: false)
        ..showhistoryViewmodel()
        ..showhpaymentViewmodel()
        ..showSubscription();
    });
  }
   @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Handle resumption logic here (e.g., check if payment was completed)
      print('App resumed from background');
    } else if (state == AppLifecycleState.paused) {
      // Handle pause logic if needed
      print('App paused or backgrounded');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: appBar(context: context,img: true,title: "Home"),
  //     AppBar(
  //       automaticallyImplyLeading: false,
  //       centerTitle: true,
  //       shape: Border(
  //   bottom: BorderSide(
  //     color: Colors.orange,
  //     width: 1
  //   )
  // ),
  // elevation: 4,
  //       title: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Text(
  //             "Home",
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
      floatingActionButton: FloatingActionButton.extended(
         backgroundColor: Colo.primaryColor,
      foregroundColor: Colo.white,
        elevation: 5,
        onPressed: () {
          context.push('/home/addSlap', extra: {'id': "0"});
        },
        icon: Icon( Icons.add,),
  label: Text("Create Challan"),
        
      ),
      body: RefreshIndicator(
            // backgroundColor: Colors.red,
            onRefresh: ()async{
             await Provider.of<ProfileViewmodel>(context, listen: false).profileViewmodel();
     await Provider.of<HomeViewmodel>(context, listen: false)
        ..showhistoryViewmodel()
        ..showhpaymentViewmodel()
        ..showSubscription();
            },
        child: SafeArea(
          child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
            // physics:NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Information
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     "Profile",
                //     style: Theme.of(context)
                //         .textTheme
                //         .bodyLarge!
                //         .copyWith(fontSize: 18),
                //   ),
                // ),
                SizedBox(
                  height: 15,
                ),
                profileWidget(edit: false),
               SizedBox(height: 20,),
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset("assets/promotion.jpeg",fit: BoxFit.fill,),
                ),
                SizedBox(height: 20,),
                // Padding(padding: EdgeInsets.only(top: 8,bottom: 8),child: Divider(),),
               
            
                // SizedBox(height: 10,),
                Consumer<ProfileViewmodel>(builder: (context, profi, _) {
                    return profi.profile?.primumUser?.txnId !=null?SizedBox(): Consumer<HomeViewmodel>(builder: (context, package, _) {
                        return package.subscription==null?Center(child: CircularProgressIndicator(),): Container(
                          // height: 110,
                          padding: EdgeInsets.all(8),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Color(0xFFEDF7FC),
                              
                              boxShadow: [
                                BoxShadow(color: Colo.primaryColor, blurRadius: 4)
                              ]
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(15),
                              // ),
                              ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Life Time Subscription",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colo.primaryColor,fontSize: 25,fontWeight: FontWeight.bold),),
                              Padding(
                                padding: const EdgeInsets.only(left:  18.0,right: 18),
                                child: Divider(
                                  height: 0,
                                  thickness: 0.3,
                                  color: Colo.blackShade45,
                                ),
                              ),
                              ListTile(
                                // isThreeLine: true,
                                // titleAlignment: ListTileTitleAlignment.top,
                                // leading: SizedBox(height: 30,width: 30, child: Image.network("${package.subscription?.data?.imageUrl??""}")),
                                title: Text("${package.subscription?.data?.name??""}"),
                                titleTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 21),
                                // subtitle: Text("\u{20B9}${package.subscription?.data?.price??""}",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),),
                                // trailing: SizedBox(
                                //   height: 30,
                                //   child: ElevatedButton(
                                //     onPressed:(){
                                //   PhonepePg(amount: double.parse(package.subscription?.data?.price??"500.0")).init().then((v){
                                //       if (v) {
                                //         package.addSubscription(amount: package.subscription?.data?.price??"500",payamount: package.subscription?.data?.price??"500",paymentress: "SUCCESS").then((v){
                                //           if (v) {
                                //             profi.profileViewmodel();
                                //           }
                                //         });
                                //       }
                                //     });
                                //     // 
                                //     // PhonepePg( amount: 500).init();
                                //     // .then((v){
                                //     //   if (v) {
                                //     //     Provider.of<ProfileViewmodel>(context, listen: false).profileViewmodel();
                                //     //   }
                                //     // });
                                //     }, 
                                //   style: ElevatedButton.styleFrom(
                                //     backgroundColor: Colo.primaryColor,
                                //     foregroundColor: Colo.white,
                                //     shape: RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.circular(18.0),
                                //         // side: BorderSide(color: Colors.red)
                                //       )
                                //   ),
                                //   child: Text("Pay")),
                                // ),
                             
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15,right: 10,top: 4,bottom: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("\u{20B9}${package.subscription?.data?.price??""}",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold,fontSize: 24),),
                                   Container(color: Colo.black,height: 50, width: 0.4,),
                                    SizedBox(
                                      height: 50,
                                      width: 150,
                                      child: ElevatedButton(
                                        onPressed: (){
                                                                         PhonepePg(amount: double.parse(package.subscription?.data?.price??"500.0")).init().then((v){
                                          if (v) {
                                            package.addSubscription(amount: package.subscription?.data?.price??"500",payamount: package.subscription?.data?.price??"500",paymentress: "SUCCESS").then((v){
                                              if (v) {
                                                profi.profileViewmodel();
                                              }
                                            });
                                          }
                                        });
                                      }, 
                                            style: ElevatedButton.styleFrom(
                                        backgroundColor: Colo.primaryColor,
                                        foregroundColor: Colo.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12.0),
                                            // side: BorderSide(color: Colors.red)
                                          )
                                      ),
                                      child: Text("PAY")),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                          // Column(
                          //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text("${package.subscription?.data?.name??""}"),
                          //     Padding(
                          //       padding: EdgeInsets.only(left: 16,right: 16),
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Text("${package.subscription?.data?.price??""}"),
                          //           ElevatedButton(onPressed:(){}, child: Text("Pay"))
                          //         ],
                          //       ),
                          //     )
                          //   ],
                          // ),
                        );
                      }
                    );
                  }
                ),
                
                 SizedBox(height: 15),
                Text(
                  "Services",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: 5),
                Ink(
                  padding: EdgeInsets.only(top: 16,bottom: 16,left: 6,right: 6),
                  decoration: BoxDecoration(
                    color: Colo.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(color: Colors.grey,blurRadius: 2,spreadRadius: 1)
                    ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: (){
                                context.push('/profie/viewroute', extra: {'id': "0"});
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Ink(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colo.primaryColor,
                                      
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(color: Colo.black,)
                                      ]
                                    ),
                                     child: Icon(Icons.payments_outlined,size: 42,color: Colo.white,)),
                                  Text(
                                    "Rate info",maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodyMedium,)
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                              child: InkWell(
                              onTap: (){
                               context.push('/profie/vehicle', extra: {'id': "0",'book':false});
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Ink(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colo.primaryColor,
                                      
                                      borderRadius: BorderRadius.circular(12),
                                      // boxShadow: [
                                      //   BoxShadow(color: Colo.black,)
                                      // ]
                                    ),
                                     child: Icon(Icons.fire_truck_outlined,size: 42,color: Colo.white,)),
                                  Text(
                                    "Vehicle Info",maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodyMedium)
                                ],
                              ),
                                                    ),
                            ),
                          Expanded(
                             child: InkWell(
                              onTap: (){
                                 context.push('/home/addSlap', extra: {'id': "0"});
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Ink(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colo.primaryColor,
                                      
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(color: Colo.black,)
                                      ]
                                    ),
                                     child: Icon(Icons.edit_document,size: 42,color: Colo.white,)),
                                  Text(
                                    "Create Challan",maxLines: 1,textAlign: TextAlign.center,overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium,)
                                ],
                              ),
                                                   ),
                           ),
                          
                       
                        ],
                      ),
                      SizedBox(height: 16,),
                      Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                             child: InkWell(
                              onTap: (){
                                // ShowToast(msg: "Comming Soon ...");
                                context.push('/home/parking', extra: {'id': "0"});
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Ink(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colo.primaryColor,
                                      
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(color: Colo.black,)
                                      ]
                                    ),
                                     child: Icon(Icons.local_parking,size: 42,color: Colo.white,)),
                                  Text(
                                    "Parking Area",maxLines: 1,textAlign: TextAlign.center,overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium)
                                ],
                              ),
                                                   ),
                           )
                      ,
                      Expanded(
                          child: InkWell(
                          onTap: (){
                           context.push('/home/leaderboard', extra: {'id': "0"});
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Ink(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colo.primaryColor,
                                  
                                  borderRadius: BorderRadius.circular(12),
                                  // boxShadow: [
                                  //   BoxShadow(color: Colo.black,)
                                  // ]
                                ),
                                 child: Icon(Icons.stars_outlined,size: 42,color: Colo.white,)),
                              Text(
                                "Leader Board",maxLines: 1,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodyMedium)
                            ],
                          ),
                                                ),
                        ),
                     
                      Expanded(
                         child: InkWell(
                          onTap: (){
                             context.push('/home/chalandiscount', extra: {'id': "0"});
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Ink(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colo.primaryColor,
                                  
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(color: Colo.black,)
                                  ]
                                ),
                                 child: Icon(Icons.percent_outlined,size: 42,color: Colo.white,)),
                              Text(
                                "Challan Discount",maxLines: 1,textAlign: TextAlign.center,overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium,)
                            ],
                          ),
                                               ),
                       ),
                      //  Expanded(child: SizedBox())
                      
                      // InkWell(
                      //  onTap: (){
                      //    // ShowToast(msg: "Comming Soon ...");
                      //    context.push('/home/parking', extra: {'id': "0"});
                      //  },
                      //  child: Column(
                      //    mainAxisAlignment: MainAxisAlignment.center,
                      //    crossAxisAlignment: CrossAxisAlignment.center,
                      //    children: [
                      //      Ink(
                      //        padding: EdgeInsets.all(10),
                      //        decoration: BoxDecoration(
                      //          color: Colo.primaryColor,
                               
                      //          borderRadius: BorderRadius.circular(12),
                      //          boxShadow: [
                      //            BoxShadow(color: Colo.black,)
                      //          ]
                      //        ),
                      //         child: Icon(Icons.local_parking,size: 32,color: Colo.white,)),
                      //      Text(
                      //        "Parking Area",maxLines: 1,textAlign: TextAlign.center,overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodySmall)
                      //    ],
                      //  ),
                                            // )
                    ],
                  ),
                    ],
                  ),
                ),
                SizedBox(height: 120),
                // Padding(padding: EdgeInsets.only(top: 8,bottom: 8),child: Divider(),),
                 
                // List Section
                //  Text(
                //   "Recent Challan",
                //   style: Theme.of(context).textTheme.bodyLarge,
                // ),
                // SizedBox(height: 10),
                // Consumer<HomeViewmodel>(builder: (context, home, _) {
                //   return home.historyModel == null
                //       ? Center(
                //           child: CircularProgressIndicator(),
                //         )
                //       : ListView.builder(
                //           shrinkWrap: true,
                //           itemCount: home.historyModel!.data!.length > 5
                //               ? 5
                //               : home.historyModel!.data!.length,
                //           physics: NeverScrollableScrollPhysics(),
                //           // padding: EdgeInsets.only(bottom: 8),
                //           itemBuilder: (context, index) {
                //             return CustomCard(
                //                 data: home.historyModel!.data![index]);
                //             // return Container(
                //             //   // margin: EdgeInsets.all(10),
                //             //   padding: EdgeInsets.all(10),
                //             //   margin: EdgeInsets.only(top: 12, left: 15, right: 15),
                //             //   decoration: BoxDecoration(
                //             //       color: Colo.primaryColorSecond,
                //             //       border:
                //             //           Border.all(color: Colo.primaryColor, width: 5),
                //             //       boxShadow: [
                //             //         BoxShadow(color: Colo.black, blurRadius: 2)
                //             //       ],
                //             //       borderRadius: BorderRadius.circular(12)),
                //             //   child: Column(
                //             //     mainAxisAlignment: MainAxisAlignment.start,
                //             //     crossAxisAlignment: CrossAxisAlignment.center,
                //             //     // mainAxisSize: MainAxisSize.min,
                //             //     children: [
                //             //       SizedBox(
                //             //         child: Column(
                //             //           // mainAxisSize: MainAxisSize.,
                //             //           mainAxisAlignment: MainAxisAlignment.start,
                //             //           crossAxisAlignment: CrossAxisAlignment.start,
                //             //           children: [
                //             //             Text.rich(
                //             //               TextSpan(
                //             //                 children: [
                //             //                   TextSpan(
                //             //                       text: 'Amount:     ',
                //             //                       style: Theme.of(context)
                //             //                           .textTheme
                //             //                           .bodyLarge!
                //             //                           .copyWith(
                //             //                               fontSize: 16,
                //             //                               color: Colo.greycolorCode)),
                //             //                   TextSpan(
                //             //                     text: "\u{20B9}",
                //             //                     // DateFormat('dd/MM/yyyy')
                //             //                     //     .format(DateTime.parse("12/05/2025"))
                //             //                     //     .toString(),
                //             //                     style: Theme.of(context)
                //             //                         .textTheme
                //             //                         .bodySmall!
                //             //                         .copyWith(color: Colo.white),
                //             //                   ),
                //             //                   TextSpan(
                //             //                       text: '500',
                //             //                       style: Theme.of(context)
                //             //                           .textTheme
                //             //                           .bodySmall!
                //             //                           .copyWith(color: Colo.white)),
                //             //                 ],
                //             //               ),
                //             //               textAlign: TextAlign.start,
                //             //             ),
                //             //             Row(
                //             //               mainAxisAlignment:
                //             //                   MainAxisAlignment.spaceBetween,
                //             //               children: [
                //             //                 Row(
                //             //                   mainAxisAlignment:
                //             //                       MainAxisAlignment.start,
                //             //                   children: [
                //             //                     Text("TDD Payment",
                //             //                         style: Theme.of(context)
                //             //                             .textTheme
                //             //                             .bodyLarge!
                //             //                             .copyWith(
                //             //                                 color: Colo.greycolorCode,
                //             //                                 fontSize:
                //             //                                     16)), //Type of cab (mini,)
                //             //                     Text(": \u{20B9}",
                //             //                         style: Theme.of(context)
                //             //                             .textTheme
                //             //                             .bodySmall!
                //             //                             .copyWith(
                //             //                               color: Colo.white,
                //             //                             )),
                //             //                     Text("12",
                //             //                         style: Theme.of(context)
                //             //                             .textTheme
                //             //                             .bodySmall!
                //             //                             .copyWith(
                //             //                               color: Colo.white,
                //             //                             )) //Status of cab  (full, shairing, future)
                //             //                   ],
                //             //                 ),
                //             //                 Material(
                //             //                   color: Colo.primaryColor,
                //             //                   borderRadius: BorderRadius.circular(12),
                //             //                   child: Padding(
                //             //                     padding: const EdgeInsets.only(
                //             //                         left: 10,
                //             //                         right: 10,
                //             //                         top: 2,
                //             //                         bottom: 2),
                //             //                     child: Text("Pending",
                //             //                         style: Theme.of(context)
                //             //                             .textTheme
                //             //                             .bodySmall!
                //             //                             .copyWith(
                //             //                               color: Colo.white,
                //             //                             )),
                //             //                   ),
                //             //                 )
                //             //               ],
                //             //             )
                //             //           ],
                //             //         ),
                //             //       ),
                //             //       SizedBox(
                //             //         height: 4,
                //             //       ),
                //             //       Divider(
                //             //         color: Colo.white,
                //             //         height: 1,
                //             //       ),
                //             //       Padding(
                //             //         padding: const EdgeInsets.only(left: 18, right: 18),
                //             //         child: Text.rich(
                //             //           TextSpan(
                //             //             children: [
                //             //               TextSpan(
                //             //                   text: 'Date:  ',
                //             //                   style: Theme.of(context)
                //             //                       .textTheme
                //             //                       .bodyLarge!
                //             //                       .copyWith(
                //             //                           fontSize: 16,
                //             //                           color: Colo.greycolorCode)),
                //             //               TextSpan(
                //             //                 text: "12/12/2024",
                //             //                 // DateFormat('dd/MM/yyyy')
                //             //                 //     .format(DateTime.parse("12/05/2025"))
                //             //                 //     .toString(),
                //             //                 style: Theme.of(context)
                //             //                     .textTheme
                //             //                     .bodySmall!
                //             //                     .copyWith(color: Colo.white),
                //             //               ),
                //             //             ],
                //             //           ),
                //             //           textAlign: TextAlign.start,
                //             //         ),
                //             //       ),
                //             //     ],
                //             //   ),
                //             // );
                //           });
                // })
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
