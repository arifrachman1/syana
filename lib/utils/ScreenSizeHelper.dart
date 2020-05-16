import 'package:flutter/material.dart';

class ScreenSizeHelper{

  static final int HIEGHT_FULL = 1;
  static final int HEIGHT_WITH_STATUS_BAR = 2;
  static final int HEIGHT_WITH_ACTION_BAR = 3;
  static final int HEIGHT_WITH_STATUS_AND_ACTION_BAR = 4;

  static double getDisplayWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  static double getDisplayHeight({BuildContext context, int which}){
    double adjustedHeight = 0;
    switch(which){
      case 1:
        adjustedHeight = MediaQuery.of(context).size.height;
        break;
      case 2:
        adjustedHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
        break;
      case 3:
        adjustedHeight = MediaQuery.of(context).size.height - kToolbarHeight;
        break;
      case 4:
        adjustedHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight;
        break;
    }
    return  adjustedHeight;
  }

  static double getAdjustedDisplayHeight(BuildContext context, int which){

  }
}