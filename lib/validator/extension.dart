import 'package:flutter/material.dart';

extension FormStateExtension on GlobalKey<FormState> {
  bool isValid() {
    return currentState!.validate();
  }

  bool isNotValid() {
    return !currentState!.validate();
  }
}
