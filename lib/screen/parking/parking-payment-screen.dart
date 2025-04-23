import 'package:bigsangrup/model/parking_list_model.dart';
import 'package:bigsangrup/static/appbar_widget.dart';
import 'package:bigsangrup/static/flutter_toast_message/toast_messge.dart';
import 'package:bigsangrup/viewmodel/profile/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../static/colors.dart';
import '../../viewmodel/parking/parking_viewmodel.dart';
import '../home/phonepay_pg_class.dart';

class ParkingPayment extends StatefulWidget {
  Datum? parkingData;
  ParkingPayment({required this.parkingData, super.key});

  @override
  State<ParkingPayment> createState() => _ParkingPaymentState();
}

class _ParkingPaymentState extends State<ParkingPayment> with WidgetsBindingObserver {
  String format12Hour(TimeOfDay time) {
  int hour = time.hourOfPeriod;
  String period = time.period == DayPeriod.am ? 'AM' : 'PM';
  return '${hour == 0 ? 12 : hour}:${time.minute.toString().padLeft(2, '0')} $period';
}

  @override
  Widget build(BuildContext context){

    var profileview =  Provider.of<ProfileViewmodel>(context, listen: false).profile;
      @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

    return Scaffold(
      appBar: appBar(context: context,img: false, title: "Book Parking"),
      bottomSheet:  SizedBox(
        height: 50,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10,left: 10,right: 10),
          child: Consumer<ParkingViewmodel>(builder: (context, parkvech, _) {
            
            return  ElevatedButton(
                                   onPressed: (){
  //                                   DateTime finalDateTime = DateTime(
  //   parkvech.selectedDate!.year,
  //   parkvech.selectedDate!.month,
  //   parkvech.selectedDate!.day,
  //   parkvech.selectedTime!.hour,
  //   parkvech.selectedTime!.minute,
  // );
  //                                   var date= finalDateTime.add(Duration(days:  parkvech.selectPrice?.time??0)).toString();
  //                                   print(date);
                                          // parkvech.pickTime(context);
                                          if (parkvech.selectPrice==null) {
                                            ShowToast(msg: "First Select Price");
                                          } else if(parkvech.myVehicle==null){
                                             ShowToast(msg: "First Select Your Vehicle Which You park");
                                          } else if(parkvech.selectedDate==null){
                                             ShowToast(msg: "Select Date of parking");
                                          } else if(parkvech.selectedTime==null){
                                             ShowToast(msg: "Select Time of Parking");
                                          }else{
                                              DateTime finalDateTime = DateTime(
    parkvech.selectedDate!.year,
    parkvech.selectedDate!.month,
    parkvech.selectedDate!.day,
    parkvech.selectedTime!.hour,
    parkvech.selectedTime!.minute,
  );
                                            if (profileview?.primumUser?.txnId !=null) {
                                                PhonepePg(amount: double.parse(parkvech.selectPrice?.subscriptionPrice.toString()??"0.0")).init().then((v){
                                                if (v) {
                                                  parkvech.bookParkingViewmodel(vehicleno: parkvech.myVehicle
                                                  ?.vehicleNo??"",parkingid: widget.parkingData?.parkingId.toString(),parkingdate: finalDateTime.toString(),paymentstatus: "sucess",parkingpriceid: parkvech.selectPrice?.id.toString(),parkingdate_2: finalDateTime.add(Duration(days:  parkvech.selectPrice?.time??0)).toString(),amount: parkvech.selectPrice?.subscriptionPrice.toString()??"",).then((val){
                                                    if (val) {
                                                       context.go('/home/parkwidget', extra: {'id': "0"});
                                                    } else {
                                                      null;
                                                      //  ShowToast(msg: "Parking Your Vehicle is Incomplete");
                                                    }
                                                  });
                                                } else {
                                                  ShowToast(msg: "Payment Failed");
                                                }
                                               });
                                            
                                            } else {
                                               PhonepePg(amount: double.parse(parkvech.selectPrice?.nonSubscriptionPrice.toString()??"0.0")).init().then((v){
                                                if (v) {
                                                  parkvech.bookParkingViewmodel(vehicleno: parkvech.myVehicle
                                                  ?.vehicleNo??"",parkingid: widget.parkingData?.parkingId.toString(),parkingdate: finalDateTime.toString(),paymentstatus: "sucess",parkingpriceid: parkvech.selectPrice?.id.toString(),parkingdate_2: finalDateTime.add(Duration(days:  parkvech.selectPrice?.time??0)).toString(),amount: parkvech.selectPrice?.nonSubscriptionPrice.toString()??"",).then((val){
                                                    if (val) {
                                                       context.go('/home/parkwidget', extra: {'id': "0"});
                                                    } else {
                                                      null;
                                                      //  ShowToast(msg: "Parking Your Vehicle is Incomplete");
                                                    }
                                                  });
                                                } else {
                                                  ShowToast(msg: "Payment Failed");
                                                }
                                               });
                                                     
                                            }
                                            
                                          }
                                        
                                 }, 
                                  style: ElevatedButton.styleFrom(
                                                backgroundColor: Colo.primaryColor,
                                                foregroundColor: Colo.white,
                                                padding: EdgeInsets.only(left: 10,right: 10),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))
                                              ),
                                 child:Text("Submit"));
            }
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 12,right: 12),
        child: Consumer<ParkingViewmodel>(builder: (context, parkvech, _) {
            
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Text("${widget.parkingData?.parkingName??""}",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold,fontSize: 24),)),
               SizedBox(height: 20,),
               ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.parkingData?.parkingPriceData?.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                return  InkWell(
                  onTap: (){
                    parkvech.selectparkingprriice(widget.parkingData?.parkingPriceData?[index]);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 8,right: 8,top: 4,bottom: 4),
                    margin: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    
                                    color:parkvech.selectPrice?.id==widget.parkingData?.parkingPriceData?[index].id?Color(0xFFEEEDF6): Colors.white,
                                  
                                    border: Border.all(
                                      color:parkvech.selectPrice?.id==widget.parkingData?.parkingPriceData?[index].id?Colo.green: Colo.greycolorCode,
                                      width: 2
                                    ),
                                    // boxShadow: [
                                    //   BoxShadow(color: Colo.greycolorCode, blurRadius: 4)
                                    // ]
                                    // shape: RoundedRectangleBorder(
                                    //   borderRadius: BorderRadius.circular(15),
                                    // ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      // crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text("Day",style:  Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                              Text("${widget.parkingData?.parkingPriceData?[index].time}")
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text("Subscribed Member",textAlign: TextAlign.center, style:  Theme.of(context)
                                            .textTheme
                                            .bodySmall!.copyWith(fontWeight: FontWeight.bold)),
                                              Text("Rs ${widget.parkingData?.parkingPriceData?[index].subscriptionPrice??""}")
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text("Non Subscribed Member",textAlign: TextAlign.center,style:  Theme.of(context)
                                            .textTheme
                                            .bodySmall!.copyWith(fontWeight: FontWeight.bold)),
                                              Text("Rs ${widget.parkingData?.parkingPriceData?[index].nonSubscriptionPrice??""}")
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                  ),
                );
               })
              ,SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                          "Your Vehicle",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),SizedBox(width: 12,),
                        TextButton.icon(
                           style: ElevatedButton.styleFrom(
                                        backgroundColor: Colo.primaryColor.withOpacity(0.2),
                                        foregroundColor: Colo.black,
                                        iconColor: Colo.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)
                                        )
                                      ),
                          onPressed: (){
                            context.push('/profie/vehicle', extra: {'id': "0",'book':true});
                          }, 
                          label: Text("Select Vehicle"),icon: Icon(Icons.fire_truck_rounded),)
                ],
              ),
             
                    // SizedBox(height: 10),
                   parkvech.myVehicle==null?SizedBox():   Container(
                                      padding: EdgeInsets.all(4),
                                      margin: EdgeInsets.only(top: 4),
                                      decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(8),
                       border: Border.all(color: Colo.primaryColor,width: 0.5)
                                      ),
                                      // height: 50,
                                      // color: Colo.primaryColor,
                                      // child: ListTile(
                                      //   leading: Image.network("${proile.vehicleModel?.data?[index].vehicleImageUrl??""}",width: 100,height: 200,fit: BoxFit.fill,),
                                      //   title:    Text.rich(TextSpan(children: [
                                      //       TextSpan(text: "No : "),
                                      //        TextSpan(text: "${proile.vehicleModel?.data?[index].vehicleNo??""}"),
                                      //     ])) ,
                                      //     subtitle: Text.rich(TextSpan(children: [
                                      //       TextSpan(text: "RC : "),
                                      //        TextSpan(text: "${proile.vehicleModel?.data?[index].vehicleNo??""}"),
                                      //     ])),
                         // trailing: OutlinedButton(onPressed: (){
                         //    context.push('/profie/addvehicle', extra: {'id': "3", "vech": proile.vehicleModel?.data?[index]??null});
                         // }, child: Text("Edit")),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Expanded(
                               child: Padding(
                                 padding: const EdgeInsets.only(left: 8),
                                 child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                       crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                        Text.rich(TextSpan(children: [
                                                       TextSpan(text: "Vehicle No : ",style: TextStyle(color: Colo.black,fontWeight: FontWeight.bold)),
                                                        TextSpan(text: "${parkvech.myVehicle?.vehicleNo??""}"),
                                                     ])), 
                                                    //  Text.rich(TextSpan(children: [
                                                    //    TextSpan(text: "RC NO : ",style: TextStyle(color: Colo.black,fontWeight: FontWeight.bold)),
                                                    //     TextSpan(text: "${parkvech.myVehicle?.vehicleNo??""}"),
                                                    //  ])),
                                                      Text.rich(TextSpan(children: [
                                                       TextSpan(text: "RC NO : ",style: TextStyle(color: Colo.black,fontWeight: FontWeight.bold)),
                                                        TextSpan(text: "${parkvech.myVehicle?.licienceNo??""}"),
                                                     ])), 
                                   ],
                                 ),
                               ),
                             ),
                             SizedBox(width: 8,),
                             ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          '${parkvech.myVehicle?.vehicleImageUrl??""}', // replace with your asset
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                            //  SizedBox(height: 100,width: 100, child: Image.network("${parkvech.myVehicle?.vehicleImageUrl??""}",fit: BoxFit.fill,height: 100,width: 100,)),
                             
                             
                           ],
                         ),
                       
                                      // )
                                      // Column(
                                      //   children: [
                                      //     Text.rich(TextSpan(children: [
                                      //       TextSpan(text: "Vehicle Number: "),
                                      //        TextSpan(text: "${proile.vehicleModel?.data?[index].vehicleNo??""}"),
                                      //     ])),
                                      //     Text.rich(TextSpan(children: [
                                      //       TextSpan(text: "RC Number: "),
                                      //        TextSpan(text: "${proile.vehicleModel?.data?[index].vehicleNo??""}"),
                                      //     ])),
                                      //   ],
                                      // ),
                                    ),
                                                  SizedBox(height: 20,),
                                                  Ink(
                                                    padding: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: Colo.white,
                                                      borderRadius: BorderRadius.circular(8),
                                                      border: Border.all(color: Colo.primaryColor,width: 0.5)
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("Select Entry Date and Time",style: Theme.of(context).textTheme.bodyLarge,),
                                                        SizedBox(height: 12,),
                                                        Row(
                                                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                               crossAxisAlignment: CrossAxisAlignment.center,
                                                                               children: [
                                                                                 ElevatedButton(
                                                                                   onPressed: (){
                                                                                          parkvech.pickDate(context);
                                                                                 }, 
                                                                                  style: ElevatedButton.styleFrom(
                                                                                                backgroundColor: Colo.primaryColor.withOpacity(0.4),
                                                                                                foregroundColor: Colo.white,
                                                                                                padding: EdgeInsets.only(left: 10,right: 10),
                                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))
                                                                                              ),
                                                                                 child: parkvech.selectedDate==null? Text("Select Date"): Text("Date: ${DateFormat("dd/MM/yyyy").format(parkvech.selectedDate!) }")),
                                                                                  ElevatedButton(
                                                                                   onPressed: (){
                                                                                          parkvech.pickTime(context);
                                                                                 }, 
                                                                                  style: ElevatedButton.styleFrom(
                                                                                                backgroundColor: Colo.primaryColor.withOpacity(0.4),
                                                                                                foregroundColor: Colo.white,
                                                                                                padding: EdgeInsets.only(left: 10,right: 10),
                                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))
                                                                                              ),
                                                                                 child:parkvech.selectedTime==null? Text("Select Time"):Text("Time: ${format12Hour(parkvech.selectedTime!)}")),
                                                                               ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 80,)
                                                  
                
              ],
            );
          }
        ),
      ),
    );
  }
}