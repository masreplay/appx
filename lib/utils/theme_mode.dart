import 'package:flutter/material.dart';

final List<ThemeMode> allowedThemes = [ThemeMode.light, ThemeMode.dark];

extension ThemeModeExtension on BuildContext {
  /// Return [ThemeMode.light] or [ThemeMode.dark]
  /// If current ThemeMode is [ThemeMode.system]
  ThemeMode get systemThemeMode {
    try {
      return MediaQuery.of(this).platformBrightness.toThemeMode;
    } catch (e) {
      return ThemeMode.light;
    }
  }
}

extension ThemeModeEnumExtension on ThemeMode {
  bool get isDark => this == ThemeMode.dark;
  bool get isLight => this == ThemeMode.light;
  bool get isSystem => this == ThemeMode.system;

  /// Return [IconData] associated with current [ThemeMode]
  IconData getIcon(BuildContext context) {
    switch (this) {
      case ThemeMode.dark:
        return Icons.dark_mode_rounded;
      case ThemeMode.light:
        return Icons.light_mode_rounded;
      case ThemeMode.system:
        return context.systemThemeMode.getIcon(context);
    }
  }
}

extension BrightnessExtension on Brightness {
  bool get isDark => this == Brightness.dark;
  bool get isLight => this == Brightness.light;

  ThemeMode get toThemeMode {
    switch (this) {
      case Brightness.dark:
        return ThemeMode.dark;
      case Brightness.light:
        return ThemeMode.light;
    }
  }
}
