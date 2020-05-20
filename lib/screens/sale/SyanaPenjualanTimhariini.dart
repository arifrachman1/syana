import 'package:flutter/material.dart';
import 'package:syana/Controller/SaleController.dart';
import 'package:syana/models/TransactionHistoryModel.dart';
import 'package:syana/utils/AppTheme.dart';
import '../../main.dart';

class PenjualanTimHariIni extends StatefulWidget {
  @override
  PenjualanState createState() => PenjualanState();
}

class PenjualanState extends State<PenjualanTimHariIni> {
  SaleController _saleController;
  TextEditingController _searchController = new TextEditingController();
  bool _isLoading = false;

  List<TransactionHistoryModel> productHistories = new List();
  List<TransactionHistoryModel> filteredProductHistories = new List();

  String searchFilter = "";

  List<List> penjualanTim = [
    ['Shoppe', '8819912058031444', '2020-03-13 13:27:07'],
    ['Shoppe', '8819912058031445', '2020-03-13 13:27:08'],
    ['Shoppe', '8819912058031446', '2020-03-13 13:27:09'],
  ];

  getPenjualanTim(index, index2) {
    var selectedPenjualanTim = penjualanTim[index];
    return selectedPenjualanTim[index2];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _saleController = new SaleController();

    print("initstate");
  }

  initDataHistories() async {
    setLoadingState();
    await _saleController.getHistoryProducts(context, setLoadingState, setData);
    print("histories length : " + productHistories.length.toString());
    setLoadingState();
  }

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

  setData(data) {
    if (data is List<TransactionHistoryModel> && data.isNotEmpty) {
      setState(() {
        productHistories = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[200],
        title: Text('Penjualan Tim Hari Ini'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 15, left: 10, right: 10),
              decoration: AppTheme.appBackground(),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.only(left: 10),
                    decoration: AppTheme.inputDecorationShadow(),
                    child: TextField(
                      controller: _searchController,
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
                      child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: productHistories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 110,
                            decoration: AppTheme.listBackground(),
                            margin: EdgeInsets.only(top: 7, bottom: 5),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(top: 10, left: 7),
                                  child: Text(
                                    productHistories[index].nameEcommerce,
                                    style: TextStyle(
                                      color: AppTheme.text_light,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 7, top: 7),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    productHistories[index].transactionNumber,
                                    style: TextStyle(
                                      color: AppTheme.text_light,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 7, bottom: 7),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    productHistories[index].datetimeCreated,
                                    style: TextStyle(
                                      color: AppTheme.text_light,
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
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
            ),
    );
  }
}
