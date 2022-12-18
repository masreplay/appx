extension NullableStringExtension on String? {
  bool get isEmptyOrNull => this?.isEmpty ?? true;
}

extension StringExtension on String {
  Uri? toUriOrNull() => isEmpty ? null : Uri.parse(this);

  Uri toUri() => Uri.parse(this);
}
