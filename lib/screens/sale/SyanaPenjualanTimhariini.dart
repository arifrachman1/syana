import 'package:flutter/material.dart';
import 'package:syana/Controller/SaleController.dart';
import 'package:syana/models/TransactionHistoryModel.dart';
import 'package:syana/utils/AppTheme.dart';

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
  List<TransactionHistoryModel> filteredProductHistoriesBefore = new List();

  String searchFilter = "";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _saleController = new SaleController();
    initDataHistories();
    print("initstate");
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          searchFilter = "";
          filteredProductHistories = productHistories;
        });
      } else {
        setState(() {
          searchFilter = _searchController.text;
        });
      }
    });
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
        filteredProductHistories = productHistories;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (searchFilter.isNotEmpty) {
      List<TransactionHistoryModel> temp = new List();

      if (filteredProductHistories.isEmpty) {
        filteredProductHistories = filteredProductHistoriesBefore;
      }

      filteredProductHistories.forEach((value) {
        if (value.transactionNumber
                .toLowerCase()
                .contains(searchFilter.toLowerCase()) ||
            value.nameEcommerce
                .toLowerCase()
                .contains(searchFilter.toLowerCase())) {
          temp.add(value);
          filteredProductHistoriesBefore = temp;
        }
      });
      filteredProductHistories = temp;
    }

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
                        itemCount: filteredProductHistories.length,
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
                                    filteredProductHistories[index]
                                        .nameEcommerce,
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
                                    filteredProductHistories[index]
                                        .transactionNumber,
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
                                    filteredProductHistories[index]
                                        .datetimeCreated,
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
