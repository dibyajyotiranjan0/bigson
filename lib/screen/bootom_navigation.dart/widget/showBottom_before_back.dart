import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

Future<bool> showExitDialog(BuildContext context) async {
  return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Confirm Exit"),
          content: Text("Do you really want to exit the app?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Stay in app
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // Exit app
              child: Text("Exit"),
            ),
          ],
        ),
      ) ??
      false; // Return false if dialog is dismissed
}
