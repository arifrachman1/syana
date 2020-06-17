import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:syana/Controller/ShortcutController.dart';
import 'package:syana/models/UserModel.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/widgets/CustomShortcut.dart';

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

  static getCustomShortcutFAB(context, shortcuts) {
    return FabCircularMenu(
      fabColor: AppTheme.yellow,
      ringColor: AppTheme.yellow,
      children: <Widget>[
        CustomShortcut.getShortcut(CustomShortcut.SHORTCUT_TRACES, context),
        CustomShortcut.getShortcut(CustomShortcut.SHORTCUT_PROMO, context),
        CustomShortcut.getShortcut(CustomShortcut.SHORTCUT_BROADCAST, context),
        CustomShortcut.getShortcut(shortcuts != null || shortcuts.isNotEmpty ? shortcuts[0] : CustomShortcut.SHORTCUT_EMPTY, context),
        CustomShortcut.getShortcut(shortcuts != null || shortcuts.isNotEmpty ? shortcuts[1] : CustomShortcut.SHORTCUT_EMPTY, context),
        CustomShortcut.getShortcut(shortcuts != null || shortcuts.isNotEmpty ? shortcuts[2] : CustomShortcut.SHORTCUT_EMPTY, context),
      ],
    );
  }
}
