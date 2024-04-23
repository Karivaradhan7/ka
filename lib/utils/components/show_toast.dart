import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1, // 1 second for iOS and web
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}