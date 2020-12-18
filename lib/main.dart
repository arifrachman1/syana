import 'package:flutter/material.dart';
import 'package:syana/screens/credentials/SplashScreen.dart';
<<<<<<< HEAD
=======
import 'package:syana/screens/sdm/SyanaMenuSDM.dart';
>>>>>>> 4ad62525f24de6da6fa193d4b92482ac88b8f08a

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
