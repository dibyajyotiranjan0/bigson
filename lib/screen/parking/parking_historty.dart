import 'package:bigsangrup/static/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../model/user_parking_model.dart';
import '../../static/colors.dart';

class ParkingHistorty extends StatelessWidget {
  UserparkingModel? myParking;

  ParkingHistorty({required this.myParking,super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context,img: false, title: "Parking History"),
     
      body:    ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(12),
                  itemCount: myParking?.data?.length,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
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
                                    child: Text("${myParking?.data?[index].parkingDetails?.parkingName??""}",style:  Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontSize: 21)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20,right: 20),
                                    child: Divider(thickness: 1,height: 0,),
                                  ),
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
                                            child: Text("Plot No",style:  Theme.of(context)
                                              .textTheme
                                              .bodyMedium,)
                                            ,),
                                            Expanded(
                                              child: Text(": ${myParking?.data?[index].parkingPlotNo??""}",maxLines: 2,overflow: TextOverflow.ellipsis, style:  Theme.of(context)
                                                .textTheme
                                                .bodyLarge!.copyWith(color: Colo.black,fontWeight: FontWeight.w500)),
                                            )
                                          ],),
                                          SizedBox(height: 4,),
                               
                                        ],
                                      ),
                                    ),
                                  ],
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
                                  child: Text(": ${myParking?.data?[index].parkingDetails?.parkingLocation??""}",maxLines: 2,overflow: TextOverflow.ellipsis, style:  Theme.of(context)
                                    .textTheme
                                    .bodyLarge!.copyWith(color: Colo.blackShade45)),
                                )
                              ],),
                              SizedBox(height: 4,),
                               Row(
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
                                      launchUrlString("tel://${myParking?.data?[index].parkingDetails?.parkingPhoneNumber??""}");
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(": ${myParking?.data?[index].parkingDetails?.parkingPhoneNumber??""}",maxLines: 2,overflow: TextOverflow.ellipsis, style:  Theme.of(context)
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
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.start,
                                        //   crossAxisAlignment: CrossAxisAlignment.start,
                                        //   children: [
                                        //   SizedBox(width: 80,
                                        //   child: Text("Parking",style:  Theme.of(context)
                                        //     .textTheme
                                        //     .bodyMedium,)
                                        //   ,),
                                        //   // Expanded(
                                        //   //   child: Text(": ${parkingData?.parkingCapacity??0-(parkingData?.parkingVehicleCount??0)}/${parkingData?.parkingCapacity??""}",maxLines: 2,overflow: TextOverflow.ellipsis, style:  Theme.of(context)
                                        //   //     .textTheme
                                        //   //     .bodyLarge!.copyWith(color: Colo.black,fontWeight: FontWeight.w500)),
                                        //   // )
                                        // ],),
                                        SizedBox(height: 4,),
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
                                          child: Text("Vehicle No",style:  Theme.of(context)
                                            .textTheme
                                            .bodyMedium,)
                                          ,),
                                          Expanded(
                                            child: Text(": ${myParking?.data?[index].vehicleNo??""}",maxLines: 2,overflow: TextOverflow.ellipsis, style:  Theme.of(context)
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
                                  child: Text(": ${myParking?.data?[index].parkingDetails?.parkingTime??""}",maxLines: 2,overflow: TextOverflow.ellipsis, style:  Theme.of(context)
                                    .textTheme
                                    .bodyLarge!.copyWith(color: Colo.blackShade45,fontWeight: FontWeight.w500)),
                                )
                              ],),
                              
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              
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
                                          child: Text("Entry Time",style:  Theme.of(context)
                                            .textTheme
                                            .bodyMedium,)
                                          ,),
                                          Expanded(
                                            child:myParking?.data?[index].parkingDate==null?Text(": "): Text(": ${DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(myParking?.data?[index].parkingDate??""))}",maxLines: 2,overflow: TextOverflow.ellipsis, style:  Theme.of(context)
                                              .textTheme
                                              .bodyLarge!.copyWith(color: Colo.black,fontWeight: FontWeight.w500)),
                                          )
                                        ],),
                                        SizedBox(height: 4,),
                             
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
                                            child: Text("Out Time",style:  Theme.of(context)
                                              .textTheme
                                              .bodyMedium,)
                                            ,),
                                            Expanded(
                                              child:myParking?.data?[index].parkingDate2==null?Text(": "): Text(": ${DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(myParking?.data?[index].parkingDate2??""))}",maxLines: 2,overflow: TextOverflow.ellipsis, style:  Theme.of(context)
                                                .textTheme
                                                .bodyLarge!.copyWith(color: Colo.black,fontWeight: FontWeight.w500)),
                                            )
                                          ],),
                                          SizedBox(height: 4,),
                               
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                
                              SizedBox(height: 4,),
                              
                                 
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: 4,),
                              
                               
                              ],),
          );
                  })
                  ,
    );
  }
}