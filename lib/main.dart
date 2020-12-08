import 'package:flutter/material.dart';
import 'package:syana/screens/Purchasing/CreateHistoryDetail.dart';
import 'package:syana/screens/Purchasing/CreatePurchasingDetail.dart';
import 'package:syana/screens/Purchasing/SyanaPlans.dart';
import 'package:syana/screens/credentials/SplashScreen.dart';

void main() => runApp(MyApp());

//===========================================================================================

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:
          ThemeData(primarySwatch: Colors.green, highlightColor: Colors.green),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
