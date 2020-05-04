import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';

class CustomDialog {
  static Future getDialog(
      {@required String title,
        @required String message,
        @required BuildContext context,
        @required int popCount}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(
              message,
              style: TextStyle(color: AppTheme.text_dark),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Tutup"),
                onPressed: () {
                  for(int i = 0; i < popCount; i ++){
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
        });
  }
}