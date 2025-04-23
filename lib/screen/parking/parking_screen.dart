import 'package:bigsangrup/model/parking_list_model.dart';
import 'package:bigsangrup/screen/parking/parking_widget.dart';
import 'package:bigsangrup/static/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../static/colors.dart';
import '../../viewmodel/parking/parking_viewmodel.dart';

class ParkingScreen extends StatefulWidget {
  const ParkingScreen({super.key});

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Your function that needs to run after context is available
      Provider.of<ParkingViewmodel>(context, listen: false)..allParkingViewmodel()..myParkingViewmodel();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context, img: false, title: "Parking"),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(left: 10,right: 10),
        child: Consumer<ParkingViewmodel>(builder: (context, parking, _) {
            
            return parking.allParking==null?Center(child: CircularProgressIndicator(),): 
           RefreshIndicator(
            onRefresh: ()async{
              print(parking.myParking?.toJson());
            },
             child: ListView(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  parking.myParking==null?SizedBox():
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                                "Your Recent parking",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              TextButton(onPressed: (){
                                 context.push("/home/recentPark",extra: {"id":"0",'myParking':parking.myParking});
                                
                              }, child: Text("View All"))
                        ],
                      ),
                        SizedBox(height: 4),
                     parking.myParking?.data==null|| parking.myParking?.data?.length==0?SizedBox(): ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    physics: NeverScrollableScrollPhysics(),
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
                                      child: Text("${parking.myParking?.data?[index].parkingDetails?.parkingName??""}",style:  Theme.of(context)
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
                                    child: Text(": ${parking.myParking?.data?[index].parkingDetails?.parkingLocation??""}",maxLines: 2,overflow: TextOverflow.ellipsis, style:  Theme.of(context)
                                      .textTheme
                                      .bodyLarge!.copyWith(color: Colo.blackShade45)),
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
                                            child: Text("Plot No",style:  Theme.of(context)
                                              .textTheme
                                              .bodyMedium,)
                                            ,),
                                            Expanded(
                                              child: Text(": ${parking.myParking?.data?[index].parkingPlotNo??""}",maxLines: 2,overflow: TextOverflow.ellipsis, style:  Theme.of(context)
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
                                        launchUrlString("tel://${parking.myParking?.data?[index].parkingDetails?.parkingPhoneNumber??""}");
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(": ${parking.myParking?.data?[index].parkingDetails?.parkingPhoneNumber??""}",maxLines: 2,overflow: TextOverflow.ellipsis, style:  Theme.of(context)
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
                                            child: Text("Vehicle No",style:  Theme.of(context)
                                              .textTheme
                                              .bodyMedium,)
                                            ,),
                                            Expanded(
                                              child: Text(": ${parking.myParking?.data?[index].vehicleNo??""}",maxLines: 2,overflow: TextOverflow.ellipsis, style:  Theme.of(context)
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
                                    child: Text(": ${parking.myParking?.data?[index].parkingDetails?.parkingTime??""}",maxLines: 2,overflow: TextOverflow.ellipsis, style:  Theme.of(context)
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
                                              child: Text(": ${DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(parking.myParking?.data?[index].parkingDate??""))}",maxLines: 2,overflow: TextOverflow.ellipsis, style:  Theme.of(context)
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
                                              child: Text(": ${DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(parking.myParking?.data?[index].parkingDate2??""))}",maxLines: 2,overflow: TextOverflow.ellipsis, style:  Theme.of(context)
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
                                
                                 
                                ],),
                       );
                    })
                    ]               
                     ),
                   Text(
                        "parking List",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(height: 10),
                  parking.allParking?.data?.length==0?Center(child: Text("No Parking"),): ListView.builder(
                    shrinkWrap: true,
                    itemCount:parking.allParking?.data?.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                    return parkingWidget(context,false,parkingData: parking.allParking?.data![index]);}),
                ],
              ),
           );
          }
        ),
      ),
    );
  }
}