import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';

class FontHelper {
  static TextStyle textLogoTitle = TextStyle(
          color: AppTheme.text_dark, fontSize: 64, fontWeight: FontWeight.w500);

  static TextStyle textLogoTitleLight = TextStyle(
          color: AppTheme.text_light, fontSize: 64, fontWeight: FontWeight.w500);

  static TextStyle textTitle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w300, color: AppTheme.text_light);
  static TextStyle textSubtitle = TextStyle(
      fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.text_light);

  static TextStyle textTitleLight = TextStyle(
      color: AppTheme.text_light, fontSize: 10, fontWeight: FontWeight.w300);
  static TextStyle textSubtitleLight = TextStyle(
      color: AppTheme.text_light, fontSize: 8, fontWeight: FontWeight.w300);

  static TextStyle textListTitle = TextStyle(
          color: AppTheme.text_light,
          fontSize: 15,
          fontWeight: FontWeight.bold
  );
  static TextStyle textListSubtitle = TextStyle(
    color: AppTheme.text_light,
    fontSize: 13,
    fontStyle: FontStyle.italic,
  );

  static TextStyle body = TextStyle(color: AppTheme.text_light);
  static TextStyle bodyLight;
  static TextStyle bodyBold =
      TextStyle(color: AppTheme.text_light, fontWeight: FontWeight.w400);
}
