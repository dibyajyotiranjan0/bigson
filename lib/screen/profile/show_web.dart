import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../static/appbar_widget.dart';
// import 'package:webview_flutter_android/webview_flutter_android.dart';

class ShowWeb extends StatefulWidget {
  final String urll;
  ShowWeb({required this.urll, super.key});

  @override
  State<ShowWeb> createState() => _ShowWebState();
}

class _ShowWebState extends State<ShowWeb> {
  bool _isLoading = true;
  late final _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    // ..runJavaScript(
    //     "document.getElementsByTagName('body')[0].style.display='none';")
    ..loadRequest(Uri.parse(widget.urll))
    ..enableZoom(false);

  // ..setNavigationDelegate(NavigationDelegate(
  //   onProgress: (int progress) {
  //     CircularProgressIndicator();
  //     // Update loading bar.
  //   },
  //   onPageStarted: (String url) {
  //       if (url.contains('https://getmobie.de/')) {
  //            //Added delayed future method for wait for the website to load fully before calling javascript
  //             Future.delayed(Duration(milliseconds: 900), () {
  //               _controller.runJavascriptReturningResult(
  //                     "document.getElementsByClassName('elementor elementor-7715 elementor-location-header')[0].style.display='none';"
  //                     "document.getElementsByClassName('elementor elementor-2727 elementor-location-footer')[0].style.display='none';"
  //               );
  //             });
  //   },
  // onPageFinished: (String url) {
  //   print(url);

  // _controller.runJavascript("document.getElementsByTagName('header')[0].style.display='none'");
  // onPageFinished: (url) async {
  // _controller.runJavascript("document.getElementsByTagName('header')[0].style.display='none'");
  // },
  //  },
  //   onWebResourceError: (WebResourceError error) {},
  //   // onNavigationRequest: (NavigationRequest request) {
  //   //   if (request.url.startsWith('https://www.youtube.com/')) {
  //   //     return NavigationDecision.prevent;
  //   //   }
  //   //   return NavigationDecision.navigate;
  //   // },
  //));

  // static get section => null;
  // ..runJavaScript(
  //     "document.getElementsByTagName('footer')[0].style.display='none'");
  // ..runJavaScript(
  //     "document.getElementsByTagName('header')[0].style.display='none'")

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.setNavigationDelegate(NavigationDelegate(
        onPageStarted: (String url) {
          setState(() {
            _isLoading = true;
          });
        },
        onPageFinished: (url) async {
          setState(() {
            _isLoading = false;
          });
          _controller.runJavaScript(
             "document.getElementsByClassName('topnav').style.display='none';"//
             "document.getElementsByClassName('nav-menu').style.display='none';"
              // "document.getElementById('colophon').style.display='none';" //
              // "document.getElementById('feranta').style.display='none';" //
              // "document.getElementsByTagName('footer').style.display='none'"
              ); //uk-background-cover
        },
      ));
    });
    //     .setNavigationDelegate(NavigationDelegate(onProgress: (int progress) {
    //   CircularProgressIndicator();
    //   // Update loading bar.
    // }, onPageStarted: (String url) {
    //   if (url.contains('https://getmobie.de/')) {
    //     //Added delayed future method for wait for the website to load fully before calling javascript
    //     Future.delayed(Duration(milliseconds: 900), () {
    //       _controller.runJavaScriptReturningResult(
    //           "document.getElementsByClassName('elementor elementor-7715 elementor-location-header')[0].style.display='none';"
    //           "document.getElementsByClassName('elementor elementor-2727 elementor-location-footer')[0].style.display='none';");
    //     });
    //   }
    //   // onPageFinished: (String url) {
    //   //   print(url);
    //   // },
    //   // onWebResourceError: (WebResourceError error) {},
    //   // onNavigationRequest: (NavigationRequest request) {
    //   //   if (request.url.startsWith('https://www.youtube.com/')) {
    //   //     return NavigationDecision.prevent;
    //   //   }
    //   //   return NavigationDecision.navigate;
    //   // },
    // }));

    // _controller.runJavaScript(
    //     "document.getElementsByClassName('uk-container')[0].style.display");//navbar
  }

  @override
  Widget build(BuildContext context) {
    _controller.scrollTo(0, 0);
    return Scaffold(
      appBar: appBar(context: context,img: false,title: ""),
        // appBar: AppBar(
        //   title: Text(""),
        // ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : WebViewWidget(controller: _controller),
        )));
  }
}
