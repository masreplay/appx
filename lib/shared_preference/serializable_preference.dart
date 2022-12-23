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
///  Authentication _fromJson(JsonMap json) => Authentication.fromJson(json);
///
///  @override
///  JsonMap _toJson(Authentication value) => value.toJson();
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
  JsonMap _toJson(T value);

  @protected
  T _fromJson(JsonMap json);

  /// Read data from [sharedPreference] by it's [key] and then [json.decode]
  /// and [_fromJson] it
  @mustCallSuper
  @override
  T? maybeData() {
    final value = sharedPreference.get(key);
    try {
      return value == null ? null : _fromJson(json.decode(value as String));
    } catch (e) {
      return null;
    }
  }

  /// Starting by [_toJson] then [json.encode] object and
  /// Set it in the [sharedPreference] by it's [key]
  @mustCallSuper
  @override
  Future<void> setData(T value) async {
    final JsonMap newValue = _toJson(value);
    final data = json.encode(newValue);
    await sharedPreference.setString(key, data);
  }

  @override
  Future<void> clearData() async {
    await sharedPreference.remove(key);
  }
}
