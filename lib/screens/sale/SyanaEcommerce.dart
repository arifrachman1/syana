import 'package:flutter/material.dart';
import 'package:syana/Controller/SaleController.dart';
import 'file:///E:/workspace/flutter_project/syana/lib/screens/sale/SyanaInputdatapelanggan.dart';
import 'file:///E:/workspace/flutter_project/syana/lib/screens/sale/SyanaPenjualan.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import '../../main.dart';

class SyanaEcommerce extends StatefulWidget {
  @override
  EcommerceState createState() => EcommerceState();
}

class EcommerceState extends State<SyanaEcommerce> {
  SaleController _saleController;
  List<String> ecommerces = ['Tokopedia', 'Shoppe'];

  String selectedEcommerce;
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    _saleController = new SaleController();
    _saleController.getEcommerce(context, setLoadingState, setEcommerce);
    print("run");
    selectedEcommerce = ecommerces[0];
  }

  void setLoadingState() {
    setState(() {
      isLoading = isLoading ? isLoading = false : isLoading = true;
    });
  }

  void onChangedToko(value) {
    setState(() {
      this.selectedEcommerce = value;
    });
  }

  setEcommerce(ecommerceData){
    if(ecommerceData is List && ecommerceData.isNotEmpty){
      setState(() {
        ecommerces = ecommerceData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.appBackground(),
        height: MediaQuery.of(context).size.height,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 50.0),
            padding:
                EdgeInsets.only(top: 15.0, left: 20, right: 20, bottom: 20),
            child: Column(
              children: <Widget>[
                Container(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: AppTheme.inputDecoration(),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: selectedEcommerce,
                            items: ecommerces.map(
                              (String val) {
                                return DropdownMenuItem(
                                  value: val,
                                  child: Text(
                                    val,
                                    style: TextStyle(
                                      color: AppTheme.text_dark,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (String value) {
                              onChangedToko(value);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Pilih metode input Resi',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: AppTheme.text_light,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: Dimens.buttonWidth(context),
                        child: AspectRatio(
                          aspectRatio: Dimens.buttonRatio(),
                          child: RaisedButton(
                            child: Text(
                              'MANUAL',
                            ),
                            shape: AppTheme.roundButton(),
                            color: AppTheme.btn_default,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return InputDataPelanggan();
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        width: Dimens.buttonWidth(context),
                        child: AspectRatio(
                          aspectRatio: Dimens.buttonRatio(),
                          child: RaisedButton(
                            child: Text(
                              'OTOMATIS',
                              style: TextStyle(
                                color: AppTheme.text_light,
                              ),
                            ),
                            shape: AppTheme.roundButton(),
                            color: AppTheme.btn_success,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return Penjualan();
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
