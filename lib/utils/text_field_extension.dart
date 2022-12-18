import 'package:flutter/material.dart';

extension TextEditingControllerExtension on TextEditingController {
  void selectAllText() {
    selection = TextSelection(
      baseOffset: 0,
      extentOffset: value.text.length,
    );
  }
}
