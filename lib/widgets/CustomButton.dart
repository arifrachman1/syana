import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';

class CustomButton {
  static Widget getCustomButton(
      {@required context,
      buttonText,
      width,
      height,
      buttonType,
      @required callbackFunction}) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Container(
        width: Dimens.buttonWidthWide(context),
        child: AspectRatio(
          aspectRatio: Dimens.buttonRatioWide(),
          child: RaisedButton(
              child: Text(
                buttonText ?? "Button",
                style: TextStyle(
                  color: AppTheme.text_light,
                ),
              ),
              shape: AppTheme.roundButton(),
              color: AppTheme.btn_success,
              onPressed: () {
                callbackFunction();
              }),
        ),
      ),
    );
  }
}
