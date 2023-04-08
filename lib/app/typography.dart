import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Map<String, Color> _colorMap = {
  "black": Colors.black,
  "white": Colors.white,
  "red": Colors.red,
  "green": Colors.green,
  "blue": Colors.blue,
};

const Map<String, FontWeight> _fontWeightMap = {
  "100": FontWeight.w100,
  "200": FontWeight.w200,
  "300": FontWeight.w300,
  "400": FontWeight.w400,
  "500": FontWeight.w500,
  "600": FontWeight.w600,
  "700": FontWeight.w700,
  "800": FontWeight.w800,
  "900": FontWeight.w900,
};

final Map<String, TextStyle> _storedFontStyle = {};

TextStyle fontStyle(String style) {
  if (_storedFontStyle.containsKey(style)) {
    return _storedFontStyle[style]!;
  }
  final List<String> styleList = style.split(":");
  final Color color = _colorMap[styleList[0]]!;
  final FontWeight fontWeight = _fontWeightMap[styleList[1]]!;
  final double fontSize = double.parse(styleList[2]);
  final TextStyle textStyle = GoogleFonts.notoSerif(
      textStyle:
          TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight));
  _storedFontStyle[style] = textStyle;
  return textStyle;
}
