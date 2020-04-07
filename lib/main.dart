import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'SyanaHome.dart';
import 'package:syana/utils/AppTheme.dart';

void main() => runApp(MyApp());

//background aplikasi
appBackground() {
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
listBackground() {
  return BoxDecoration(
    color: AppTheme.teal,
    borderRadius: BorderRadius.circular(12),
  );
}

//style input
inputDecoration() {
  return BoxDecoration(
    color: AppTheme.white,
    border: Border.all(
      color: AppTheme.white,
    ),
    borderRadius: BorderRadius.circular(12),
  );
}

//style textField
textFieldDecoration(hint) {
  return InputDecoration(
    contentPadding: EdgeInsets.only(left: 10.0),
    border: InputBorder.none,
    hintText: hint,
  );
}

//style tab bar
tabbarDecoration() {
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
inputDecorationShadow() {
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
dateDecorationShadow() {
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

roundDecorationShadow() {
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
decorationShadow() {
  return BoxDecoration(
    boxShadow: [
      BoxShadow(color: Colors.black45, blurRadius: 5, offset: Offset(1, 2)),
    ],
  );
}

//shadow untuk text
shadowText() {
  return Shadow(
    color: Colors.black45,
    blurRadius: 5,
    offset: Offset(1, 2),
  );
}

//style round button
roundButton() {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(7),
  );
}


//===========================geometri widget=================================================

buttonRatio(){
  return 7/2;
}

buttonRatioWide(){
  return 11/3;
}

buttonWidth(context){
  return MediaQuery.of(context).size.width *0.36;
}

buttonWidthWide(context){
  return MediaQuery.of(context).size.width *0.39;
}

listHeight(context){
  return MediaQuery.of(context).size.height *0.13;
}

listHeightSmall(context){
  return MediaQuery.of(context).size.height *0.11;
}

listHeightLarge(context){
  return MediaQuery.of(context).size.height *0.14;
}

grafikHeight(context){
  return MediaQuery.of(context).size.height * 0.4;
}

//===========================================================================================

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Home(),
    );
  }
}
