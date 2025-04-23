import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../static/appbar_widget.dart';
import '../../static/colors.dart';
import '../../static/custom_elevated_button.dart';
import '../../static/textfield_controller/textfieldValidator.dart';
import '../../viewmodel/quicksupport/support.dart';

class QuickSupportScreen extends StatefulWidget {
 QuickSupportScreen({super.key});

  @override
  State<QuickSupportScreen> createState() => _QuickSupportScreenState();
}

class _QuickSupportScreenState extends State<QuickSupportScreen> {
 
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // Your function that needs to run after context is available
      Provider.of<SupportViewmodel>(context, listen: false).supportViewmodel();
    });
  }

 List<Map<String,dynamic>> queryUser =[];
  //  void showQueryDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return  Dialog(
  //         insetPadding: EdgeInsets.zero,
  //         backgroundColor: Colors.white,
  //         child: Container(
  //           height: MediaQuery.of(context).size.height,
  //           width: MediaQuery.of(context).size.width,
  //         // padding: EdgeInsets.all(15),
  //           child:  ));
  //     },
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context,img: true,title: "Road Side Assistance"),
  //      appBar: AppBar(
  //       automaticallyImplyLeading: true,
  //        shape: Border(
  //   bottom: BorderSide(
  //     color: Colors.orange,
  //     width: 1
  //   )
  // ),
  // elevation: 4,
  //       centerTitle: true,
  //       title: Text('Quick Support',
  //            style: Theme.of(context).textTheme.titleLarge,),
  //     ),

  floatingActionButton: FloatingActionButton(
    backgroundColor: Colo.primaryColor,
    onPressed: (){
       context.push('/supporrt/addsupport', extra: {'id': "2"});
    },
    child: Icon(Icons.contact_support_outlined,size: 28,color: Colo.white,),
  ),
  floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      
   body: Consumer<SupportViewmodel>(
     builder: (context,support,_) {
       return support.support==null?RefreshIndicator(onRefresh: ()async{
        Provider.of<SupportViewmodel>(context, listen: false).supportViewmodel();
       }, child: SingleChildScrollView(physics: AlwaysScrollableScrollPhysics(), child: SizedBox(height: MediaQuery.sizeOf(context).height*0.8, child: Center(child: Text("No Road Side Assistance"))))): Column(
         children: [
          SizedBox(height: 10,),
           ListView.builder(
            itemCount: support.support?.data?.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 8,right: 8),
            itemBuilder: (context,index){
            return Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color:support.support?.data?[index].status==0? Colo.primaryColor.withOpacity(0.6):Colo.green,//when solve your query green other wise primery color
                  // color:
                  //     Colors.primaries[math.Random().nextInt(Colors.primaries.length)],
                  //Colo.primaryColor.withOpacity(0.7), // Orange background color
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colo.greycolorCode, blurRadius: 4)]),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    width: double.maxFinite,
                    child: Padding(
                      padding: EdgeInsets.only(left: 6, top: 5, bottom: 5,right: 12),
                     child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(),
                        Text("${support.support?.data?[index].status==0?"Pending":"Solved"}",style: TextStyle(color: Colo.white,fontWeight: FontWeight.bold),)
                        // Container(
                        //     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        //     decoration: BoxDecoration(
                        //       color: "2" == "0"
                        //           ? Colo.white
                        //           : Colors.green,
                        //       boxShadow: [
                        //         BoxShadow(color: Colo.greycolorCode, blurRadius: 4)
                        //       ],
                        //       borderRadius: BorderRadius.circular(12),
                        //     ),
                        //     child: Text(
                        //       "Pending",
                        //       style: TextStyle(
                        //         // color: data.isPaid.toString() == "0"
                        //         //     ? Color(0xFFFF6E40)
                        //         //     : Colors.white, // Orange text color
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //   ),
                        
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
                          
                          title:Text.rich(
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            TextSpan(children: [
                            TextSpan(
                              text: "Your Query :  "
                            ),
                            TextSpan(
                              text: "${support.support?.data?[index].text??""}"
                            )
                          ])),
                          subtitle: Text(
                              "Date : ${DateFormat('dd-MM-yyyy h:mm a').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse("${support.support?.data?[index].createdAt?.trim()??""}"))}"),
                          // trailing: 
                        )
                        
           
                        ),
                  ),
                ],
              ),
            );
           }),
         SizedBox(height: 10,)
         ],
       );
     }
   ),
    );
  }
}