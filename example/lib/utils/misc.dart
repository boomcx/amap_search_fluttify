import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission() async {
  final status = await Permission.location.request();

  if (status == PermissionStatus.granted) {
    return true;
  } else {
    return false;
  }
}

void showToast(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
