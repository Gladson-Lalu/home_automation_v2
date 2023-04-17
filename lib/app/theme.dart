import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    cardColor: lightContainerBG,
    primaryColor: lightPrimaryColor,
    focusColor: lightFocusColor,
    textTheme: TextTheme(
      labelMedium: GoogleFonts.oswald(color: lightContainerText),
      titleSmall: GoogleFonts.sourceSansPro(
        color: lightContainerText,
      ),
      titleLarge: GoogleFonts.roboto(
          color: lightTitleColor, fontWeight: FontWeight.w600),
      bodyLarge: const TextStyle(color: lightTextColor),
      bodyMedium: const TextStyle(color: lightTextColor),
    ),
    colorScheme: const ColorScheme.dark(secondary: lightSecondaryColor)
        .copyWith(background: lightScaffoldBG),
    timePickerTheme: const TimePickerThemeData(
      dialHandColor: lightPrimaryColor,
      dialBackgroundColor: lightContainerBG,
      entryModeIconColor: lightPrimaryColor,
      hourMinuteTextColor: lightPrimaryColor,
      dayPeriodTextColor: lightPrimaryColor,
      dayPeriodShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
  );

  //dark theme
  static final darkTheme = ThemeData(
    primaryColor: darkPrimaryColor,
    cardColor: darkContainerBG,
    focusColor: darkFocusColor,
    textTheme: TextTheme(
      labelMedium: GoogleFonts.oswald(color: darkContainerText),
      titleSmall: GoogleFonts.sourceSansPro(
        color: darkContainerText,
      ),
      titleLarge: GoogleFonts.roboto(
          color: darkTitleColor, fontWeight: FontWeight.w600),
      bodyLarge: const TextStyle(color: darkTextColor),
      bodyMedium: const TextStyle(color: darkTextColor),
    ),
    colorScheme: const ColorScheme.dark(secondary: darkSecondaryBG)
        .copyWith(background: darkScaffoldBG),
    timePickerTheme: TimePickerThemeData(
      dialHandColor: darkPrimaryColor,
      dialBackgroundColor: darkContainerBG,
      entryModeIconColor: darkPrimaryColor,
      hourMinuteTextColor: darkPrimaryColor,
      dayPeriodTextColor: darkPrimaryColor,
      dayPeriodShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
  );
}
