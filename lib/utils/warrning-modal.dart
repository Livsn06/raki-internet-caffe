import 'package:flutter/material.dart';

void warningModal(
  BuildContext context, {
  required String title,
  required String message,
  List<Widget>? actions,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: actions,
      );
    },
  );
}
