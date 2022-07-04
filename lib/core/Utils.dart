// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Utils {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text, {Color? backgroundColor}) {
    final snackBar = SnackBar(
      backgroundColor: backgroundColor,
      content: Text(text ?? 'Some unknown error'),
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }


}
