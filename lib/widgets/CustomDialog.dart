import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/GlobalVars.dart';

class CustomDialog {
  static Future getDialog(
      {@required String title,
      @required String message,
      @required BuildContext context,
      @required int popCount}) {
    return showDialog(
        context: context,
        barrierDismissible: false,
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
                  for (int i = 0; i < popCount; i++) {
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
        });
  }

  static Future getDialogWithVideo(
      {@required String title,
      @required String message,
      @required BuildContext context,
      @required int popCount,
      @required videoId}) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Column(
              children: <Widget>[
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: FlutterYoutube.playYoutubeVideoByUrl(
                      apiKey: GlobalVars.YOUTUBE_API_KEY,
                      videoUrl: "https://www.youtube.com/watch?v=Z5m_ALZTjAo",
                      autoPlay: true, //default falase
                      fullScreen: true, //default false
                    )),
                Text(
                  message,
                  style: TextStyle(color: AppTheme.text_dark),
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Tutup"),
                onPressed: () {
                  for (int i = 0; i < popCount; i++) {
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
        });
  }
}
