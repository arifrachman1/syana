import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';
import '../../main.dart';

class SyanaAkunMyPoints extends StatefulWidget {
  SyanaAkunMyPointsState createState() => SyanaAkunMyPointsState();
}

class SyanaAkunMyPointsState extends State<SyanaAkunMyPoints> {
  List<List> point = [
    [0, 0],
    [6, 22],
  ];

  getPoint(index, index2) {
    var selectedPoint = point[index];
    return selectedPoint[index2];
  }

  tableBorder() {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: AppTheme.yellow,
          width: 2,
        ),
      ),
    );
  }

  rowHeight(context){
    return MediaQuery.of(context).size.height *0.05;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10,),
      child: Column(
        children: <Widget>[
          Container(
            height: rowHeight(context),
            decoration: tableBorder(),
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 50,
                  fit: FlexFit.tight,
                  child:
                  Text(''),
                ),
                Flexible(
                  flex: 25,
                  fit: FlexFit.tight,
                  child:
                  Text('Poin', style: TextStyle(color: AppTheme.text_light,),),
                ),
                Flexible(
                  flex: 25,
                  fit: FlexFit.tight,
                  child:
                  Text('Paket', style: TextStyle(color: AppTheme.text_light,),),
                ),
              ],
            ),
          ),
          Container(
            height: rowHeight(context),
            decoration: tableBorder(),
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 50,
                  fit: FlexFit.tight,
                  child:
                  Text('Bulan ini', style: TextStyle(color: AppTheme.text_light,),),
                ),
                Flexible(
                  flex: 25,
                  fit: FlexFit.tight,
                  child:
                  Text(getPoint(0, 0).toString(), style: TextStyle(color: AppTheme.text_light,),),
                ),
                Flexible(
                  flex: 25,
                  fit: FlexFit.tight,
                  child:
                  Text(getPoint(0, 1).toString(), style: TextStyle(color: AppTheme.text_light,),),
                ),
              ],
            ),
          ),
          Container(
            height: rowHeight(context),
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 50,
                  fit: FlexFit.tight,
                  child:
                  Text('3 Bulan yang lalu', style: TextStyle(color: AppTheme.text_light,),),
                ),
                Flexible(
                  flex: 25,
                  fit: FlexFit.tight,
                  child:
                  Text(getPoint(1, 0).toString(), style: TextStyle(color: AppTheme.text_light,),),
                ),
                Flexible(
                  flex: 25,
                  fit: FlexFit.tight,
                  child:
                  Text(getPoint(1, 1).toString(), style: TextStyle(color: AppTheme.text_light,),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
