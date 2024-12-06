import 'package:flutter/material.dart';
import 'package:plant_match/core/app_colors.dart';

class Message {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static void showSnackBar(String? message) {
    if (message == null) return;

    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: AppColors.error,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
