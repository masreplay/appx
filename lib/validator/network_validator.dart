import 'package:error_handler/error_handler.dart';
import 'package:flutter/material.dart';

class ValidationMessage {
  final DefinedException exception;
  final String message;

  ValidationMessage({
    required this.exception,
    required this.message,
  });
}

abstract class LocalizedDefinedException extends DefinedException {
  const LocalizedDefinedException({required super.tag});

  String localize(BuildContext context);

  ValidationMessage getMessage(BuildContext context) {
    return ValidationMessage(
      exception: this,
      message: localize(context),
    );
  }
}

extension ValidationMessageException on UiState {
  String? getErrorMessage(
    BuildContext context,
    Set<LocalizedDefinedException> exceptions, {
    String separator = " ,\n",
    String end = "",
  }) {
    return whenOrNull<String?>(
      error: (error) {
        String? validationMessage;

        for (var exception in exceptions) {
          error.equalDo(
            exception,
            ifEqual: (error) {
              if (validationMessage == null) {
                validationMessage = exception.localize(context);
              } else {
                validationMessage =
                    "$validationMessage$separator${exception.localize(context)}";
              }
            },
          );
        }

        return validationMessage;
      },
    );
  }
}
