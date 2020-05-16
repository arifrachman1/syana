import 'package:flutter/material.dart';
import 'package:syana/screens/promo/SyanaTambahpromobaru.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import '../../main.dart';

class Promo extends StatefulWidget {
  @override
  PromoState createState() => PromoState();
}

class PromoState extends State<Promo> {
  List<List> promo = [
    ['teslft1', 'Lifetime', '-'],
    ['teslft2', 'Lifetime', '-'],
    ['teslft3', 'Lifetime', '-'],
    ['teslft4', 'Lifetime', '-'],
    ['teslft5', 'Lifetime', '-'],
    ['teslft6', 'Lifetime', '-'],
    ['teslft7', 'Lifetime', '-'],
    ['teslft8', 'Lifetime', '-'],
    ['teslft9', 'Lifetime', '-'],
  ];

  getPromo(index, index2) {
    var selectedPromo = promo[index];
    return selectedPromo[index2];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[200],
        title: Text('Promo'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.remove_red_eye,
              ),
              color: Colors.black,
              onPressed: () {}),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: AppTheme.appBackground(),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: promo.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.only(left: 10, top: 20, bottom: 20),
                    decoration: AppTheme.listBackground(),
                    height: Dimens.listHeightLarge(context),
                    margin: EdgeInsets.only(top: 7, bottom: 7),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 85, 
                          child: 
                          Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                getPromo(index, 0),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppTheme.text_light,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                getPromo(index, 1),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.text_light,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                getPromo(index, 2),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.text_light,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ),
                        Flexible(
                          flex: 15,
                          child: 
                          Container(
                          alignment: Alignment.center,
                          child: PopupMenuButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: AppTheme.white,
                            ),
                            itemBuilder: (BuildContext context) => [
                              PopupMenuItem(
                                child: Text('opsi 1'),
                              ),
                              PopupMenuItem(
                                child: Text('opsi 2'),
                              ),
                            ],
                          ),
                        ),
                        ),
                        
                        
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20, right: 10),
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: AppTheme.yellow,
                foregroundColor: Colors.black,
                tooltip: 'Add',
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return Tambahpromobaru();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
