import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:photo_view/photo_view.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/GlobalVars.dart';
import 'package:syana/utils/ScreenSizeHelper.dart';

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
                    child: FlutterYoutube.playYoutubeVideoById(
                      apiKey: GlobalVars.YOUTUBE_API_KEY,
                      videoId: videoId,
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

  static Future getDialogWithPicture(
      String title, String image_url, BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(64.0)),
              ),
              child: SizedBox(
                width: ScreenSizeHelper.getDisplayWidth(context) * 1.0,
                height: ScreenSizeHelper.getDisplayHeight(
                        context: context, which: ScreenSizeHelper.HIEGHT_FULL) *
                    0.6,
                child: ClipRect(
                  clipBehavior: Clip.antiAlias,
                  child: PhotoView(
                    tightMode: true,
                    minScale: 0.4,
                    maxScale: 1.0,
                    initialScale: 0.4,
                    backgroundDecoration:
                        BoxDecoration(color: Colors.transparent),
                    imageProvider: NetworkImage(image_url),
                    loadingBuilder: (BuildContext context,
                        ImageChunkEvent loadingProgress) {
                      /*if (loadingProgress == null) {
                              return child;
                            }*/
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        });
  }
}
