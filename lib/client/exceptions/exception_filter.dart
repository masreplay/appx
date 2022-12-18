import 'package:appx/validator/validator.dart';
import 'package:error_handler/error_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

NetworkException handle400And401Exception(
    ResponseValue response, Set<DefinedException> exceptions) {
  if (response.statusCode == 400 || response.statusCode == 401) {
    final message = response.data["message"];

    for (var exception in exceptions) {
      if (exception.tag == message) {
        if (kDebugMode) print("exception 400 $exception");
        return exception.get();
      }
    }
  }
  return NetworkException.responseException(response);
}

/// class ExampleExceptionFilter extends NetworkExceptionFilter {
///  static const Set<DefinedException> exceptions = {};
///
///  @override
///  NetworkException whenResponseException(ResponseValue response) {
///    return handle400And401Exception(response, exceptions);
///  }
///}

String? handle400And401Message({
  required BuildContext context,
  required NetworkException error,
  required Set<LocalizedDefinedException> exceptions,
}) {
  String? message;
  for (var exception in exceptions) {
    error.equalDo(exception, ifEqual: (error) {
      message = exception.getMessage(context).message;
    });
  }
  return message;
}
