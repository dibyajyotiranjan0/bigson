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

class AddSlapForm extends StatefulWidget {
  Datum? data;
  AddSlapForm({this.data, super.key});

  @override
  State<AddSlapForm> createState() => _AddSlapFormState();
}

class _AddSlapFormState extends State<AddSlapForm> {
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
      appBar:appBar(context: context,img: false,title: "Create Challan"),
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

                // DropdownButtonFormField2<Transporter>(
                //   validator: (value) {
                //     if (value == null) {
                //       return 'Please select a type';
                //     }
                //     return null;
                //   },
                //   value: slip.transporter,
                //   decoration: InputDecoration(
                //     floatingLabelBehavior: FloatingLabelBehavior.always,
                //     labelText: 'Transporter',
                //     hintText: 'Select',
                //     hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                //     contentPadding:
                //         EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                //     alignLabelWithHint: true,
                //     enabledBorder: OutlineInputBorder(
                //       borderSide:
                //           BorderSide(color: Colo.greycolorCode, width: 1),
                //       //  BorderSide(
                //       //   color: Colo.buttonPrimary,
                //       //   width: 2.0,
                //       // ),
                //     ),
                //     border: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colo.greycolorCode)),
                //   ),
                //   items: slip.transporterModel?.transporters!
                //       .map((Transporter value) {
                //     return DropdownMenuItem<Transporter>(
                //       value: value,
                //       child: Text(value.name ?? ""),
                //     );
                //   }).toList(),
                //   onChanged: (Transporter? newValue) {
                //     slip.selecthouseholdAge(releast: newValue!);
                //   },
                //   dropdownStyleData: DropdownStyleData(
                //     width: MediaQuery.of(context).size.width * 1,
                //     padding: EdgeInsets.only(left: 30),
                //     decoration: BoxDecoration(
                //       // borderRadius: BorderRadius.circular(14),
                //       color: Colors.white,
                //     ),
                //     offset: const Offset(-20, 0),
                //   ),
                // ),
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
        //     TypeAheadField<Transporter>(
        //   textFieldConfiguration: TextFieldConfiguration(
        //     controller: _controller,
        //     decoration: InputDecoration(
        //       hintText: 'Type to search',
        //       hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
        //       contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        //       enabledBorder: OutlineInputBorder(
        //         borderSide: BorderSide(color: Colo.greycolorCode, width: 1),
        //       ),
        //       border: OutlineInputBorder(
        //           borderSide: BorderSide(color: Colo.greycolorCode)),
        //     ),
        //   ),
        //   suggestionsCallback: (pattern) {
        //     // Filter transporters based on user input.
        //     return slip.transporterModel?.transporters
        //             ?.where((transporter) =>
        //                 transporter.name?.toLowerCase().contains(pattern.toLowerCase()) ?? false)
        //             .toList() ??
        //         [];
        //   },
        //   itemBuilder: (context, Transporter suggestion) {
        //     return ListTile(
        //       title: Text(suggestion.name ?? ""),
        //     );
        //   },
        //   onSuggestionSelected: (Transporter selectedTransporter) {
        //     _controller.text = selectedTransporter.name ?? "";
        //     slip.selecthouseholdAge(releast: selectedTransporter);
        //   },
        //   noItemsFoundBuilder: (context) => Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Text(
        //       'No Transporter Found',
        //       style: TextStyle(color: Colors.grey),
        //     ),
        //   ),
        // ),
                
                SizedBox(height: 20),
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? "Vehicle Number Required" : null,
                  controller: slip.amount,
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
                  controller: slip.tddNo,
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
                SizedBox(height: 20),
                // Phone Input
                TextFormField(
                  validator: (value) {
                    if (value == null ||value.isEmpty) {
                      return 'Select Date';
                    }
                    return null;
                  },
                  controller: slip.date,
                  readOnly: true,
                  onTap: () => slip.selectavailableformDate(context),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colo.greycolorCode, width: 1),
                      //  BorderSide(
                      //   color: Colo.buttonPrimary,
                      //   width: 2.0,
                      // ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Select Date',
                    hintText: 'Date',
                    hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colo.greycolorCode)),
                  ),
                  keyboardType: TextInputType.datetime,
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
                            slip.insertFituredImage(context, 'f');
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
                    child: slip.uploadpick != null
                        ? Image.file(
                            slip.uploadpick!,
                          )
                        : slip.uploadpickUrl != null
                            ? Image.network(slip.uploadpickUrl.toString())
                            : Column(
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
                            slip.insertFituredImage(context, 'w');
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
                    child: slip.weightImage != null
                        ? Image.file(
                            slip.weightImage!,
                          )
                        : slip.weightImageUrl != null
                            ? Image.network(slip.weightImageUrl.toString())
                            : Column(
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

                Consumer<ProfileViewmodel>(
                  builder: (context,profile,_) {
                    return customElevatedButton(
                      context: context,
                      buttonname: slip.isloading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              "${widget.data != null ? "Update" : "Submit"}",
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
                           if (profile.profile?.primumUser?.txnId !=null) {
                           if (widget.data == null) {
                       
                            slip.addSlipViewmodel(price: "${slip.commisionCharge?.data?.value??50}",payment_sts: "SUCCESS",paid_am: "${slip.commisionCharge?.data?.value??50}").then((v) {
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
                          } else {
                            slip
                                .updateSlipViewmodel(
                                    slipId: widget.data!.id.toString())
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
                        } else {
                         
                          // for (var i = 0; i < 10; i++) {
                          //   print(v);
                          // }
                          if (widget.data == null) {
                            slip.ComissionView().then((v){
                                if (v) {
                             _showCommision(context);     
                                }});
                          } else {
                            slip
                                .updateSlipViewmodel(
                                    slipId: widget.data!.id.toString())
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
                        
                       
                        }
                        
                         
                        }
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
