import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';

class Purchasing extends StatefulWidget {
  @override
  _PurchasingState createState() => _PurchasingState();
}

class _PurchasingState extends State<Purchasing> {
  
  bool _isLoading = false;
  
  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        backgroundColor: Colors.lightGreen[200],
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
                : Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10.0),
                          height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.2,
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          decoration: AppTheme.inputDecorationShadow(),
                          width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.9,
                          height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.1,
                          child :FlatButton(
                                  child: Text("Plans",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 28
                                    ),
                                  ),
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                )
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: AppTheme.inputDecorationShadow(),
                          width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.9,
                          height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.1,
                          child :FlatButton(
                                  child: Text("Purchasing",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 28
                                    ),
                                  ),
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                )
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: AppTheme.inputDecorationShadow(),
                          width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.9,
                          height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.1,
                          
                          child :FlatButton(
                                  child: Text("History",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 28
                                    ),
                                  ),
                                  
                                )
                        )
                      ],
                    )
              )   
    );
  }
}