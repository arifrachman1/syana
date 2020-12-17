import 'package:flutter/material.dart';
import 'package:syana/screens/credentials/SplashScreen.dart';
import 'package:syana/screens/produksi/SyanaTambahProduksi.dart';

void main() => runApp(MyApp());

//===========================================================================================

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:
          ThemeData(primarySwatch: Colors.green, highlightColor: Colors.green),
      home: SyanaTambahProduksi(),
      debugShowCheckedModeBanner: false,
    );
  }
}
