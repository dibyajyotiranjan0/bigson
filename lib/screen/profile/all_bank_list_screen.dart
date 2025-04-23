import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../static/appbar_widget.dart';
import '../../static/colors.dart';
import '../../viewmodel/profile/profile_viewmodel.dart';

class AllBankListScreen extends StatelessWidget {
  const AllBankListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context: context,img: false,title: "Your Bank "),
        body: Consumer<ProfileViewmodel>(builder: (context, proile, _) {
            
            return ListView.separated(
              padding: EdgeInsets.all(12),
              itemBuilder: (context,int){
              return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colo.white,
                          boxShadow: [
                            BoxShadow(color: Colo.greycolorCode, blurRadius: 4)
                          ]
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(15),
                          // ),
                          ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bank Details',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            proile.bankModel == null
                                ? SizedBox()
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Bank Name : ${proile.bankModel?.data?.bankName ?? ""}'),
                                      SizedBox(width: 8),
                                      Text(
                                          'Account Number : ${proile.bankModel?.data?.accountNo ?? ""}'),
                                      SizedBox(width: 8),
                                      Text(
                                          'IFSC Code : ${proile.bankModel?.data?.ifcCode ?? ""}'),
                                    ],
                                  ),
                            SizedBox(height: 8),
                            InkWell(
                              onTap: () {
                                context.push('/profie/bank', extra: {'id': "3"});
                              },
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${proile.bankModel == null ? "Add bank" : "Update Bank"}',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
            }, separatorBuilder: (item,index)=>SizedBox(height: 12,), itemCount: 1);
          }
        ),
    );
  }
}