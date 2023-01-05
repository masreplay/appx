import 'package:appx/client/client.dart';
import 'package:flutter/foundation.dart';

/// Warning: this file shouldn't included in the final build

/// Function to notify developer each time he used fake data
/// Used with [JsonKey.defaultValue]
T provideWarning<T>(T value) {
  if (kDebugMode) {
    print(
        "Unimplemented value, this value could be earthier nullable and it shouldn't or not implemented yet! please request it from the backend developer");
  }

  print((StackTrace.current.toString().split("#")
    ..removeWhere((element) => element.isEmpty))[6]);
  return value;
}

int getDefaultUnimplementedInt() => provideWarning(0);
const JsonKey defaultUnimplementedInt =
    JsonKey(defaultValue: getDefaultUnimplementedInt);

List<dynamic> getDefaultUnimplementedList() =>
    provideWarning<List>(<dynamic>[]);
const JsonKey defaultUnimplementedList =
    JsonKey(defaultValue: getDefaultUnimplementedList);

String getDefaultUnimplementedString() => provideWarning("");
const JsonKey defaultUnimplementedString =
    JsonKey(defaultValue: getDefaultUnimplementedString);

double getDefaultUnimplementedDouble() => provideWarning(0.0);
const JsonKey defaultUnimplementedDouble =
    JsonKey(defaultValue: getDefaultUnimplementedDouble);

bool getDefaultUnimplementedBoolean() => provideWarning(false);
const JsonKey defaultUnimplementedBoolean =
    JsonKey(defaultValue: getDefaultUnimplementedBoolean);
