import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/ScreenSizeHelper.dart';

class CustomTextInput {
  static Widget getCustomTextField(
      {@required context,
      @required controller,
      widthFactor,
      heightFactor,
      hint,
      textInputType,
      isPasswordField,
      key}) {
    return Container(
      width: ScreenSizeHelper.getDisplayWidth(context) * (widthFactor ?? 1),
      height: 56,
      margin: EdgeInsets.only(top: 25),
      decoration: AppTheme.inputDecoration(),
      child: TextField(
        key: key ?? null,
        controller: controller,
        keyboardType: textInputType ?? TextInputType.text,
        obscureText: isPasswordField ?? false,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10.0),
            border: InputBorder.none,
            hintText: hint ?? "Text"),
      ),
    );
  }
}
