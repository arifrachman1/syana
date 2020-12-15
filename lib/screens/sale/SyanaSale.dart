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
import 'package:syana/utils/FontHelper.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/utils/Strings.dart';
import 'package:syana/widgets/CustomDialog.dart';
import 'package:syana/widgets/CustomImage.dart';

class Sale extends StatefulWidget {
  int tipe;
  Sale({this.tipe});
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

  final String _devTitle = "sale";

  @override
  void dispose() {
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
              _saleController, promos, _promoController, products));
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
                                              _saleController.getTotal(false),
                                              widget.tipe);
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
  List<ProductModel> allProducts;
  List<PromoModel> promos;
  SaleController saleController;
  PromoController promoController;

  SaleInnerWidget(this.categorizedProducts, this.saleController, this.promos,
      this.promoController, this.allProducts);

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

  final String _devTitle = "sale_inner";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
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

  /*add item*/
  add(id, isSale) {
    /*search id*/
    var indexOfFilteredProducts, indexOfAllProducts;
    filteredProducts.forEach((element) {
      if (element.id == id) {
        indexOfFilteredProducts = filteredProducts.indexOf(element);
      }
    });

    categorizedProducts.forEach((element) {
      if (element.id == id) {
        indexOfAllProducts = categorizedProducts.indexOf(element);
      }
    });

    /*update view*/
    int numberForFilter = isSale
        ? int.parse(filteredProducts[indexOfFilteredProducts].saleNumber)
        : int.parse(filteredProducts[indexOfFilteredProducts].freeNumber);

    numberForFilter++;

    /*to update the widget's(view) number*/
    setState(() {
      isSale
          ? filteredProducts[indexOfFilteredProducts].saleNumber =
              numberForFilter
          : filteredProducts[indexOfFilteredProducts].freeNumber =
              numberForFilter;
    });
    /*update view*/

    /*pass the selected product(s) to the controller*/
    if (numberForFilter == 1) {
      widget.saleController
          .addSelectedProduct(categorizedProducts[indexOfAllProducts]);
    } else {
      isSale
          ? widget.saleController.setSaleNumber(
              categorizedProducts[indexOfAllProducts],
              int.parse(categorizedProducts[indexOfAllProducts].saleNumber))
          : widget.saleController.setFreeNumber(
              categorizedProducts[indexOfAllProducts],
              int.parse(categorizedProducts[indexOfAllProducts].freeNumber));
    }

    /*promo checking*/
    if (isSale) {
      _totalPrice +=
          double.parse(categorizedProducts[indexOfAllProducts].price);
      Map _promoStatus = widget.promoController.checkAvailablePromo(
          categorizedProducts[indexOfAllProducts].id,
          int.parse(categorizedProducts[indexOfAllProducts].saleNumber),
          _promos,
          _totalPrice);

      if (_promoStatus.isEmpty) {
        GlobalFunctions.log(message: "no return value...", name: _devTitle);
      } else {
        if (_promoStatus['status'] == true) {
          /*_promoStatus.forEach((key, value) {
            log("$key : $value", name: _devTitle);
          });*/
          addFreeItemFromPromo(
              _promoStatus['freeProduct'], _promoStatus['freeAmount']);
        }
      }
    }
  }

  /*remove item*/
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

  /*add free item with promo
  * we reproduced the steps in 'add' function
  * we need to separate add item with add item alongside promo
  * because we handle the promo with different list*/
  addFreeItemFromPromo(productId, productSize) {
    /*find the product from the products list*/
    categorizedProducts.forEach((element) {
      /*find the product using id*/
      if (element.id == productId) {
        /*when the product is found, we need to determine how much it will increase
        * its number as decided on promo*/
        for (int i = 0; i < int.parse(productSize); i++) {
          /*after we found the product, we need its index to increase its free number*/
          var index = categorizedProducts.indexOf(element);
          int amount = int.parse(categorizedProducts[index].freeNumber);

          amount++;

          setState(() {
            categorizedProducts[index].freeNumber = amount;
          });

          if (amount == 1) {
            widget.saleController
                .addSelectedProduct(categorizedProducts[index]);
          } else {
            widget.saleController.setFreeNumber(categorizedProducts[index],
                int.parse(categorizedProducts[index].freeNumber));
          }
        }
      }
    });
  }

  /*remove item with promo
  * we reproduced the steps in 'add' function
  * we need to separate add item with add item alongside promo
  * because we handle the promo with different list
  * we implemented the same step as addItemFromPromo*/
  removeFreeItemFromPromo(productId, productSize) {
    categorizedProducts.forEach((element) {
      if (element.id == productId) {
        for (int i = 0; i < int.parse(productSize); i++) {
          var index = categorizedProducts.indexOf(element);
          int amount = int.parse(categorizedProducts[index].freeNumber);

          amount--;

          setState(() {
            categorizedProducts[index].freeNumber = amount;
          });

          if (amount >= 0) {
            widget.saleController.setFreeNumber(categorizedProducts[index],
                int.parse(categorizedProducts[index].freeNumber));
            widget.saleController.checkZeroNumber();
          } else {
            setState(() {
              categorizedProducts[index].freeNumber = 0;
            });
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
        } else if (value.sku
            .toString()
            .toLowerCase()
            .contains(searchFilter.toLowerCase())) {
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
                                    child: CustomImage.getProductImage(
                                        filteredProducts[index].image)),
                              ),
                              Flexible(
                                  flex: 49,
                                  fit: FlexFit.tight,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          filteredProducts[index].name,
                                          style: FontHelper.textListTitle,
                                          softWrap: true,
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          filteredProducts[index].sku,
                                          style: FontHelper.textListSubtitle,
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
                                  )),
                              Flexible(
                                flex: 17,
                                fit: FlexFit.tight,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.expand_less,
                                          color: AppTheme.white,
                                          size: 24,
                                        ),
                                      ),
                                      onTap: () =>
                                          add(filteredProducts[index].id, true),
                                      onLongPress: () {
                                        for (var i = 0; i < 10; i++) {
                                          add(filteredProducts[index].id, true);
                                        }
                                      },
                                    ),
                                    Text(filteredProducts[index].saleNumber,
                                        style: TextStyle(
                                          color: AppTheme.text_light,
                                          fontSize: 14,
                                        ),
                                        softWrap: true),
                                    GestureDetector(
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.expand_more,
                                          color: AppTheme.white,
                                          size: 24,
                                        ),
                                      ),
                                      onTap: () => remove(index, true),
                                      onLongPress: () {
                                        for (var i = 0; i < 10; i++) {
                                          remove(index, true);
                                        }
                                      },
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
                                      GestureDetector(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.expand_less,
                                            color: AppTheme.white,
                                            size: 24,
                                          ),
                                        ),
                                        onTap: () => add(
                                            filteredProducts[index].id, false),
                                        onLongPress: () {
                                          for (var i = 0; i < 10; i++) {
                                            add(filteredProducts[index].id,
                                                false);
                                          }
                                        },
                                      ),
                                      Text(filteredProducts[index].freeNumber,
                                          style: TextStyle(
                                            color: AppTheme.text_light,
                                            fontSize: 14,
                                          ),
                                          softWrap: true),
                                      GestureDetector(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.expand_more,
                                            color: AppTheme.white,
                                            size: 24,
                                          ),
                                        ),
                                        onTap: () => remove(index, false),
                                        onLongPress: () {
                                          for (var i = 0; i < 10; i++) {
                                            remove(index, false);
                                          }
                                        },
                                      )
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
