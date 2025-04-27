import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  void navigateTo(String routeName) {
    Navigator.pushNamed(this, routeName);
  }

  void navigateReplacementTo(String routeName) {
    Navigator.pushReplacementNamed(this, routeName);
  }

  void navigateBack() {
    Navigator.pop(this);
  }
}

extension ShowSnackBar on BuildContext {
  void showSnackBar(String message, {Color? backgroundColor}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }
}