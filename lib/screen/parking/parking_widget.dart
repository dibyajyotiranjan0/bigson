import 'package:bigsangrup/model/parking_list_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../background/background_service.dart';
import '../../static/colors.dart';

Widget parkingWidget( BuildContext context,bool isRecent,{required Datum? parkingData}){
  return Container(
                          margin: EdgeInsets.only(bottom: 16),
              padding: EdgeInsets.only(left: 12,right: 5,top: 4,bottom: 4),
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              
                              boxShadow: [
                                BoxShadow(color: Colo.greycolorCode, blurRadius: 4)
                              ]
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(15),
                              // ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text("${parkingData?.parkingName??""}",style:  Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontSize: 21)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20,right: 20),
                                    child: Divider(thickness: 1,height: 0,),
                                  ),
                             
                              SizedBox(height: 6,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                SizedBox(width: 80,
                                child: Text("Location",style:  Theme.of(context)
                                  .textTheme
                                  .bodyMedium,)
                                ,),
                                Expanded(
                                  child: Text(": ${parkingData?.parkingLocation??""}",maxLines: 2,overflow: TextOverflow.ellipsis, style:  Theme.of(context)
                                    .textTheme
                                    .bodyLarge!.copyWith(color: Colo.blackShade45)),
                                )
                              ],),
                             !isRecent?SizedBox(): SizedBox(height: 4,),
                              !isRecent?SizedBox(): Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                SizedBox(width: 80,
                                child: Text("Phone",style:  Theme.of(context)
                                  .textTheme
                                  .bodyMedium,)
                                ,),
                                Expanded(
                                  child: InkWell(
                                    onTap: (){
                                      launchUrlString("tel://${parkingData?.parkingPhoneNumber??""}");
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(": ${parkingData?.parkingPhoneNumber??""}",maxLines: 2,overflow: TextOverflow.ellipsis, style:  Theme.of(context)
                                          .textTheme
                                          .bodyLarge!.copyWith(color: Colo.blackShade45,fontWeight: FontWeight.w500)),
                                          Icon(Icons.call,color: Colors.blue,size: 20,)
                                      ],
                                    ),
                                  ),
                                )
                              ],),
                              SizedBox(height: 4,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                    
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                          SizedBox(width: 80,
                                          child: Text("Parking",style:  Theme.of(context)
                                            .textTheme
                                            .bodyMedium,)
                                          ,),
                                          Expanded(
                                            child: Text(": ${parkingData?.parkingCapacity??0-(parkingData?.parkingVehicleCount??0)}/${parkingData?.parkingCapacity??""}",maxLines: 2,overflow: TextOverflow.ellipsis, style:  Theme.of(context)
                                              .textTheme
                                              .bodyLarge!.copyWith(color: Colo.black,fontWeight: FontWeight.w500)),
                                          )
                                        ],),
                                        SizedBox(height: 4,),
                               Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                SizedBox(width: 80,
                                child: Text("Open",style:  Theme.of(context)
                                  .textTheme
                                  .bodyMedium,)
                                ,),
                                Expanded(
                                  child: Text(": ${parkingData?.parkingTime??""}",maxLines: 2,overflow: TextOverflow.ellipsis, style:  Theme.of(context)
                                    .textTheme
                                    .bodyLarge!.copyWith(color: Colo.blackShade45,fontWeight: FontWeight.w500)),
                                )
                              ],),
                                      ],
                                    ),
                                  ),
                                  Expanded(child: isRecent?SizedBox(): ElevatedButton(
                                  onPressed: ()async{
                             
                                    context.push("/home/bookparking",extra: {"id":"0",'park':parkingData});
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.only(left: 4,right: 4),
                                    backgroundColor: Colo.primaryColor,
                                    foregroundColor: Colo.white,
                                    iconColor: Colo.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)
                                    )
                                  ),
                                  child: Text("Book Parking"),
                                  // icon: Icon(Icons.local_parking),
                                  ))
                                ],
                              ),
                              
                              SizedBox(height: 4,),
                              
//                                 Text.rich(
//                                   maxLines: 2

// ,                                 overflow: TextOverflow.ellipsis, TextSpan(children: [
//                                   TextSpan(text: "Location : ",style:  Theme.of(context)
//                                   .textTheme
//                                   .bodyMedium),
//                                   TextSpan(
//                                     text: " OCAC Tower, Achrya Bihar, Doordarshan Colony, Gajapati Nagar, Bhubaneswar, Odisha 751013",style:  Theme.of(context)
//                                   .textTheme
//                                   .bodyLarge!.copyWith(color: Colo.blackShade45)),
//                                 ])),
//                                 SizedBox(height: 4,),
//                                 Text.rich(
//                                   maxLines: 2

// ,                                 overflow: TextOverflow.ellipsis, TextSpan(children: [
//                                   TextSpan(text: "Phon : ",style:  Theme.of(context)
//                                   .textTheme
//                                   .bodyMedium),
//                                   TextSpan(
//                                     text: "+91 090909090909",style:  Theme.of(context)
//                                   .textTheme
//                                   .bodyLarge!.copyWith(color: Colo.blackShade45)),
//                                 ])),
                                // SizedBox(height: 4,),
                                // Text.rich(TextSpan(children: [
                                //   TextSpan(text: "Available Parking : ",style:  Theme.of(context)
                                //   .textTheme
                                //   .bodyMedium),
                                //   TextSpan(text: "100/100",style:  Theme.of(context)
                                //   .textTheme
                                //   .bodyLarge),])),
                                // // SizedBox(height: 10,),
                                // // Text.rich(TextSpan(children: [
                                // //   TextSpan(text: "Total Parking : ",style:  Theme.of(context)
                                // //   .textTheme
                                // //   .bodyMedium),
                                // //   TextSpan(text: "100",style:  Theme.of(context)
                                // //   .textTheme
                                // //   .bodyLarge),
                                // // ])),
                                // SizedBox(height: 4,),
                                // Text.rich(TextSpan(children: [
                                //   TextSpan(text: "open : ",style:  Theme.of(context)
                                //   .textTheme
                                //   .bodyMedium),
                                //   TextSpan(text: "24/7",style:  Theme.of(context)
                                //   .textTheme
                                //   .bodyLarge),
                                // ])),
                                // customElevatedButton(context: context, buttonname: Text("Book Now"), onpressed: (){}),
                               
                              ],),
          );
        
}