import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';
import '../../main.dart';

class SyanaAkunProfil extends StatefulWidget {
  @override
  SyanaAkunProfilState createState() => SyanaAkunProfilState();
}

class SyanaAkunProfilState extends State<SyanaAkunProfil> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.bottomRight,
            height: MediaQuery.of(context).size.height * 0.06,
            child: Icon(
              Icons.lock_outline,
              size: 35,
              color: AppTheme.white,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Hi, Developer',
                    style: TextStyle(
                      color: AppTheme.text_light,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Anda bergabung pada Agustus 2019',
                    style: TextStyle(
                      color: AppTheme.text_light,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  child: Text(
                    'Anda telah bekerja selama 0 Tahun 8 Bulan',
                    style: TextStyle(
                      color: AppTheme.text_light,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Semangat ya! ',
                  style: TextStyle(
                    color: AppTheme.white,
                    fontSize: 17,
                  ),
                ),
                Icon(
                  Icons.favorite,
                  color: AppTheme.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
