import 'package:bigsangrup/model/parking_list_model.dart';
import 'package:bigsangrup/model/profie_model.dart';
import 'package:bigsangrup/viewmodel/parking/parking_viewmodel.dart';
import 'package:bigsangrup/viewmodel/profile/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../static/colors.dart';
import '../../../static/custom_elevated_button.dart';
import '../../../static/flutter_toast_message/toast_messge.dart';
import '../../../static/textfield_controller/textfieldValidator.dart';
import '../../../viewmodel/auth/login_viewmodel.dart';
import 'package:go_router/go_router.dart';

import '../../static/aapp_url-endpoint.dart';
import '../../static/appbar_widget.dart';

class AllVehicleListScreen extends StatefulWidget {
 bool park;
  AllVehicleListScreen({required this.park, super.key});

  @override
  State<AllVehicleListScreen> createState() => _AllVehicleListScreenState();
}

class _AllVehicleListScreenState extends State<AllVehicleListScreen> {
  int? select;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // Your function that needs to run after context is available
      Provider.of<ProfileViewmodel>(context, listen: false)
          .showVehicleViewmodel();
    });
  }

  final formkeyProfile = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBar(context: context,img: false,title: "All Vehicle List"),
      appBar: AppBar(
         automaticallyImplyLeading: true,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colo.black),
        shape: Border(
    bottom: BorderSide(
      color: Colors.orange,
      width: 1
    )
  ),
        backgroundColor: Colo.white,
        title: Text("All Vehicle List",style: Theme.of(context).textTheme.titleLarge),
        actions:widget.park? [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colo.primaryColor,
              foregroundColor: Colo.white,
              padding: EdgeInsets.only(left: 10,right: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))
            ),
            onPressed: (){
context.pop();
            }, 
            child: Text("Select Parking")),
          SizedBox(width: 10,)
        ]:[],
      ),
     floatingActionButton:FloatingActionButton.extended(
      backgroundColor: Colo.primaryColor,
      foregroundColor: Colo.white,
  onPressed: () => context.push('/profie/addvehicle', extra: {'id': "3", "vech": null}),
  icon: Icon(Icons.local_taxi_outlined),
  label: Text("Add Vehicle"),
),
     
      body: Consumer<ProfileViewmodel>(
        builder: (context, proile, _) {
          return  RefreshIndicator(
            onRefresh: ()async{
Provider.of<ProfileViewmodel>(context, listen: false)
          .showVehicleViewmodel();
            },
            child:proile.vehicleModel==null|| proile.vehicleModel?.data?.length==0?SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height*0.8,
                child: Center(child: Text("No Vehicle"),),
              ),
             ): ListView.separated(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: proile.vehicleModel?.data?.length??0,
              shrinkWrap: true,
              padding: EdgeInsets.all(12),
              itemBuilder: (context,index){
              return InkWell(
                onTap: (){
                  setState(() {
                    if (widget.park) {
                    select=index; 
                    Provider.of<ParkingViewmodel>(context, listen: false)
                    .selectVehicle(proile.vehicleModel?.data?[index]);

                    }
                    
                  });
                },
                child:  Container(
                  // margin: EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colo.white,
                boxShadow: [BoxShadow(color: Colo.greycolorCode, blurRadius: 2,spreadRadius: 1)],
                border: Border.all(color: select==index?Colo.green:Colors.transparent)
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
                          '${proile.vehicleModel?.data?[index].vehicleImageUrl??""}', // replace with your asset
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
                            '${proile.vehicleModel?.data?[index].vehicleNo??""}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          // Text.rich(TextSpan(children: [
                          //                           TextSpan(text: "Vehicle No : ",style: TextStyle(color: Colo.black,fontWeight: FontWeight.bold,fontSize: 14)),
                          //                            TextSpan(text: "${proile.vehicleModel?.data?[index].vehicleNo??""}",style:
                          //         TextStyle(color: Colors.grey, fontSize: 14)),
                          //                         ])),
                                                  Text.rich(TextSpan(children: [
                                                    TextSpan(text: "RC NO : ",style: TextStyle(color: Colo.black,fontWeight: FontWeight.bold,fontSize: 14)),
                                                     TextSpan(text: "${proile.vehicleModel?.data?[index].licienceNo??""}",style:
                                  TextStyle(color: Colors.grey, fontSize: 14)),
                                                  ])),
                          SizedBox(height: 4),
                        
                        ],
                      ),
                    ]),
                      // Expanded(
                      //   child: Align(
                      //     alignment: Alignment.topRight,
                      //     child: GestureDetector(
                      //       onTap: () {
                      //         context.push('/profie/editProfile',
                      //             extra: {'id': "3"});
                      //       },
                      //       child: edit
                      //           ? CircleAvatar(
                      //               child: Icon(Icons.edit,
                      //                   color: Colo.primaryColorSecond))
                      //           : SizedBox(),
                      //     ),
                      //   ),
                      // ),
                    ],
                  )
                  ,)
                // child: Container(
                //   padding: EdgeInsets.all(4),
                //   margin: EdgeInsets.all(8),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(8),
                //     border: Border.all(color:select==index?Colo.green: Colo.primaryColor)
                //   ),
                //   // height: 50,
                //   // color: Colo.primaryColor,
                //   // child: ListTile(
                //   //   leading: Image.network("${proile.vehicleModel?.data?[index].vehicleImageUrl??""}",width: 100,height: 200,fit: BoxFit.fill,),
                //   //   title:    Text.rich(TextSpan(children: [
                //   //       TextSpan(text: "No : "),
                //   //        TextSpan(text: "${proile.vehicleModel?.data?[index].vehicleNo??""}"),
                //   //     ])) ,
                //   //     subtitle: Text.rich(TextSpan(children: [
                //   //       TextSpan(text: "RC : "),
                //   //        TextSpan(text: "${proile.vehicleModel?.data?[index].vehicleNo??""}"),
                //   //     ])),
                //       // trailing: OutlinedButton(onPressed: (){
                //       //    context.push('/profie/addvehicle', extra: {'id': "3", "vech": proile.vehicleModel?.data?[index]??null});
                //       // }, child: Text("Edit")),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           Expanded(
                //             child: Padding(
                //               padding: const EdgeInsets.only(left: 10),
                //               child: Column(
                //                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                //                                     crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                      Text.rich(TextSpan(children: [
                //                                     TextSpan(text: "Vehicle No : ",style: TextStyle(color: Colo.black,fontWeight: FontWeight.bold)),
                //                                      TextSpan(text: "${proile.vehicleModel?.data?[index].vehicleNo??""}"),
                //                                   ])), 
                //                                   // Text.rich(TextSpan(children: [
                //                                   //   TextSpan(text: "RC NO : ",style: TextStyle(color: Colo.black,fontWeight: FontWeight.bold)),
                //                                   //    TextSpan(text: "${proile.vehicleModel?.data?[index].vehicleNo??""}"),
                //                                   // ])),
                //                                    Text.rich(TextSpan(children: [
                //                                     TextSpan(text: "RC NO : ",style: TextStyle(color: Colo.black,fontWeight: FontWeight.bold)),
                //                                      TextSpan(text: "${proile.vehicleModel?.data?[index].licienceNo??""}"),
                //                                   ])), 
                //                 ],
                //               ),
                //             ),
                //           ),
                //           SizedBox(width: 8,),
                //           Image.network("${proile.vehicleModel?.data?[index].vehicleImageUrl??""}",fit: BoxFit.fill,height: 150,width: 150,),
                          
                          
                //         ],
                //       ),
                //   // )
                //   // Column(
                //   //   children: [
                //   //     Text.rich(TextSpan(children: [
                //   //       TextSpan(text: "Vehicle Number: "),
                //   //        TextSpan(text: "${proile.vehicleModel?.data?[index].vehicleNo??""}"),
                //   //     ])),
                //   //     Text.rich(TextSpan(children: [
                //   //       TextSpan(text: "RC Number: "),
                //   //        TextSpan(text: "${proile.vehicleModel?.data?[index].vehicleNo??""}"),
                //   //     ])),
                //   //   ],
                //   // ),
                // ),
              
                ));
          },
           separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 14,); },),
           
          );
        }
      )
    );
  }
}
