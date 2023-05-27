import 'package:flutter/material.dart';

import 'color_extension.dart';
import 'constants.dart';

class AppThemes {
  // Description: To apply light theme.
  static final light = ThemeData.light().copyWith(
    highlightColor: disabledColor,
    disabledColor: disabledColor,
    splashColor: disabledColor,
    textSelectionTheme: const TextSelectionThemeData(
      selectionHandleColor: Colors.transparent,
    ),
    scaffoldBackgroundColor: lightBackground,
    primaryColor: lightPrimaryColor,
    backgroundColor: lightBackground,
    focusColor: lightPrimaryColor.withAlpha(Constants.lightAlfa),
    cardColor: lightBackground.withAlpha(Constants.mediumAlfa),
    colorScheme: const ColorScheme(
      primary: lightPrimaryColor,
      secondary: lightSecondary,
      surface: lightSurface,
      tertiary: lightTertiary,
      onTertiary: lightOnTertiary,
      background: lightBackground,
      error: lightError,
      onPrimary: lightOnPrimary,
      onSecondary: lightOnSecondary,
      onSurface: lightOnBackground,
      onBackground: lightOnBackground,
      onError: lightOnError,
      brightness: Brightness.light,
    ),);

  // Description: To apply dark theme.
  static final dark = ThemeData.dark().copyWith(
    highlightColor: disabledColor,
    disabledColor: disabledColor,
    splashColor: disabledColor,
    textSelectionTheme: const TextSelectionThemeData(
      selectionHandleColor: Colors.transparent,
    ),
    scaffoldBackgroundColor: darkBackground,
    primaryColor: darkPrimaryColor,
    backgroundColor: darkBackground,
    focusColor: darkTertiary.withAlpha(Constants.lightAlfa),
    cardColor: darkBackground.withAlpha(Constants.mediumAlfa),
    colorScheme: const ColorScheme(
      primary: darkPrimaryColor,
      secondary: darkSecondary,
      surface: darkSurface,
      tertiary: darkTertiary,
      onTertiary: darkOnTertiary,
      background: darkBackground,
      error: darkError,
      onPrimary: darkOnPrimary,
      onSecondary: darkOnSecondary,
      onSurface: darkOnBackground,
      onBackground: darkOnBackground,
      onError: darkOnError,
      brightness: Brightness.dark,
    ),);
}
