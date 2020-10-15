import 'package:flutter/material.dart';

//theme===============================================
class AppTheme{
  static var teal_light = Colors.teal[200];
  static var teal = Colors.teal;
  static var teal_dark = Colors.teal[700];

  static var btn_success = Colors.green[300];
  static var btn_default = Colors.grey[200];

  static var text_light = Colors.white;
  static var text_dark = Colors.black45;
  static var text_darker = Colors.black;

  static var yellow = Colors.yellow[300];
  static var white = Colors.white;
  static var red = Colors.red;
  static var orange = Colors.orange;
  static var green = Colors.green;

  static var orange_light = Colors.orange[200];



  //background aplikasi
  static appBackground() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.lightGreen[200],
          AppTheme.teal[200],
        ],
      ),
    );
  }

//style list
  static listBackground() {
    return BoxDecoration(
      color: AppTheme.teal,
      borderRadius: BorderRadius.circular(12),
    );
  }

	static popupRoundedBackground() {
		return RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25.0)));
	}

//style input
  static inputDecoration() {
    return BoxDecoration(
      color: AppTheme.white,
      border: Border.all(
        color: AppTheme.white,
      ),
      borderRadius: BorderRadius.circular(12),
    );
  }

//style textField
  static textFieldDecoration(hint) {
    return InputDecoration(
      contentPadding: EdgeInsets.only(left: 10.0),
      border: InputBorder.none,
      hintText: hint,
    );
  }

//style tab bar
  static tabbarDecoration() {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
    );
  }

//style input dengan shadow
  static inputDecorationShadow() {
    return BoxDecoration(
      color: AppTheme.white,
      border: Border.all(
        color: AppTheme.white,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 5,
          offset: Offset(1, 2),
        ),
      ],
    );
  }

//style input dengan shadow
  static dateDecorationShadow() {
    return BoxDecoration(
      color: Colors.blueGrey[900],
      border: Border.all(
        color: Colors.blueGrey[900],
      ),
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 5,
          offset: Offset(1, 2),
        ),
      ],
    );
  }

  static roundDecorationShadow() {
    return BoxDecoration(
      color: AppTheme.white,
      border: Border.all(
        color: AppTheme.white,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 5,
          offset: Offset(1, 2),
        ),
      ],
    );
  }

//style shadow saja
  static decorationShadow() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(color: Colors.black45, blurRadius: 5, offset: Offset(1, 2)),
      ],
    );
  }

//shadow untuk text
  static shadowText() {
    return Shadow(
      color: Colors.black45,
      blurRadius: 5,
      offset: Offset(1, 2),
    );
  }

//style round button
  static roundButton() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(7),
    );
  }


}