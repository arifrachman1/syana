import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';
import './main.dart';

class StokMain extends StatefulWidget {
  @override
  StokMainState createState() => StokMainState();
}

class StokMainState extends State<StokMain> {
  List<List> stok = [
    ['(Better) Botanical Slimming Message Oil', '9 SP', 181],
    ['(Hotter) Botanical Slimming Massage Oil Carolina', '7 SP', 89],
    ['(Kelapa) Evco Casa Di Sana', '0.7 SP', 6],
    ['(Natuna) Tea Tree Essential', '1 SP', -71],
    ['(Zaitun) Evco Casa Di Sana', '0.7 SP', -57],
    ['(Zaitun) Evco WAKANDA 100ml', '0.5 SP', 30],
    ['(Zaitun) Evco WAKANDA 100ml', '0.5 SP', 30],
  ];

  getStok(index, index2) {
    var selectedStok = stok[index];
    return selectedStok[index2];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              padding: EdgeInsets.only(left: 10),
              decoration: inputDecorationShadow(),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Cari Produk',
                  icon: Icon(
                    Icons.search,
                    color: AppTheme.teal,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemCount: stok.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: listBackground(),
                      height: 90,
                      margin: EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 70,
                            child: Icon(
                              Icons.image,
                              size: 60,
                              color: AppTheme.teal_light,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  getStok(index, 0),
                                  style: TextStyle(
                                    color: AppTheme.text_light,
                                    fontSize: 15,
                                  ),
                                  softWrap: true,
                                ),
                                Text(
                                  getStok(index, 1),
                                  style: TextStyle(
                                    color: AppTheme.text_light,
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 60,
                            child: Text(
                              getStok(index, 2).toString(),
                              style: TextStyle(
                                color: AppTheme.text_light,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(bottom: 25, right: 10),
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            backgroundColor: AppTheme.yellow,
            foregroundColor: Colors.black,
            tooltip: 'Add',
            child: Icon(Icons.filter_list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return null;
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
