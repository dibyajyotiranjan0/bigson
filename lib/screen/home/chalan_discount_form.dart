import 'package:bigsangrup/viewmodel/home/home_viewmodel.dart';
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
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../model/history_model.dart';
import '../../model/transporter_model.dart';
import '../../static/appbar_widget.dart';
import 'phonepay_pg_class.dart';

class ChalanDiscountForm extends StatefulWidget {
  Datum? data;
  ChalanDiscountForm({this.data, super.key});

  @override
  State<ChalanDiscountForm> createState() => _ChalanDiscountFormState();
}

class _ChalanDiscountFormState extends State<ChalanDiscountForm> {
  void _showCommision(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Consumer<HomeViewmodel>(
            builder: (context,service,_) {
              return AlertDialog(
                title: Text("Commision Charges"),
                content: Text.rich(TextSpan(children: [
                  TextSpan(text: "You need to pay  ",
                   style: Theme.of(context).textTheme.bodyMedium),
                  TextSpan(
                    text: "\u{20B9} ${service.commisionCharge?.data?.value}",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 21,fontWeight: FontWeight.bold)
                    
                  )
                ])),
                // Text("You need to pay the \u{20B9} ${service.commisionCharge?.data?.value}"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pop(); // Close the dialog without action
                    },
                    child: Text("Cancel"),
                  ),
              ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colo.primaryColor),
                      onPressed: () {
                          PhonepePg(amount: service.commisionCharge?.data?.value?.toDouble()??50.0).init().then((v){ 
                              if (v) {
                                service.addSlipViewmodel(price: "${service.commisionCharge?.data?.value??50}",payment_sts: "SUCCESS",paid_am: "${service.commisionCharge?.data?.value??50}").then((v) {
                              if (v) {
                                context.pop();
                                // context.pushReplacement('/home',
                                //     extra: {'id': "0"});
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             NavigationScreen()));
                              }
                            }); 
                              }
                             
                          });
                          
                        // login.Logout().then((v) {
                        //   if (v) {
                        //     context.go('/login');
                        //   }
                        // });
                        // Perform the logout action here
                        // Navigator.of(context).pop(); // Close the dialog
                        // Add your logout logic here (e.g., navigating to login screen)
                      },
                      child: Text(
                        "Proceed",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colo.white),
                      ),
                    )
                  
                ],
              );
            }
          );
        },
      );
    }

 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // Your function that needs to run after context is available
      Provider.of<HomeViewmodel>(context, listen: false)
          .transporterViewmodel()
          .then((v) {
        widget.data != null
            ? Provider.of<HomeViewmodel>(context, listen: false)
                .initloadAddslip(widget.data!)
            : null;
      });
    });
  }

  final formkeySlip = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBar(context: context,img: false,title: "Challan Discount"),
      //  AppBar(
      //   automaticallyImplyLeading: true,
      //   title: Text('Create Challan',
      //       style: Theme.of(context).textTheme.titleMedium),
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SizedBox(
            // height: MediaQuery.of(context).size.height * 0.8,
            child: Form(
          key: formkeySlip,
          child: Consumer<HomeViewmodel>(builder: (context, slip, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30),

                TypeAheadField<Transporter>(
                   builder: (context, controller, focusNode) {
    return TextFormField(
      controller: slip.slipCopntroller,
      focusNode: focusNode,
      // obscureText: true,
      validator: (value){
        if (value==null|| value.isEmpty) {
          return "Transporter Name REquired";
        } else {
        return  null;
        }
      },
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.search),
        hintText: "Search Transporter",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        // labelText: 'Password',
      ),
    );
  },
                  itemBuilder:(context, Transporter suggestion) {
            return ListTile(
              title: Text(suggestion.name ?? ""),
            );
          }, 
                 
                 onSelected: 
                   (Transporter? newValue) {
                    slip.selecthouseholdAge(releast: newValue!);
                  }, 
                  suggestionsCallback:(pattern) {
            // Filter transporters based on user input.
            return slip.transporterModel?.transporters
                    ?.where((transporter) =>
                        transporter.name?.toLowerCase().contains(pattern.toLowerCase()) ?? false)
                    .toList() ??
                [];
          },),
    
                
                SizedBox(height: 20),
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? "Vehicle Number Required" : null,
                  controller: slip.distruckNo,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Vehicle / Truck Number ',
                    labelStyle: Theme.of(context).textTheme.bodySmall,
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colo.greycolorCode, width: 1.5),
                      //  BorderSide(
                      //   color: Colo.buttonPrimary,
                      //   width: 2.0,
                      // ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Email Input
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? "Enter Challan Number" : null,
                  controller: slip.dischallanNo,
                  decoration: InputDecoration(
                    labelText: 'Challan Number',
                    labelStyle: Theme.of(context).textTheme.bodySmall,
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colo.greycolorCode, width: 1.5),
                      //  BorderSide(
                      //   color: Colo.buttonPrimary,
                      //   width: 2.0,
                      // ),
                    ),
                  ),
                ),
                
                // Phone Input
                // TextFormField(
                //   validator: (value) {
                //     if (value == null ||value.isEmpty) {
                //       return 'Select Date';
                //     }
                //     return null;
                //   },
                //   controller: slip.date,
                //   readOnly: true,
                //   onTap: () => slip.selectavailableformDate(context),
                //   decoration: InputDecoration(
                //     enabledBorder: OutlineInputBorder(
                //       borderSide:
                //           BorderSide(color: Colo.greycolorCode, width: 1),
                //       //  BorderSide(
                //       //   color: Colo.buttonPrimary,
                //       //   width: 2.0,
                //       // ),
                //     ),
                //     floatingLabelBehavior: FloatingLabelBehavior.always,
                //     labelText: 'Select Date',
                //     hintText: 'Date',
                //     hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                //     contentPadding:
                //         EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                //     border: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colo.greycolorCode)),
                //   ),
                //   keyboardType: TextInputType.datetime,
                // ),
                SizedBox(height: 20),
               TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? "Enter Cash Advance" : null,
                  controller: slip.discashAdvance,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Cash Advance',
                    labelStyle: Theme.of(context).textTheme.bodySmall,
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colo.greycolorCode, width: 1.5),
                      //  BorderSide(
                      //   color: Colo.buttonPrimary,
                      //   width: 2.0,
                      // ),
                    ),
                  ),
                ),
                 SizedBox(height: 20),
               TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? "Enter Token Charges" : null,
                  controller: slip.distokenchar,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Token Charges',
                    labelStyle: Theme.of(context).textTheme.bodySmall,
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colo.greycolorCode, width: 1.5),
                      //  BorderSide(
                      //   color: Colo.buttonPrimary,
                      //   width: 2.0,
                      // ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Challan Image",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(
                      height: 30,
                      child: ElevatedButton(
                          onPressed: () {
                            slip.insertFituredImage(context, 'df');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colo.primaryColor,
                            foregroundColor: Colo.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text("Upload")),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 150,
                  child: Center(
                    child: slip.uploaddischallan != null
                        ? Image.file(
                            slip.uploaddischallan!,
                          )
                        :  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Upload Challan Image',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  const SizedBox(height: 10),
                                  const Icon(
                                    Icons.file_upload_outlined,
                                    color: Colo.buttonPrimary,
                                    size: 40,
                                  ),
                                ],
                              ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Weight Image",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(
                      height: 30,
                      child: ElevatedButton(
                          onPressed: () {
                            slip.insertFituredImage(context, 'dw');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colo.primaryColor,
                            foregroundColor: Colo.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text("Upload")),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 150,
                  child: Center(
                    child: slip.uploaddisweightImage != null
                        ? Image.file(
                            slip.uploaddisweightImage!,
                          )
                        :  Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Upload Weight Image',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  SizedBox(height: 10),
                                  Icon(
                                    Icons.file_upload_outlined,
                                    color: Colo.buttonPrimary,
                                    size: 40,
                                  ),
                                ],
                              ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Slip Image",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(
                      height: 30,
                      child: ElevatedButton(
                          onPressed: () {
                            slip.insertFituredImage(context, 'dch');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colo.primaryColor,
                            foregroundColor: Colo.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text("Upload")),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 150,
                  child: Center(
                    child: slip.uploaddisslipImage != null
                        ? Image.file(
                            slip.uploaddisslipImage!,
                          )
                        : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Upload Slip Image',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  const SizedBox(height: 10),
                                  const Icon(
                                    Icons.file_upload_outlined,
                                    color: Colo.buttonPrimary,
                                    size: 40,
                                  ),
                                ],
                              ),
                  ),
                ),
                SizedBox(height: 20),
                

                Consumer<ProfileViewmodel>(
                  builder: (context,profile,_) {
                    return customElevatedButton(
                      context: context,
                      buttonname: slip.isloading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              "Submit",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colo.primaryColorSecond),
                            ),
                            // onpressed: (){
                            //   slip.ComissionView().then((v){
                            //     if (v) {
                            //  _showCommision(context);     
                            //     }
                            //   });
                              
                            // }
                      onpressed: () {
                        
                        // context.pop();
                        if (formkeySlip.currentState!.validate()) {
                          //  ShowToast(msg: "Sumited Sucessfully");
                          //  if (profile.profile?.primumUser?.txnId !=null) {
                          //  if (widget.data == null) {
                       
                          //   slip.addSlipViewmodel(price: "${slip.commisionCharge?.data?.value??50}",payment_sts: "SUCCESS",paid_am: "${slip.commisionCharge?.data?.value??50}").then((v) {
                          //     if (v) {
                          //       context.pop();
                          //       // context.pushReplacement('/home',
                          //       //     extra: {'id': "0"});
                          //       // Navigator.push(
                          //       //     context,
                          //       //     MaterialPageRoute(
                          //       //         builder: (context) =>
                          //       //             NavigationScreen()));
                          //     }
                          //   });
                          // } else {
                          if (slip.uploaddischallan==null) {
                            ShowToast(msg: "Upload Chalan Image");
                          } else if(slip.uploaddisweightImage==null) {
                            ShowToast(msg: "Upload Weight Image");
                          }else if(slip.uploaddisslipImage==null){
                            ShowToast(msg: "Upload Slip image");
                          }else {
                             slip
                                .discountaddSlipViewmodel()
                                .then((v) {
                              if (v) {
                                context.pop();
                                // context.pushReplacement('/home',
                                //     extra: {'id': "0"});
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             NavigationScreen()));
                              }
                            });
                          }
                           
                          // }
                        
                         
                        } else {
                         
                          // for (var i = 0; i < 10; i++) {
                          //   print(v);
                          // }
                          // if (widget.data == null) {
                          //   slip.ComissionView().then((v){
                          //       if (v) {
                          //    _showCommision(context);     
                          //       }});
                          // } else {
                          //   slip
                          //       .updateSlipViewmodel(
                          //           slipId: widget.data!.id.toString())
                          //       .then((v) {
                          //     if (v) {
                          //       context.pop();
                          //       // context.pushReplacement('/home',
                          //       //     extra: {'id': "0"});
                          //       // Navigator.push(
                          //       //     context,
                          //       //     MaterialPageRoute(
                          //       //         builder: (context) =>
                          //       //             NavigationScreen()));
                          //     }
                          //   });
                          // }
                        
                       
                        }
                        
                         
                        // }
                      },
                    );
                  }
                ),
                SizedBox(
                  height: 20,
                )
               
              ],
            );
          }),
        )),
      ),
    );
  }
}
