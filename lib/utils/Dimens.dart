import 'package:flutter/material.dart';

class Dimens{
  //===========================geometri widget=================================================
  static double formHeight = 56;

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
    return MediaQuery.of(context).size.height *0.15;
  }

  static listHeightSmall(context){
    return MediaQuery.of(context).size.height *0.11;
  }

  static listHeightLarge(context){
    return MediaQuery.of(context).size.height *0.14;
  }

  static grafikHeight(context){
    return MediaQuery.of(context).size.height * 0.4;
  }
}