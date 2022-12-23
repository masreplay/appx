import 'dart:convert';

import 'package:appx/client/client.dart';
import 'package:appx/shared_preference/share_preference.dart';
import 'package:appx/types/json_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// json serializable shared preference
///
/// Example:
/// class AuthenticationPreference extends SerializablePreference<Authentication> {
///  const AuthenticationPreference(super.sharedPreference)
///      : super(key: "AuthenticationKey");
///
///  @override
///  Authentication fromJson(JsonMap json) => Authentication.fromJson(json);
///
///  @override
///  JsonMap toJson(Authentication value) => value.toJson();
/// }
abstract class SerializablePreference<T> implements ObjectSharedPreference<T> {
  @override
  final String key;

  @override
  @protected
  final SharedPreferences sharedPreference;

  const SerializablePreference(
    this.sharedPreference, {
    required this.key,
  });

  @protected
  JsonMap toJson(T value);

  @protected
  T fromJson(JsonMap json);

  /// Read data from [sharedPreference] by it's [key] and then [json.decode]
  /// and [fromJson] it
  @mustCallSuper
  @override
  T? maybeData() {
    final value = sharedPreference.getString(key);
    try {
      return value == null ? null : fromJson(json.decode(value));
    } catch (e) {
      return null;
    }
  }

  /// Starting by [toJson] then [json.encode] object and
  /// Set it in the [sharedPreference] by it's [key]
  @mustCallSuper
  @override
  Future<void> setData(T value) async {
    final JsonMap newValue = toJson(value);
    final data = json.encode(newValue);
    await sharedPreference.setString(key, data);
  }

  @override
  Future<void> clearData() async {
    await sharedPreference.remove(key);
  }
}
