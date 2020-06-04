import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syana/Controller/PromoController.dart';
import 'package:syana/Controller/SaleController.dart';
import 'package:syana/models/ProductModel.dart';
import 'package:syana/models/PromoModel.dart';
import 'package:syana/screens/sale/SyanaConfirmation.dart';
import 'package:syana/screens/sale/SyanaPenjualanTimhariini.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import 'package:syana/utils/Strings.dart';
import 'package:syana/widgets/CustomDialog.dart';
import 'package:syana/widgets/SaleWidgets.dart';
import '../../main.dart';

class Sale extends StatefulWidget {
  @override
  SaleState createState() => SaleState();
}

class SaleState extends State<Sale> with SingleTickerProviderStateMixin {
  TabController _tabController;
  SaleController _saleController;
  PromoController _promoController;
  bool _isLoading = false, _isDataLoaded = false;

  List<ProductModel> products = new List();
  List<PromoModel> promos = new List();

  Map<String, String> categories = new Map();
  List<Widget> tabs = new List();
  List<Widget> pages = new List();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabs.clear();
    pages.clear();
  }

  @override
  void initState() {
    super.initState();
    setLoadingState();
    _saleController = new SaleController();
    _promoController = new PromoController();

    print("initstate");
    initTabs();
  }

  initTabs() async {
    await _saleController.getProducts(context, setLoadingState, setData);

    print("products length : " + products.length.toString());

    categories = await _saleController.getCategoriesFromProducts(products);
    print("categories length : " + categories.length.toString());
    setState(() {
      _tabController = TabController(
          vsync: this, length: categories.length, initialIndex: 0);
    });
    await generateTabs();
    await generatePages();
    setLoadingState();
    setDataLoaded();
  }

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

  setDataLoaded() {
    setState(() {
      _isDataLoaded = _isDataLoaded ? false : true;
    });
  }

  setData(data) {
    if (data is List<ProductModel> && data.isNotEmpty) {
      setState(() {
        products = data;
      });
    }
  }

  /*generate tab for each categories*/
  generateTabs() {
    if (categories is Map<String, String> && categories.isNotEmpty) {
      categories.forEach((key, value) {
        setState(() {
          tabs.add(Container(
            child: Text(
              value,
              style: TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ));
        });
      });
    }
  }

  /*generate pages for each tab*/
  generatePages() {
    if (categories is Map<String, String> && categories.isNotEmpty) {
      categories.forEach((key, value) {
        List categorizedProducts = new List();

        if (key != "0") {
          categorizedProducts =
              _saleController.getProductsByCategory(products, key);
        }

        setState(() {
          pages.add(SaleInnerWidget(key == "0" ? products : categorizedProducts,
              _saleController, promos, _promoController));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              decoration: AppTheme.appBackground(),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 30),
                    decoration: AppTheme.tabbarDecoration(),
                    child: TabBar(
                        controller: _tabController,
                        indicatorColor: AppTheme.teal,
                        unselectedLabelColor: AppTheme.teal,
                        labelColor: AppTheme.teal,
                        isScrollable: true,
                        tabs: tabs),
                  ),
                  Expanded(
                    flex: 10,
                    child: Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: TabBarView(
                          controller: _tabController, children: pages),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 12,
                        right: 5,
                        left: 5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FloatingActionButton(
                            backgroundColor: AppTheme.yellow,
                            foregroundColor: Colors.black,
                            tooltip: 'Add',
                            child: Icon(
                              Icons.playlist_add_check,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return PenjualanTimHariIni();
                                  },
                                ),
                              );
                            },
                          ),
                          Container(
                            width: Dimens.buttonWidth(context),
                            child: AspectRatio(
                              aspectRatio: Dimens.buttonRatio(),
                              child: RaisedButton(
                                child: Text(
                                  'KEMBALI',
                                ),
                                shape: AppTheme.roundButton(),
                                color: AppTheme.btn_default,
                                onPressed: () {
                                  Navigator.pop(context);
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
                                  'LANJUT',
                                  style: TextStyle(
                                    color: AppTheme.text_light,
                                  ),
                                ),
                                shape: AppTheme.roundButton(),
                                color: AppTheme.btn_success,
                                onPressed: () {
                                  if (_saleController
                                      .getSelectedProduct()
                                      .isNotEmpty) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return Confirmation(
                                              _saleController
                                                  .getSelectedProduct(),
                                              _saleController.getTotal(true),
                                              _saleController.getTotal(false));
                                        },
                                      ),
                                    );
                                  } else {
                                    CustomDialog.getDialog(
                                        title: Strings.DIALOG_TITLE_WARNING,
                                        message: Strings
                                            .DIALOG_MESSAGE_INSUFFICENT_ITEM,
                                        context: context,
                                        popCount: 1);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

/*Inner Sale Widget*/
/*I separated the 'inner' widget so that they could filter each assigned products*/
class SaleInnerWidget extends StatefulWidget {
  List<ProductModel> categorizedProducts;
  List<PromoModel> promos;
  SaleController saleController;
  PromoController promoController;

  SaleInnerWidget(this.categorizedProducts, this.saleController, this.promos,
      this.promoController);

  _SaleInnerState createState() => _SaleInnerState();
}

class _SaleInnerState extends State<SaleInnerWidget> {
  TextEditingController _searchController = new TextEditingController();
  List<ProductModel> categorizedProducts = new List();

  List<ProductModel> selectedProducts = new List();
  List<ProductModel> filteredProducts = new List();
  List<ProductModel> filteredProductsBefore = new List();

  List<PromoModel> _promos = new List();

  String searchFilter = "";
  double _totalPrice = 0;

  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.promoController
        .getPromoForSales(context, setLoadingState, setPromos);

    setState(() {
      categorizedProducts = widget.categorizedProducts;
      filteredProducts = categorizedProducts;
    });

    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          searchFilter = "";
          filteredProducts = categorizedProducts;
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

  setPromos(data) {
    if (data is List<PromoModel>) {
      setState(() {
        _promos = data;
      });
    }
  }

  add(index, isSale) {
    /*update view*/
    int number = isSale
        ? int.parse(filteredProducts[index].saleNumber)
        : int.parse(filteredProducts[index].freeNumber);

    number++;

    /*to update the widget's(view) number*/
    setState(() {
      isSale
          ? filteredProducts[index].saleNumber = number
          : filteredProducts[index].freeNumber = number;
    });
    /*update view*/

    /*pass the selected product(s) to the controller*/
    if (number == 1) {
      widget.saleController.addSelectedProduct(filteredProducts[index]);
    } else {
      isSale
          ? widget.saleController.setSaleNumber(filteredProducts[index],
              int.parse(filteredProducts[index].saleNumber))
          : widget.saleController.setFreeNumber(filteredProducts[index],
              int.parse(filteredProducts[index].freeNumber));
    }

    /*promo checking*/
    if (isSale) {
      _totalPrice += double.parse(filteredProducts[index].price);
      Map _promoStatus = widget.promoController.checkAvailablePromo(
          filteredProducts[index].id,
          int.parse(filteredProducts[index].saleNumber),
          _promos,
          _totalPrice);
      print("function finished");
      if (_promoStatus.isEmpty) {
        print("no return value...");
      } else {
        _promoStatus.forEach((key, value) {
          print(key + ":" + value.toString());
        });

        if (_promoStatus['status'] == true) {
          print("status : true");
          addFreeItemFromPromo(
              _promoStatus['freeProduct'], _promoStatus['freeAmount']);
        }
      }
    }
  }

  addFreeItemFromPromo(productId, productSize) {
    filteredProducts.forEach((element) {
      if (element.id == productId) {
        for (int i = 0; i < int.parse(productSize); i++) {
          add(filteredProducts.indexOf(element), false);
        }
      }
    });
  }

  removeFreeItemFromPromo(productId, productSize) {
    filteredProducts.forEach((element) {
      if (element.id == productId) {
        for (int i = 0; i < int.parse(productSize); i++) {
          remove(filteredProducts.indexOf(element), false);
        }
      }
    });
  }

  remove(index, isSale) {
    /*update view*/
    int number = isSale
        ? int.parse(filteredProducts[index].saleNumber)
        : int.parse(filteredProducts[index].freeNumber);
    number--;
    /*to update widget's(view) number*/
    setState(() {
      isSale
          ? filteredProducts[index].saleNumber = number
          : filteredProducts[index].freeNumber = number;
    });
    /*update view*/

    /*pass the desired object to controller to substract its value or remove it when the value hits 0*/
    if (number >= 0) {
      isSale
          ? widget.saleController.setSaleNumber(filteredProducts[index],
              int.parse(filteredProducts[index].saleNumber))
          : widget.saleController.setFreeNumber(filteredProducts[index],
              int.parse(filteredProducts[index].freeNumber));
      /*after we decrese the number, then we check whether there is a zero number or not*/
      widget.saleController.checkZeroNumber();
    } else {
      setState(() {
        isSale
            ? filteredProducts[index].saleNumber = 0
            : filteredProducts[index].freeNumber = 0;
        /*categorizedProducts[index].saleNumber = 0;*/
      });
    }

    /*promo checking*/
    if (isSale && (int.parse(filteredProducts[index].saleNumber) != 0)) {
      if (_totalPrice != 0) {
        _totalPrice -= double.parse(filteredProducts[index].price);
      }
      Map _promoStatus = widget.promoController.checkAvailablePromo(
          filteredProducts[index].id,
          int.parse(filteredProducts[index].saleNumber),
          _promos,
          _totalPrice);
      print("function finished");
      if (_promoStatus.isEmpty) {
        print("no return value...");
      } else {
        _promoStatus.forEach((key, value) {
          print(key + ":" + value.toString());
        });
        if (_promoStatus['status'] == false) {
          removeFreeItemFromPromo(
              _promoStatus['freeProduct'], _promoStatus['freeAmount']);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(searchFilter);
    if (searchFilter.isNotEmpty) {
      List<ProductModel> temp = new List();

      if (filteredProducts.isEmpty) {
        filteredProducts = filteredProductsBefore;
      }

      filteredProducts.forEach((value) {
        if (value.name.toLowerCase().contains(searchFilter.toLowerCase())) {
          temp.add(value);
          filteredProductsBefore = temp;
        }
      });
      filteredProducts = temp;
    }

    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  /*search bar*/
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
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
                  /*label sold & free*/
                  Container(
                    margin: EdgeInsets.only(top: 15, bottom: 10),
                    padding: EdgeInsets.only(left: 10, right: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: AppTheme.yellow,
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black45,
                                blurRadius: 3,
                                spreadRadius: 3 / 4,
                                offset: Offset(1, 2),
                              ),
                            ],
                          ),
                          height: MediaQuery.of(context).size.height * 0.03,
                          child: AspectRatio(
                            aspectRatio: 2.5 / 1,
                            child: Center(
                              child: Text(
                                'Terjual',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.text_dark,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppTheme.red,
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black45,
                                blurRadius: 3,
                                spreadRadius: 3 / 4,
                                offset: Offset(1, 2),
                              ),
                            ],
                          ),
                          height: MediaQuery.of(context).size.height * 0.03,
                          child: AspectRatio(
                            aspectRatio: 2.5 / 1,
                            child: Center(
                              child: Text(
                                'Free',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.text_light,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              /*item*/
              Expanded(
                child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: filteredProducts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: AppTheme.listBackground(),
                          height: Dimens.listHeight(context),
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
                                flex: 49,
                                fit: FlexFit.tight,
                                child: Container(
                                  child: Text(
                                    filteredProducts[index].name,
                                    style: TextStyle(
                                      color: AppTheme.text_light,
                                      fontSize: 15,
                                    ),
                                    softWrap: true,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 17,
                                fit: FlexFit.tight,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        Icons.expand_less,
                                        color: AppTheme.white,
                                        size: 24,
                                      ),
                                      onPressed: () => add(index, true),
                                    ),
                                    Text(filteredProducts[index].saleNumber,
                                        style: TextStyle(
                                          color: AppTheme.text_light,
                                          fontSize: 14,
                                        ),
                                        softWrap: true),
                                    IconButton(
                                      icon: Icon(
                                        Icons.expand_more,
                                        color: AppTheme.white,
                                        size: 24,
                                      ),
                                      onPressed: () => remove(index, true),
                                    )
                                  ],
                                ),
                              ),
                              Flexible(
                                flex: 17,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(
                                          Icons.expand_less,
                                          color: AppTheme.white,
                                          size: 24,
                                        ),
                                        onPressed: () => add(index, false),
                                      ),
                                      Text(filteredProducts[index].freeNumber,
                                          style: TextStyle(
                                            color: AppTheme.text_light,
                                            fontSize: 14,
                                          ),
                                          softWrap: true),
                                      IconButton(
                                        icon: Icon(
                                          Icons.expand_more,
                                          color: AppTheme.white,
                                          size: 24,
                                        ),
                                        onPressed: () => remove(index, false),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )),
              ),
            ],
          );
  }
}
