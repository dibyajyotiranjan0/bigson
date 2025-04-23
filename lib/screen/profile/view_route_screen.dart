import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../static/appbar_widget.dart';

class ViewRouteScreen extends StatelessWidget {
  const ViewRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  appBar(context: context,img: false,title: "Rate Info"),
      // appBar: AppBar(
      //   automaticallyImplyLeading: true,
      //   title: Text('All Route',
      //       style: Theme.of(context).textTheme.titleMedium),
      // ),
      body: Container(
          child: SfPdfViewer.network(
              'https://bigsangroup.com/FreightRate.pdf'))
    );
  }
}