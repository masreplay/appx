import 'package:appx/shared_preference/share_preference.dart';

class BoolPreference extends ObjectSharedPreference<bool> {
  const BoolPreference(super.sharedPreference, {required super.key});

  @override
  bool? maybeData() {
    return sharedPreference.getBool(key);
  }

  @override
  Future<void> setData(bool value) async {
    await sharedPreference.setBool(key, value);
  }
}
