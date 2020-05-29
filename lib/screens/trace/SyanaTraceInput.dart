import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syana/Controller/CustomerController.dart';
import 'package:syana/Controller/SaleController.dart';
import 'package:syana/models/CustomerModel.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import 'package:syana/utils/Strings.dart';
import 'package:syana/widgets/CustomDialog.dart';
import 'package:syana/widgets/CustomTextInput.dart';
import '../../main.dart';

class SyanaHomeTraceInput extends StatefulWidget {
  DateTime date;
  SyanaHomeTraceInput({this.date});
  @override
  SyanaHomeTraceInputState createState() => SyanaHomeTraceInputState();
}

class SyanaHomeTraceInputState extends State<SyanaHomeTraceInput> {
  int selectedButton = 0;
  TextEditingController _traceController = new TextEditingController(),
      _traceDateController = new TextEditingController();
  SaleController _saleController;
  bool isLoading = false;

  int _currentProducts = 0;
  List<DropdownMenuItem> products = new List();

  DateFormat formatDate = DateFormat("yyyy-MM-dd");
  String _selectedDate = "";

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
    _selectedDate = formatDate.format(widget.date);
    _traceDateController.text = _selectedDate;
    initDataProducts();
  }

  initDataProducts() async {
//    setLoadingState();
    await _saleController.getProductsDropdown(
        context, setLoadingState, setDropdownData);
    print("list length : " + products.length.toString());
//    setLoadingState();
  }

  //Dropdown Filter Teams
  void setDropdownData(data) {
    if (data is List<DropdownMenuItem> && data.isNotEmpty) {
      setState(() {
        products = data;
        _currentProducts = products[0].value;
      });
    }
  }

  void setLoadingState() {
    setState(() {
      isLoading = isLoading ? isLoading = false : isLoading = true;
    });
  }

  void onChangedButton(int value) {
    setState(() {
      this.selectedButton = value;
    });
  }

  save() {
    if (_currentProducts != null &&
        _traceController.text != "" &&
        _traceDateController.text != "") {
      if (_currentProducts == 0) {
        _saleController.sendTrace(
            context, setLoadingState, 0, widget.date, _traceController.text, 2);
      } else {
        _saleController.sendTrace(context, setLoadingState, _currentProducts,
            widget.date, _traceController.text, 1);
      }
    } else {
      CustomDialog.getDialog(
          title: Strings.DIALOG_TITLE_WARNING,
          message: Strings.DIALOG_MESSAGE_INSUFFICENT_INPUT,
          context: context,
          popCount: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[200],
        title: Text("Syana HQ"),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration: AppTheme.appBackground(),
              height: MediaQuery.of(context).size.height,
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                padding:
                    EdgeInsets.only(top: 15.0, left: 20, right: 20, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(left: 10),
                              decoration: AppTheme.inputDecorationShadow(),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Text("Pilih Produk"),
                                  items: products,
                                  isExpanded: true,
                                  value: _currentProducts,
                                  onChanged: (value) async {
                                    setState(() {
                                      _currentProducts = value;
                                    });
                                  },
                                ),
                              )),
                          CustomTextInput.getCustomTextField(
                              context: context,
                              controller: _traceController,
                              hint: "Jejak",
                              textInputType: TextInputType.text),
                          CustomTextInput.getCustomTextField(
                              context: context,
                              controller: _traceDateController,
                              enabled: false,
                              hint: "Tanggal")
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      width: Dimens.buttonWidth(context),
                      child: AspectRatio(
                        aspectRatio: Dimens.buttonRatio(),
                        child: RaisedButton(
                            child: Text(
                              'TAMBAHKAN JEJAK',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppTheme.text_dark,
                              ),
                            ),
                            shape: AppTheme.roundButton(),
                            color: AppTheme.yellow,
                            onPressed: save),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
