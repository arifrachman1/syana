import 'package:flutter/material.dart';

class Dimens{
  //===========================geometri widget=================================================
  static double formHeight = 56;

  static double fontXtraSmall = 6;
  static double fontSmall = 10;
  static double fontMedium = 12;
  static double fontLarge = 18;
  static double fontXtraLarge = 22;

  static double margin_xs = 8;
  static double margin_s = 16;
  static double margin_m = 32;
  static double margin_l = 64;
  static double margin_xl = 72;

  static buttonRatio(){
    return 7/2;
  }

  static buttonRatioWide(){
    return 11/3;
  }

  static buttonWidth(context){
    return MediaQuery.of(context).size.width *0.36;
  }

  static buttonWidthWide(context){
    return MediaQuery.of(context).size.width *0.39;
  }

  static listHeight(context){
    return MediaQuery.of(context).size.height *0.20;
  }

  static listHeightSmall(context){
    return MediaQuery.of(context).size.height *0.15;
  }

  static listHeightLarge(context){
    return MediaQuery.of(context).size.height *0.25;
  }

  static grafikHeight(context){
    return MediaQuery.of(context).size.height * 0.4;
  }
}