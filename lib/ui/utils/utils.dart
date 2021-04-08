import 'package:flutter/material.dart';

class Utils {
  static void showBottomMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {},
        ),
      ),
    );
  }
}
