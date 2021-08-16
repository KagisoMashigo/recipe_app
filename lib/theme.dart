// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// Aerial Color THEME
class AerialColor {
  const AerialColor();

  static const Color primary = const Color(0xFF4E37B2);
  static const Color primaryVariant = const Color(0xFF1C1246);
  static const Color secondary = const Color(0xFFA79BD8);
  static const Color secondaryVariant = const Color(0xFFF5F4FF);
  static const Color background = const Color(0xFF49416B);
  static const Color backgroundVariant = const Color(0x26A79BD8);
  static const Color success = const Color(0xFF06D8B2);
  static const Color warning = const Color(0xFFFF7750);
  static const Color error = const Color(0xFFED4337);
}

/// Color Scheme allows reuse of various canned widgets using the common colors
/// from Aerial POM App. ColorScheme is a fairly new widget that simplifies the
/// theming
final _aerialColorScheme = ColorScheme(
  primary: AerialColor.primary,
  primaryVariant: AerialColor.primaryVariant,
  secondary: AerialColor.secondary,
  secondaryVariant: AerialColor.secondaryVariant,
  surface: Colors.white,
  background: AerialColor.background,
  error: AerialColor.error,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onSurface: Colors.grey,
  onBackground: AerialColor.backgroundVariant,
  onError: AerialColor.warning,
  brightness: Brightness.light,
);

ThemeData aerialThemeMaterial() => ThemeData(
      fontFamily: 'Lato',
      typography: _aerialTypography,
      textTheme: _aerialTextTheme,
      colorScheme: _aerialColorScheme,
      primaryColor: AerialColor.primary,
      primaryColorDark: AerialColor.primaryVariant,
      primaryColorLight: AerialColor.secondary,
      primaryColorBrightness: Brightness.dark,
      /* accentColor was primaryVariant, only used on default progress indicator */
      accentColor: AerialColor.primary,
      accentColorBrightness: Brightness.dark,
      backgroundColor: AerialColor.backgroundVariant,
      buttonTheme: _aerialButtonTheme,
      errorColor: AerialColor.error,
      iconTheme: _aerialIconTheme,
      primaryIconTheme: _aerialIconTheme,
      accentIconTheme: _aerialIconTheme,
      timePickerTheme: _aerialTimePickerTheme,
      floatingActionButtonTheme: _aerialFabTheme,
      hintColor: AerialColor.success,
      dialogTheme: _aerialDialogTheme,
      cardTheme: _aerialCardTheme,
      snackBarTheme: _aerialSnackBar,
      outlinedButtonTheme: _aerialOutlinedButton,
      elevatedButtonTheme: _aerialElevatedButton,
      brightness: Brightness.light,
    );

Typography _aerialTypography = Typography.material2018(
  black: Typography.blackMountainView,
  white: Typography.whiteMountainView,
);

FloatingActionButtonThemeData _aerialFabTheme = FloatingActionButtonThemeData(
  backgroundColor: AerialColor.primary,
  foregroundColor: Colors.white,
);

ButtonThemeData _aerialButtonTheme = ButtonThemeData(
  buttonColor: AerialColor.primary,
  disabledColor: Colors.grey,
  textTheme: ButtonTextTheme.primary,
);

IconThemeData _aerialIconTheme = IconThemeData(
  color: AerialColor.primary,
);

CardTheme _aerialCardTheme = CardTheme(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    shadowColor: AerialColor.primaryVariant);

/// The theme used in all dialogs throughout the application
DialogTheme _aerialDialogTheme = DialogTheme(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  backgroundColor: Colors.white,
  titleTextStyle: _aerialTextTheme.headline5,
  contentTextStyle: _aerialTextTheme.bodyText1,
);

SnackBarThemeData _aerialSnackBar = SnackBarThemeData(
  backgroundColor: _aerialColorScheme.primaryVariant,
  disabledActionTextColor: _aerialColorScheme.secondaryVariant,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(0),
      bottomRight: Radius.circular(0),
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
    ),
  ),
  // behavior: SnackBarBehavior.floating,
);

TimePickerThemeData _aerialTimePickerTheme = TimePickerThemeData(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  hourMinuteTextColor: const _AerialStateColorDark(),
  hourMinuteColor: const _AerialStateColor(),
  dialTextColor: const _AerialStateColorDark(),
  dialHandColor: AerialColor.primary.withAlpha(75),
  entryModeIconColor: AerialColor.primary,
);

OutlinedButtonThemeData _aerialOutlinedButton = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    backgroundColor: Colors.white,
    primary: AerialColor.primary,
    onSurface: AerialColor.secondary,
    side: BorderSide(
      color: AerialColor.secondary,
      width: 0.5,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);

ElevatedButtonThemeData _aerialElevatedButton = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    onSurface: AerialColor.background,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    elevation: 2,
  ),
);

TextTheme _aerialTextTheme = TextTheme()
    .apply(
      bodyColor: Colors.black,
    )
    .copyWith(
      button: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );

class _AerialStateColor extends MaterialStateColor {
  static const int _defaultColor = 0xFFA79BD8;
  static const int _pressedColor = 0xFF1C1246;

  const _AerialStateColor() : super(_defaultColor);

  @override
  Color resolve(Set<MaterialState> states) => _resolveColorByState(
        {
          'pressed': _pressedColor,
          'default': _defaultColor,
        },
        states,
      );
}

class _AerialStateColorDark extends MaterialStateColor {
  static const int _defaultColor = 0xFF49416B;
  static const int _pressedColor = 0xFF342C53;

  const _AerialStateColorDark() : super(_defaultColor);

  @override
  Color resolve(Set<MaterialState> states) => _resolveColorByState(
        {
          'pressed': _pressedColor,
          'default': _defaultColor,
        },
        states,
      );
}

Color _resolveColorByState(
    Map<String, int> palette, Set<MaterialState> states) {
  if (states.contains(MaterialState.pressed)) {
    return Color(palette['pressed']);
  } else {
    return Color(palette['default']);
  }
}
