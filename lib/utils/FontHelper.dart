import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';

class FontHelper {
  static TextStyle textLogoTitle = TextStyle(
      color: AppTheme.text_dark, fontSize: 28, fontWeight: FontWeight.w500);

  static TextStyle textTitle =
      TextStyle(fontSize: 24, fontWeight: FontWeight.w300);
  static TextStyle textSubtitle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  static TextStyle textTitleLight = TextStyle(
      color: AppTheme.text_light, fontSize: 16, fontWeight: FontWeight.w300);
  static TextStyle textSubtitleLight = TextStyle(
      color: AppTheme.text_light, fontSize: 14, fontWeight: FontWeight.w300);

  static TextStyle textListTitle;
  static TextStyle textListSubtitle;

  static TextStyle body = TextStyle(color: AppTheme.text_light);
  static TextStyle bodyLight;
  static TextStyle bodyBold =
      TextStyle(color: AppTheme.text_dark, fontWeight: FontWeight.w400);
}
