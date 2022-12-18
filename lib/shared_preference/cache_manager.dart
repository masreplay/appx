import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// used with [SharedPreferences] and [Collection] to save data locally
abstract class CacheManager<T> {
  const CacheManager();

  T? maybeData();

  Future<void> setData(T value);

  Future<void> clearData();
}

// current page == 1 delete old
// TODO(masreplay): implement this
class CachePaginated<T> extends CacheManager<T> {
  const CachePaginated();

  @override
  T? maybeData() {
    return null;
  }

  @override
  Future<void> setData(T value) async {}

  @override
  Future<void> clearData() async {}
}
