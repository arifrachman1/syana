import 'package:flutter/material.dart';
import 'package:syana/models/ProductModel.dart';
import 'package:syana/utils/AppTheme.dart';
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

  getPerincian(index, index2) {
    var selectedPerincian = perincian[index];
    return selectedPerincian[index2];
  }

  getTotalPerincianTerjual() {
    int total = 0;
    for (var i = 0; i < perincian.length; i++) {
      var selectedPerincian = perincian[i];
      total = total + (selectedPerincian[1]);
    }
    return total;
  }

  getTotalPerincianFree() {
    int total = 0;
    for (var i = 0; i < perincian.length; i++) {
      var selectedPerincian = perincian[i];
      total = total + (selectedPerincian[2]);
    }
    return total;
  }

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
  void initState() {
    selectedJasa = jasa[0];
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
        child: SingleChildScrollView(
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
                    'IRVAN SEMBARANY',
                    style: TextStyle(
                      color: AppTheme.text_light,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1,
                  height : 50,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                      items: jasa.map(
                        (String val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (String value) {
                        onChangedJasa(value);
                      },
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: CustomTextInput.getCustomTextField(
                      context: context,
                      controller: new TextEditingController(),
                      hint: "No. Resi"),
                ),
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
                    onPressed: () {},
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
