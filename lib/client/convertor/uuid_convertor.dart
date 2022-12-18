import 'package:appx/client/client.dart';

class NullableUUIDStringConvertor implements JsonConverter<UUID?, String?> {
  const NullableUUIDStringConvertor();

  static const String nullData = "00000000-0000-0000-0000-000000000000";
  
  @override
  UUID? fromJson(String? json) {
    return json == null || json == nullData ? null : json;
  }

  @override
  String? toJson(UUID? object) {
    return object == nullData ? null : object;
  }
}
