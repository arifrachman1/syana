import 'package:flutter/material.dart';
import 'package:syana/Controller/InventoryController.dart';
import 'package:syana/models/ProductModel.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import 'package:syana/widgets/CustomBottomNav.dart';
import 'package:syana/widgets/CustomTextInput.dart';
import '../../main.dart';

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
  InventoryController _inventoryController;
  List<ProductModel> stocks = new List();
  List<ProductModel> filteredStocks = new List();
  List<ProductModel> filteredStocksBefore = new List();

  TextEditingController _searchController = new TextEditingController();

  String searchFilter = "";

  bool _isLoading = false, _isAsc = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _inventoryController = new InventoryController();
    _initSearch();
  }

  _initSearch() async {
    await _inventoryController.getStock(context, setLoadingState, setData, '1');
    setState(() {
      filteredStocks = stocks;
    });

    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          searchFilter = "";
          filteredStocks = stocks;
        });
      } else {
        setState(() {
          searchFilter = _searchController.text;
        });
      }
    });
  }

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

  void setData(data) {
    if (data is List<ProductModel> && data.isNotEmpty) {
      setState(() {
        stocks = data;
        filteredStocks = stocks;
      });
    }
  }

  getStok(index, index2) {
    var selectedStok = stok[index];
    return selectedStok[index2];
  }

  @override
  Widget build(BuildContext context) {
    if (searchFilter.isNotEmpty) {
      List<ProductModel> temp = new List();

      if (filteredStocks.isEmpty) {
        filteredStocks = filteredStocksBefore;
      }

      filteredStocks.forEach((value) {
        if (value.name.toLowerCase().contains(searchFilter.toLowerCase())) {
          temp.add(value);
          filteredStocksBefore = temp;
        }
      });
      filteredStocks = temp;
    }
    return Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: CustomBottomNav.getBottomNav(context, 0),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppTheme.yellow,
          foregroundColor: Colors.black,
          tooltip: 'Add',
          child: Icon(Icons.filter_list),
          onPressed: () {
            setState(() {
              _isAsc = _isAsc ? false : true;
            });

            _inventoryController.getStock(
                context, setLoadingState, setData, _isAsc ? "1" : "2");
          },
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () {
                  _inventoryController.getStock(
                      context, setLoadingState, setData, _isAsc ? "1" : "2");
                },
                child: Container(
                  decoration: AppTheme.appBackground(),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: CustomTextInput.getCustomTextField(
                            context: context,
                            controller: _searchController,
                            hint: "Cari Produk",
                            icon: Icon(Icons.search),
                            textInputType: TextInputType.text,
                            isPasswordField: false),
                      ),
                      
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 10,
                            right: 10,
                            left: 10,
                          ),
                          child: ListView.builder(
                            padding: EdgeInsets.all(0),
                            shrinkWrap: true,
                            itemCount: filteredStocks.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: AppTheme.listBackground(),
                                height: Dimens.listHeightSmall(context),
                                margin: EdgeInsets.only(bottom: 15),
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      flex: 17,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.image,
                                          size: 60,
                                          color: AppTheme.teal_light,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 66,
                                      fit: FlexFit.tight,
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              filteredStocks[index].name,
                                              style: TextStyle(
                                                color: AppTheme.text_light,
                                                fontSize: 15,
                                              ),
                                              softWrap: true,
                                            ),
                                            Text(
                                              filteredStocks[index].point,
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
                                    ),
                                    Flexible(
                                      flex: 17,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          filteredStocks[index].stock,
                                          style: TextStyle(
                                            color: AppTheme.text_light,
                                            fontSize: 15,
                                          ),
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
              ));
  }
}
