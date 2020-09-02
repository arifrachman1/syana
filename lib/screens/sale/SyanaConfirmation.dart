import 'package:flutter/material.dart';
import 'package:syana/Controller/SaleController.dart';
import 'package:syana/models/ProductModel.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/GlobalVars.dart';
import 'package:syana/widgets/CustomTextInput.dart';
import '../../main.dart';

class Confirmation extends StatefulWidget {
  List<ProductModel> selectedProducts;
  int totalSale, totalFree;

  Confirmation(this.selectedProducts, this.totalSale, this.totalFree);

  @override
  ConfirmationState createState() => ConfirmationState();
}

class ConfirmationState extends State<Confirmation> {
  List<List> perincian = [
    ['(Better) Botanical Slimming Massage Oil', 1, 0],
    ['(Hotter) Botanical Slimming Massage Oil Carolina', 2, 0],
    ['(Kelapa) Evco Casa Di Sana', 1, 0],
    ['(Natuna) Tea Tree Essential', 3, 0],
    ['(Zaitun) Evco Casa Di Sana', 2, 0],
    ['(Zaitun) Evco Casa Di Sana', 2, 0],
    ['(Zaitun) Evco Casa Di Sana', 2, 0],
  ];

  List<DropdownMenuItem> _courierDropdownItems = new List();
  TextEditingController _airwayBilLController;

  SaleController _saleController;
  bool isLoading = false;
  int _currentCourier = 0;

  // *
  // *
  // komponen dropdown jasa pengiriman
  // ========================

  List<String> jasa = ['J&T Express', 'JNE Reguler'];

  String selectedJasa = 'not-set';

  void onChangedJasa(String value) {
    setState(() {
      selectedJasa = value;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    selectedJasa = jasa[0];
    _saleController = new SaleController();
    if (GlobalVars.airwayBillNumber != "") {
      _airwayBilLController = new TextEditingController(text: GlobalVars.airwayBillNumber);
    } else {
      _airwayBilLController = new TextEditingController();
    }

    _saleController.getCourier(context, setLoadingState, setDropdownData);
  }

  void setLoadingState() {
    setState(() {
      isLoading = isLoading ? isLoading = false : isLoading = true;
    });
  }

  void setDropdownData(List dropdownData) {
    if (dropdownData.isNotEmpty) {
      setState(() {
        _courierDropdownItems = dropdownData;
        _currentCourier = _courierDropdownItems[0].value;
      });
      print(_courierDropdownItems.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[200],
        title: Text('Perincian'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: AppTheme.appBackground(),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: AppTheme.listBackground(),
                        child: Text(
                          GlobalVars.customerFullName ?? 'Nama Customer',
                          style: TextStyle(
                            color: AppTheme.text_light,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1,
                        height: 50,
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: AppTheme.inputDecoration(),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            iconEnabledColor: AppTheme.text_darker,
                            hint: Text(
                              'Pilih Jasa Pengiriman',
                              style: TextStyle(
                                color: AppTheme.text_darker,
                                fontSize: 12,
                              ),
                            ),
                            items: _courierDropdownItems,
                            value: _currentCourier,
                            onChanged: (value) {
                              setState(() {
                                _currentCourier = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      CustomTextInput.getCustomTextField(
                          context: context,
                          controller: _airwayBilLController,
                          textInputType: TextInputType.text,
                          isPasswordField: false,
                          hint: "No. Resi"),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(),
                            ),
                            Container(
                              width: 70,
                              child: Text(
                                'Jual',
                                style: TextStyle(
                                  color: AppTheme.text_light,
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: 70,
                              child: Text(
                                'Free',
                                style: TextStyle(
                                  color: AppTheme.text_light,
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 25,
                      ),
                      Container(
                        height: 400,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.selectedProducts.length,
                          itemBuilder: (BuildContext contex, int index) {
                            return Container(
                              alignment: Alignment.topCenter,
                              height: 100,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        widget.selectedProducts[index].name,
                                        style: TextStyle(
                                          color: AppTheme.text_light,
                                          fontSize: 13,
                                        ),
                                        softWrap: true,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    child: Text(
                                      widget.selectedProducts[index].saleNumber,
                                      style: TextStyle(
                                        color: AppTheme.text_light,
                                        fontSize: 13,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    child: Text(
                                      widget.selectedProducts[index].freeNumber,
                                      style: TextStyle(
                                        color: AppTheme.text_light,
                                        fontSize: 13,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Divider(thickness: 1),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Text(
                                  'Total',
                                  style: TextStyle(
                                    color: AppTheme.text_light,
                                    fontSize: 13,
                                  ),
                                  softWrap: true,
                                ),
                              ),
                            ),
                            Container(
                              width: 70,
                              child: Text(
                                widget.totalSale.toString(),
                                style: TextStyle(
                                  color: AppTheme.text_light,
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center,
                                softWrap: true,
                              ),
                            ),
                            Container(
                              width: 70,
                              child: Text(
                                widget.totalFree.toString(),
                                style: TextStyle(
                                  color: AppTheme.text_light,
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center,
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: RaisedButton(
                          child: Text('Simpan'),
                          shape: AppTheme.roundButton(),
                          color: AppTheme.yellow,
                          onPressed: () => _saleController.setSale(
                              context,
                              setLoadingState,
                              _airwayBilLController.text,
                              _currentCourier.toString(),
                              widget.selectedProducts),
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
