class Validation {
  const Validation._();

  static const int passwordMinLength = 8;
  static const int passwordMaxLength = 16;

  static const int minLength = 16;

  static const int fullNameMinLength = 3;
  static const int fullNameMaxLength = 100;

  static const int aboutMeMinLength = 3;
  static const int aboutMeMaxLength = 100;

  static final DateTime minimumAge = DateTime(DateTime.now().year - 16);
  static final DateTime maximumAge = DateTime(DateTime.now().year - 100);
}
