import 'package:flutter/material.dart';
import 'package:helpu/src/utils/theme/widget_themes/text_theme.dart';

class TAppBarTheme {
  TAppBarTheme._();

  static AppBarTheme lightAppBarTheme = AppBarTheme(
    iconTheme: const IconThemeData(color: Colors.black),
    titleTextStyle: TTextTheme.lightTextTheme.headlineMedium,
    backgroundColor: Colors.transparent,
    centerTitle: true,
    elevation: 0,
  );
  static AppBarTheme darkAppBarTheme = AppBarTheme(
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: TTextTheme.lightTextTheme.headlineMedium,
    backgroundColor: Colors.transparent,
    centerTitle: true,
    elevation: 0,
  );
}