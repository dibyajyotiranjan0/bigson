import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  String? uri;
  ErrorScreen({super.key, this.uri});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Error Route"),
      ),
      body: Center(
        child: Text("Error Screen $uri"),
      ),
    );
  }
}
