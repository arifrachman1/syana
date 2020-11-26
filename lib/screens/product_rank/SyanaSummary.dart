import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';

class SyanaSummary extends StatefulWidget {
  @override
  _SyanaSummaryState createState() => _SyanaSummaryState();
}

class _SyanaSummaryState extends State<SyanaSummary> {
  bool _isLoading = false;

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }
  String selectedToko;
  String selectedEcommerce;

  List _toko = [
    'Toko A (100|80|20)',
    'Toko B (100|80|20)',
    'Toko C (100|80|20)',
    'Toko D (100|80|20)',
  ];

  List _ecommerce = [
    'Shoope (10|8|2)',
    'Tokopedia (10|8|2)',
    'Bukalapak (10|8|2)',
    'JD.ID (10|8|2)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.lightGreen[200],
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.1,
                  //alignment: ,
                  child: Expanded(
                    child: Container(
                    // padding: EdgeInsets.only(left: 10),
                    //decoration: AppTheme.inputDecorationShadow(),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: selectedToko,
                        items: _toko.map((value) {
                          return DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedToko = value;
                          });
                        },
                      ),
                    ),
                    ),
                    ),
                  ),
                Container(
                  //alignment: ,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Expanded(
                            child: Container(
                                // width: 150,
                                //padding: EdgeInsets.only(left: 10),
                                //decoration: AppTheme.inputDecorationShadow(),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: selectedEcommerce,
                                    items: _ecommerce.map((value) {
                                      return DropdownMenuItem(
                                        child: Text(value),
                                        value: value,
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedEcommerce = value;
                                      });
                                    },
                                  ),
                                )),
                          ),),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            
                            color: AppTheme.white
                                //index < 3 ? AppTheme.teal_light : AppTheme.teal,
                            //borderRadius: BorderRadius.circular(12),
                          ),
                          //height: Dimens.listHeightSmall(context),
                          margin: EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: <Widget>[
                              /* Flexible(
                                flex: 10,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    (index + 1).toString(),
                                    style: TextStyle(
                                      color: index < 3
                                          ? AppTheme.text_darker
                                          : AppTheme.text_light,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ), */ 
                              Flexible(
                                flex: 20,
                                //fit: FlexFit.tight,
                                child: Container(
                                  child: Text(
                                        'Produk A'
                                        /* rankBestProducts[index].name, */,
                                        softWrap: true,
                                        style: TextStyle(
                                            //color: AppTheme.
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                ),
                              ),
                              Flexible(
                                flex: 40,
                                fit: FlexFit.tight,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Text(
                                        '50'
                                        /* rankBestProducts[index].rankValue */,
                                       softWrap: true,
                                        style: TextStyle(
                                          color:AppTheme.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '50'
                                        /* rankBestProducts[index].rankValue */,
                                        //softWrap: true,
                                        style: TextStyle(
                                          color: index < 3
                                              ? AppTheme.text_darker
                                              : AppTheme.text_light,
                                          fontSize: 14,
                                        ),
                                      ),
                                    
                                    ],
                                  )
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
    );
  }
}
