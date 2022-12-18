extension NullableUriExtension on Uri? {
  String toStringOrEmpty() => this?.toString() ?? "";
}
