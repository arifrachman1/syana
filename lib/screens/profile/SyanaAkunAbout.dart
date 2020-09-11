import 'package:flutter/material.dart';
import 'package:syana/screens/profile/SyanaAkunAboutFAQ.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import 'package:syana/widgets/CustomBottomNav.dart';
import '../../main.dart';

class SyanaAkunAbout extends StatefulWidget {
  @override
  SyanaAkunAboutState createState() => SyanaAkunAboutState();
}

class SyanaAkunAboutState extends State<SyanaAkunAbout> {
  String aboutText =
      "Syana HQ merupakan aplikasi manajemen toko. Digunakan oleh star seller untuk mencatat transaksi yang terjadi di tiap toko, atau digunakan oeh owner untuk mengawasi transaksi yang terjadi di tiap toko.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: CustomBottomNav.getBottomNav(context, 4),
      body: Container(
        decoration: AppTheme.appBackground(),
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
                width: Dimens.buttonWidth(context),
                child: AspectRatio(
                  aspectRatio: Dimens.buttonRatio(),
                  child: RaisedButton(
                    color: AppTheme.yellow,
                    shape: AppTheme.roundButton(),
                    child: Text(
                      'FAQ',
                      style: TextStyle(
                        color: AppTheme.text_dark,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context){
                            return SyanaAkunAboutFAQ();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
