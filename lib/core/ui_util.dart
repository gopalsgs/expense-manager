import 'package:flutter/material.dart';

class UIUtils {
  static void displayDialog({
    @required BuildContext context,
    @required String title,
    @required String message,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
        );
      },
    );
  }

  static void showSnackBar({
    @required BuildContext context,
    @required String text,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$text'),
      ),
    );
  }
}
