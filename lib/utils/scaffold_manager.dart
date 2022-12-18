import 'package:flutter/material.dart';

extension ScaffoldMessengerExtension on BuildContext {
  ScaffoldMessengerState get messenger => ScaffoldMessenger.of(this);

  void showSnackBar(String message) {
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // use this with unimplemented functionality
  void showUnderDevelopmentSnackBar() {
    messenger.showSnackBar(
      const SnackBar(
        content: Text(
          "THIS FEATURE IS UNDER DEVELOPMENT",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
