import 'package:bigsangrup/static/aapp_url-endpoint.dart';
import 'package:bigsangrup/viewmodel/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../static/appbar_widget.dart';
import '../../static/colors.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({super.key});

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
      WidgetsBinding.instance.addPostFrameCallback((_) {
      // Your function that needs to run after context is available
      Provider.of<HomeViewmodel>(context, listen: false).getAllLifetimeMembers();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context,img: false, title: "Leader Board"),
      body: Consumer<HomeViewmodel>(builder: (context, member, _) {
          return member.lifetimeMeberModel==null?Center(child: CircularProgressIndicator(),): 
          // GridView.builder(
          //   padding: EdgeInsets.all(12),
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     crossAxisSpacing: 12,
          //     mainAxisSpacing:12
          //     ),
          // itemCount: member.lifetimeMeberModel?.data?.length,
          //  itemBuilder: (context,int){
          //   return Container(
          //     // color: Colors.red,
          //     padding: EdgeInsets.all(8),
          //     decoration: BoxDecoration(
          //       color: Colo.white,
          //       borderRadius:BorderRadius.circular(12),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.grey,
          //           blurRadius: 2
          //         )
          //       ]
          //     ),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         ClipRRect(
          //           borderRadius: BorderRadius.circular(12),
          //           child: Image.network(
          //             '${AppUrl.image_baseurl}${member.lifetimeMeberModel?.data?[int].vehicleOwner?.image??""}', // replace with your asset
          //             width: 120,
          //             height: 120,
          //             fit: BoxFit.fill,
          //           ),
          //         ),
          //         SizedBox(height: 8,),
          //         Text("${member.lifetimeMeberModel?.data?[int].vehicleOwner?.name??""}",style:
          //                           TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 20)),
          //         // SizedBox(height: 8,),
          //         // Text("Vehicle No : ${member.lifetimeMeberModel?.data?[int].vehicleNo??""}"),
          //       ],
          //     ),
          //   );
          // });
         
          ListView.separated(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: member.lifetimeMeberModel?.data?.length??0,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(12),
                  itemBuilder: (context,index){
                  return Container(
                    // margin: EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colo.white,
                  boxShadow: [BoxShadow(color: Colo.greycolorCode, blurRadius: 2,spreadRadius: 1)],
                  // border: Border.all(color: select==index?Colo.green:Colors.transparent)
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
                            '${AppUrl.image_baseurl}${member.lifetimeMeberModel?.data?[index].vehicleOwner?.image??""}', // replace with your asset
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return SizedBox(width: 80,
                            height: 80, child: Icon(Icons.error));
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                  
                        // Name and Contact Info
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '${member.lifetimeMeberModel?.data?[index].vehicleOwner?.name??""}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text.rich(TextSpan(children: [
                                                      TextSpan(text: "Phone : ",style: TextStyle(color: Colo.black,fontWeight: FontWeight.bold,fontSize: 14)),
                                                       TextSpan(text: "${member.lifetimeMeberModel?.data?[index].vehicleOwner?.phone??""}",style:
                                    TextStyle(color: Colors.green,fontWeight: FontWeight.bold, fontSize: 14)),
                                                    ])),
                            //                         Text.rich(TextSpan(children: [
                            //                           TextSpan(text: "RC NO : ",style: TextStyle(color: Colo.black,fontWeight: FontWeight.bold,fontSize: 14)),
                            //                            TextSpan(text: "proile.vehicleModel?.data?[index].licienceNo??""}",style:
                            //         TextStyle(color: Colors.grey, fontSize: 14)),
                            //                         ])),
                            // SizedBox(height: 4),
                          
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
                                
                  );
              },
               separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 14,); },
          );
        
        }
      ),
    );
  }
}