import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syana/screens/credentials/Login.dart';
import 'package:syana/screens/credentials/SplashScreen.dart';
//import 'package:syana/screens/product_rank/SyanaPackagingRank.dart';
//import 'package:syana/screens/product_rank/SyanaProductRank.dart';
import 'package:syana/screens/product_rank/SyanaSummary.dart';
import 'package:syana/screens/product_rank/SyanaSummaryDetail.dart';
import 'screens/home/SyanaHomeOwner.dart';
import 'package:syana/utils/AppTheme.dart';

void main() => runApp(MyApp());

//===========================================================================================

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        highlightColor: Colors.green
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
