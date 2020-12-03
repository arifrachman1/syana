import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:syana/utils/GlobalVars.dart';

class SyanaTripsVideo extends StatefulWidget {
  TripsVideoState createState() => TripsVideoState();
}

class TripsVideoState extends State<SyanaTripsVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

        body: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: FlutterYoutube.playYoutubeVideoById(
              apiKey: GlobalVars.YOUTUBE_API_KEY,
              videoId: "Z5m_ALZTjAo",
              autoPlay: false, //default falase
              fullScreen: false, //default false
            )));
  }
}
