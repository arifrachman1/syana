import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';
import 'main.dart';

class SyanaAbout extends StatefulWidget {
  @override
  SyanaAboutState createState() => SyanaAboutState();
}

class SyanaAboutState extends State<SyanaAbout> {
  String aboutText = "Tentang Syana";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomLeft,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Text(
                'About Syana',
                style: TextStyle(
                  color: AppTheme.text_light,
                  fontSize: 25,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 25),
              alignment: Alignment.centerLeft,
              child: Text(
                aboutText,
                style: TextStyle(
                  color: AppTheme.text_light,
                ),
              ),
            ),
            Container(
              width: buttonWidth(context),
              child: AspectRatio(
                aspectRatio: buttonRatio(),
                child: RaisedButton(
                  color: AppTheme.yellow,
                  shape: roundButton(),
                  child: Text(
                    'FAQ',
                    style: TextStyle(
                      color: AppTheme.text_dark,
                    ),
                  ),
                  onPressed: (){},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
