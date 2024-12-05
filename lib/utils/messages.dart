import 'package:flutter/material.dart';

showErrorMessage(String textMessage, context) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Text(textMessage, style: const TextStyle(color: Colors.white)),
      duration: const Duration(seconds: 3),
    ),
  );
}