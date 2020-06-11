import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syana/Controller/InventoryController.dart';
import 'package:syana/Controller/PromoController.dart';
import 'package:syana/models/ProductModel.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/utils/ScreenSizeHelper.dart';
import 'package:syana/utils/Strings.dart';
import 'package:syana/widgets/CustomDialog.dart';
import 'package:syana/widgets/CustomTextInput.dart';

import 'SyanaAddPromoMain.dart';

class SyanaAddPromo extends StatefulWidget {
  @override
  AddPromoState createState() => AddPromoState();
}

class AddPromoState extends State<SyanaAddPromo> {
  int _currentOption, _currentTeam;
  InventoryController _inventoryController;
  PromoController _promoController;
  List<DropdownMenuItem> _teams = new List();
  List<DropdownMenuItem> _promoOptions = new List();

  static final int SET_TEAMS = 0;

  static final int OPTIONS_SAME_PRODUCT = 0;
  static final int OPTIONS_DIFFERENT_PRODUCT = 1;
  static final int OPTIONS_DIFFERENT_REQUIRED_WITH_DIFFERENT_FREE = 2;
  static final int OPTIONS_MINIMUM_TOTAL_PRICE = 3;

  TextEditingController _firstRequiredProduct = new TextEditingController(),
      _firstRequiredMinimum = new TextEditingController(),
      _freeProductSize = new TextEditingController(),
      _freeProduct = new TextEditingController(),
      _secondRequiredProduct = new TextEditingController(),
      _secondRequierdMinimum = new TextEditingController(),
      _priceMinimum = new TextEditingController();

  bool _isLoading = false;

  String _selectedFirstProduct = "",
      _selectedSecondProduct = "",
      _selectedFreeProduct = "";

  @override
  void initState() {
    _inventoryController = new InventoryController();
    _promoController = new PromoController();

    _initData();
  }

  /*we use initData function, so we can load dropdown items
  * for each dropdown one by one*/
  _initData() async {
    await _inventoryController.getTeams(
        context, setLoadingState, setData, false);
    _promoOptions = GlobalFunctions.generateDropdownMenuItem(childs: [
      'Promo produk sejenis',
      'Promo Produk Beda Jenis',
      'Promo Silang Produk Beda Jenis',
      'Promo Harga Minimum'
    ], values: [
      0,
      1,
      2,
      3
    ]);

    setState(() {
      _currentOption = _promoOptions[0].value;
    });
  }

  setData(data) {
    setState(() {
      _teams = data;
      _currentTeam = _teams[0].value;
    });
  }

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

  _onFirstRequiredProductSelected(suggestion) {
    print(suggestion);
    if (suggestion is ProductModel) {
      setState(() {
        _firstRequiredProduct.text =
            suggestion.name + " (" + suggestion.sku + ") ";
        _selectedFirstProduct = suggestion.id;
      });
    }
  }

  _onFreeProductSelected(suggestion) {
    print(suggestion);
    if (suggestion is ProductModel) {
      setState(() {
        _freeProduct.text = suggestion.name + " (" + suggestion.sku + ") ";
        _selectedFreeProduct = suggestion.id;
      });
    }
  }

  _onSecondRequiredProductSelected(suggestion) {
    print(suggestion);
    if (suggestion is ProductModel) {
      setState(() {
        _secondRequiredProduct.text =
            suggestion.name + " (" + suggestion.sku + ") ";
        _selectedSecondProduct = suggestion.id;
      });
    }
  }

  FutureOr<Iterable<dynamic>> _onProductChanged(pattern) async {
    if (pattern.toString().length >= 3) {
      return await _promoController.getProductData(
          context, pattern, _currentTeam);
    }
  }

  Widget _productItemBuilder(context, item) {
    return ListTile(
      title: Text(item.name),
      subtitle: Text(item.sku),
    );
  }

  _clear() {
    _selectedFirstProduct = "";
    _selectedSecondProduct = "";
    _selectedFreeProduct = "";

    _firstRequiredProduct.text = "";
    _firstRequiredMinimum.text = "";
    _freeProductSize.text = "";
    _freeProduct.text = "";
    _secondRequiredProduct.text = "";
    _secondRequierdMinimum.text = "";
    _priceMinimum.text = "";
  }

  /*form produk sejenis*/
  /*pilih produk
  * jumlah minimum
  * jumlah produk free*/

  /*form produk beda jenis*/
  /*pilih produk
  * jumlah minimum
  * pilih produk free
  * jumlah produk free*/

  /*form silang produk beda jenis*/
  /*pilih produk 1
  * jumlah minimum produk 1
  * pilih produk 2
  * jumlah minimum produk 2
  * pilih produk free
  * jumlah produk free*/

  _getSameProductWidgets() {
    return Column(
      children: <Widget>[
        Container(
          child: CustomTextInput.getCustomAutoCompleteField(
              context: context,
              controller: _firstRequiredProduct,
              hint: "Pilih Produk",
              textInputType: TextInputType.text,
              itemBuilderCallback: _productItemBuilder,
              suggestionCallback: _onProductChanged,
              onSuggestionSelectedCallback: _onFirstRequiredProductSelected),
        ),
        Container(
          child: CustomTextInput.getCustomTextField(
            context: context,
            controller: _firstRequiredMinimum,
            hint: "Jumlah minimum",
            textInputType: TextInputType.number,
          ),
        ),
        Container(
          child: CustomTextInput.getCustomTextField(
              context: context,
              controller: _freeProductSize,
              hint: "Jumlah free",
              textInputType: TextInputType.number),
        )
      ],
    );
  }

  _getDifferentProductsWidget() {
    return Column(
      children: <Widget>[
        Container(
          child: CustomTextInput.getCustomAutoCompleteField(
              context: context,
              controller: _firstRequiredProduct,
              hint: "Pilih Produk",
              textInputType: TextInputType.text,
              itemBuilderCallback: _productItemBuilder,
              suggestionCallback: _onProductChanged,
              onSuggestionSelectedCallback: _onFirstRequiredProductSelected),
        ),
        Container(
          child: CustomTextInput.getCustomTextField(
            context: context,
            controller: _firstRequiredMinimum,
            hint: "Jumlah minimum",
            textInputType: TextInputType.number,
          ),
        ),
        Container(
          child: CustomTextInput.getCustomAutoCompleteField(
              context: context,
              controller: _freeProduct,
              hint: "Pilih produk free",
              textInputType: TextInputType.text,
              itemBuilderCallback: _productItemBuilder,
              suggestionCallback: _onProductChanged,
              onSuggestionSelectedCallback: _onFreeProductSelected),
        ),
        Container(
          child: CustomTextInput.getCustomTextField(
              context: context,
              controller: _freeProductSize,
              hint: "Jumlah free",
              textInputType: TextInputType.number),
        )
      ],
    );
  }

  _getCrossProductWidget() {
    return Column(
      children: <Widget>[
        Container(
          child: CustomTextInput.getCustomAutoCompleteField(
              context: context,
              controller: _firstRequiredProduct,
              hint: "Pilih produk pertama",
              textInputType: TextInputType.text,
              itemBuilderCallback: _productItemBuilder,
              suggestionCallback: _onProductChanged,
              onSuggestionSelectedCallback: _onFirstRequiredProductSelected),
        ),
        Container(
          child: CustomTextInput.getCustomTextField(
            context: context,
            controller: _firstRequiredMinimum,
            hint: "Jumlah minimum",
            textInputType: TextInputType.number,
          ),
        ),
        Container(
          child: CustomTextInput.getCustomAutoCompleteField(
              context: context,
              controller: _secondRequiredProduct,
              hint: "Pilih produk kedua",
              textInputType: TextInputType.text,
              itemBuilderCallback: _productItemBuilder,
              suggestionCallback: _onProductChanged,
              onSuggestionSelectedCallback: _onSecondRequiredProductSelected),
        ),
        Container(
          child: CustomTextInput.getCustomTextField(
            context: context,
            controller: _secondRequierdMinimum,
            hint: "Jumlah minimum kedua",
            textInputType: TextInputType.number,
          ),
        ),
        Container(
          child: CustomTextInput.getCustomAutoCompleteField(
              context: context,
              controller: _freeProduct,
              hint: "Pilih produk free",
              textInputType: TextInputType.text,
              itemBuilderCallback: _productItemBuilder,
              suggestionCallback: _onProductChanged,
              onSuggestionSelectedCallback: _onFreeProductSelected),
        ),
        Container(
          child: CustomTextInput.getCustomTextField(
            context: context,
            controller: _freeProductSize,
            hint: "Jumlah free",
            textInputType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  _getMinimumPriceWidget() {
    return Column(
      children: <Widget>[
        Container(
          child: CustomTextInput.getCustomTextField(
            context: context,
            controller: _priceMinimum,
            hint: "Total harga minimum",
            textInputType: TextInputType.number,
          ),
        ),
        Container(
          child: CustomTextInput.getCustomAutoCompleteField(
              context: context,
              controller: _freeProduct,
              hint: "Pilih produk free",
              textInputType: TextInputType.text,
              itemBuilderCallback: _productItemBuilder,
              suggestionCallback: _onProductChanged,
              onSuggestionSelectedCallback: _onFreeProductSelected),
        ),
        Container(
          child: CustomTextInput.getCustomTextField(
            context: context,
            controller: _freeProductSize,
            hint: "Jumlah free",
            textInputType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                decoration: AppTheme.appBackground(),
                child: SingleChildScrollView(
                  child: Container(
                    height: _currentOption ==
                            OPTIONS_DIFFERENT_REQUIRED_WITH_DIFFERENT_FREE
                        ? null
                        : ScreenSizeHelper.getDisplayHeight(
                            context: context,
                            which: ScreenSizeHelper.HEIGHT_WITH_STATUS_BAR),
                    margin: EdgeInsets.only(top: 50.0),
                    padding: EdgeInsets.only(
                        top: 15.0, left: 20, right: 20, bottom: 20),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Tambahkan Promo Baru',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.text_light,
                          ),
                        ),
                        Container(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(top: 15),
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: AppTheme.inputDecoration(),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: _currentOption,
                              items: _promoOptions,
                              onChanged: (value) {
                                setState(() {
                                  _currentOption = value;
                                });
                                _clear();
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(top: 25),
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: AppTheme.inputDecoration(),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: _currentTeam,
                              items: _teams,
                              onChanged: (value) {
                                setState(() {
                                  _currentTeam = value;
                                });
                                _clear();
                              },
                            ),
                          ),
                        ),

                        /*we separate each promo options for each form here*/
                        _currentOption == OPTIONS_SAME_PRODUCT
                            ? _getSameProductWidgets()
                            : _currentOption == OPTIONS_DIFFERENT_PRODUCT
                                ? _getDifferentProductsWidget()
                                : _currentOption ==
                                        OPTIONS_DIFFERENT_REQUIRED_WITH_DIFFERENT_FREE
                                    ? _getCrossProductWidget()
                                    : _currentOption ==
                                            OPTIONS_MINIMUM_TOTAL_PRICE
                                        ? _getMinimumPriceWidget()
                                        : Container(),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Container(
                            width: Dimens.buttonWidthWide(context),
                            child: AspectRatio(
                              aspectRatio: Dimens.buttonRatioWide(),
                              child: RaisedButton(
                                child: Text(
                                  'SELANJUTNYA',
                                  style: TextStyle(
                                    color: AppTheme.text_light,
                                  ),
                                ),
                                shape: AppTheme.roundButton(),
                                color: AppTheme.btn_success,
                                onPressed: () {
                                  var _checkPromo =
                                      _promoController.checkPromoInput(
                                          option: _currentOption,
                                          firstRequired: _selectedFirstProduct,
                                          firstMinimum:
                                              _firstRequiredMinimum.text,
                                          secondRequired:
                                              _selectedSecondProduct,
                                          secondMinimum:
                                              _secondRequierdMinimum.text,
                                          freeItem: _selectedFreeProduct,
                                          freeSize: _freeProductSize.text,
                                          minPrice: _priceMinimum.text);

                                  if (_checkPromo) {
                                    var _promo =
                                        _promoController.generatePromo({
                                      "selectedFirstProducts":
                                          _selectedFirstProduct,
                                      "firstMinimum":
                                          _firstRequiredMinimum.text,
                                      "selectedSecondProducts":
                                          _selectedSecondProduct,
                                      "secondMinimum":
                                          _secondRequierdMinimum.text,
                                      "selectedFree": _selectedFreeProduct,
                                      "freeSize": _freeProductSize.text,
                                      "minimumPrice": _priceMinimum.text
                                    }, _currentOption);

                                    print(_promo);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return SyanaAddPromoMain(
                                              _promo,
                                              (_currentOption + 1).toString(),
                                              _currentTeam.toString());
                                        },
                                      ),
                                    );
                                  } else {
                                    CustomDialog.getDialog(
                                        title: Strings.DIALOG_TITLE_WARNING,
                                        message: Strings
                                            .DIALOG_MESSAGE_INSUFFICENT_PROMO_SETTING,
                                        context: context,
                                        popCount: 1);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
