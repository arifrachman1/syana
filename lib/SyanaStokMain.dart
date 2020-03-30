import 'package:flutter/material.dart';
import './main.dart';

class StokMain extends StatefulWidget {
  @override
  StokMainState createState() => StokMainState();
}

class StokMainState extends State<StokMain> {

  List<List> stok = [
    ['(Better) Botanical Slimming Message Oil', '9 SP', 181],
    ['(Better) Botanical Slimming Message Oil', '9 SP', 181],
  ];

  getStok(index, index2){
    var selectedStok = stok[index];
    return selectedStok[index2];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 50),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: ListView.builder(
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
                        color: Colors.teal[200],
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
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            softWrap: true,
                          ),
                          Text(
                            getStok(index, 1),
                            style: TextStyle(
                              color: Colors.white,
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
                          color: Colors.white,
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
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          padding: EdgeInsets.only(left: 10),
          decoration: inputDecorationShadow(),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Cari Produk',
              icon: Icon(
                Icons.search,
                color: Colors.teal,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 25, right: 10),
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            backgroundColor: Colors.yellow[400],
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
