import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';
import 'main.dart';

class SyanaTrip extends StatefulWidget {
  @override
  SyanaTripState createState() => SyanaTripState();
}

class SyanaTripState extends State<SyanaTrip> {
  List tripTerbaru = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10,),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: Text(
                'Syana Trip',
                style: TextStyle(
                  color: AppTheme.text_light,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.width * 0.04,
            ),
            Stack(
              overflow: Overflow.clip,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 16 / 10,
                        child: Container(
                          decoration: listBackground(),
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Image(image: AssetImage('images/papuma.jpg'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppTheme.yellow,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black45,
                              blurRadius: 5,
                              offset: Offset(-2, 2)),
                        ],
                      ),
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        'Terbaru',
                        style: TextStyle(
                          color: AppTheme.text_dark,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 16 / 10,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Jangan Lupa Bahagia !! (^_^)',
                            style: TextStyle(
                              color: AppTheme.white,
                              shadows: [shadowText()],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.width * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: listBackground(),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image(image: AssetImage('images/papuma.jpg'),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: listBackground(),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image(image: AssetImage('images/papuma.jpg'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.width * 0.03,
            ),
            Stack(
              overflow: Overflow.clip,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 16 / 10,
                        child: Container(
                          decoration: listBackground(),
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Image(image: AssetImage('images/papuma.jpg'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppTheme.orange,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black45,
                              blurRadius: 5,
                              offset: Offset(-2, 2)),
                        ],
                      ),
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        'Favorite',
                        style: TextStyle(
                          color: AppTheme.text_light,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 16 / 10,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Jangan Lupa Bahagia !! (^_^)',
                            style: TextStyle(
                              color: AppTheme.white,
                              shadows: [shadowText()],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.width * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: listBackground(),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Icon(
                          Icons.image,
                          color: AppTheme.teal_light,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: listBackground(),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Icon(
                          Icons.image,
                          color: AppTheme.teal_light,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.width * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
