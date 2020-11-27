import 'package:flutter/material.dart';



class PackingScanQR extends StatefulWidget {
  @override
  _PackingSCanQRState createState() => _PackingSCanQRState();
}

class _PackingSCanQRState extends State<PackingScanQR> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Scan QR"),
          backgroundColor: Colors.lightGreen
        ),
        backgroundColor: Colors.lightGreen[200],
        body: Container(
          margin: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              buildHeader(),
              buildContent(),
              buildContent2(),
              _buildButton()
            ],
          ),
        )
      ),
    );
  }

  Card buildHeader() {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
          Container(margin:EdgeInsets.fromLTRB(5,15,15,15), child: Text("No.")),
          Container(margin:EdgeInsets.all(15), child: Text("Nama")),
          Container(margin:EdgeInsets.all(15), child: Text("Berat")),
          Container(margin:EdgeInsets.all(15), child: Text("Jumlah")),
          Container(margin:EdgeInsets.all(15), child: Text("Scan"))
        ],
      ),
    );
  }
  Card buildContent(){
    return Card(
      color: Colors.lightGreen[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
          Container(margin:EdgeInsets.fromLTRB(5,15,5,15), child: Text("1.")),
          Container(margin:EdgeInsets.all(15), child: Text("Item 1")),
          Container(margin:EdgeInsets.all(15), child: Text("5")),
          Container(margin:EdgeInsets.all(15), child: Text("5")),
          Container(margin:EdgeInsets.all(15), child: Text("1/5"))
        ],
      )
    );
  }
  Card buildContent2(){
    return Card(
      color: Colors.lightGreen[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
          Container(margin:EdgeInsets.fromLTRB(5,15,5,15), child: Text("2.")),
          Container(margin:EdgeInsets.all(15), child: Text("Item 2")),
          Container(margin:EdgeInsets.all(15), child: Text("5")),
          Container(margin:EdgeInsets.all(15), child: Text("5")),
          Container(margin:EdgeInsets.all(15), child: Text("1/5"))
        ],
      )
    );
  }
  Widget _buildButton(){
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top:20.0),
        ),
        OutlineButton(
          child: Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            width: 150.0,
            child: Text(
              'Packing Sekarang',
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: Colors.yellow,
            ),
          ),
          onPressed: (null),
        ),
      ],
    );
  }
}