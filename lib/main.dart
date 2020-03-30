import 'package:flutter/material.dart';
import 'package:syana/SyanaInputdatapelanggan.dart';
import 'package:syana/SyanaInputresi.dart';
import 'package:syana/SyanaPenjualanTimhariini.dart';
import 'package:syana/SyanaPerincian.dart';
import 'package:syana/SyanaPromo.dart';
import 'package:syana/SyanaTambahpromobaru.dart';
import 'SyanaHome.dart';

void main() => runApp(MyApp());

background(){
    return BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.lightGreen[200], Colors.teal[200]]));
}

listBackground(){
  return BoxDecoration(
          color: Colors.teal,
          border: Border.all(
          color: Colors.teal,
          ),
          borderRadius: BorderRadius.circular(12),
        );
}

inputDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(12),
    );
}

textFieldDecoration(hint) {
  return InputDecoration(
            contentPadding: EdgeInsets.only(left: 10.0),
            border: InputBorder.none,
            hintText: hint);
}

tabbarDecoration() {
  return
    BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.grey,
          width: 1
        )
      )
    );
}

inputDecorationShadow() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(
                    color: Colors.black45,
                    blurRadius: 5,
                    offset: Offset(1,2)
                    )
                  ]
    );
}

roundDecorationShadow() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(
                    color: Colors.black45,
                    blurRadius: 5,
                    offset: Offset(1,2)
                    )
                  ]
    );
}

decorationShadow() {
    return BoxDecoration(
      boxShadow: [BoxShadow(
                    color: Colors.black45,
                    blurRadius: 5,
                    offset: Offset(1,2)
                    )
                  ]
    );
}

//shadow untuk text
  shadowText() {
    return
    Shadow(
      color: Colors.black45,
      blurRadius: 5,
      offset: Offset(1,2)
    );
  }

roundButton(){
  return 
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(7));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Home()
    );
  }
}

class Beranda extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[200],
        title: Text('Beranda'),
      ),
      body: 
      Container(
        height: (MediaQuery.of(context).size.height /1),
        child: 
        Center(
          child: 
            Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RaisedButton(
                child: 
                Text('Perincian'),
                onPressed: () {
                Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Perincian();
                    }
                  )
                );
                }
              ),
              RaisedButton(
                child: 
                Text('Penjualan Tim Hari Ini'),
                onPressed: () {
                Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return PenjualanTimHariIni();
                    }
                  )
                );
                }
              ),
              RaisedButton(
                child: 
                Text('Promo'),
                onPressed: () {
                Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Promo();
                    }
                  )
                );
                }
              ),
              RaisedButton(
                child: 
                Text('Input Resi'),
                onPressed: () {
                Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return InputResi();
                    }
                  )
                );
                }
              ),
              RaisedButton(
                child:
                Text('Input Data Pelanggan'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return InputDataPelanggan();
                      }
                    )
                  );
                },
              ),
              RaisedButton(
                child:
                Text('Home'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return Home();
                      }
                    )
                  );
                },
              )
            ],
          ),
        )
      ),
    );
  }
}
