import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../static/appbar_widget.dart';
import '../../static/custom_elevated_button.dart';
import '../../viewmodel/quicksupport/support.dart';

class AddSupport extends StatelessWidget {
  AddSupport({super.key});
  final formkeyProfile = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context,img: false,title: "Add Road Side Assistance"),
      body:  SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child:  Consumer<SupportViewmodel>(
     builder: (context,support,_) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
               
                    Text(
                      "Describe Your Road Side Query/Problem in this form. Our team will resolve it very soon!",
                      textAlign: TextAlign.center,
                    ),
                    Form(
                      key: formkeyProfile,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          // Phone Input
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your phone number";
                              }
                              return null;
                            },
                            controller: support.phone,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 20),
                          // Query Input
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please describe your problem";
                              }
                              return null;
                            },
                            controller: support.query,
                            minLines: 3,
                            maxLines: 4,
                            decoration: InputDecoration(
                              labelText: 'Problem',
                              hintText: 'Describe Your Issue / Problem',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 20),
                          // Vehicle Number Input
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your vehicle number";
                              }
                              return null;
                            },
                            controller: support.vechicleno,
                            decoration: InputDecoration(
                              labelText: 'Vehicle Number',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: customElevatedButton(context: context, buttonname: Text("Submit"),onpressed: () {
                                if (formkeyProfile.currentState!.validate()) {
                                  support.addSupportViewmodel();
                                  // setState(() {
                                  //   queryUser.add({
                                  //     'num': phone.text,
                                  //     'qry': query.text,
                                  //     'vech': vechicleno.text,
                                  //   });
                                  //   phone.clear();
                                  //   query.clear();
                                  //   vechicleno.clear();
                                  // });
                                  Navigator.pop(context); // Close dialog
                                }
                              })
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            ),
          ),
       
    );
  }
}