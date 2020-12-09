import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:syana/Controller/HomePackingController.dart';
import 'package:syana/models/SaleModel.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/FontHelper.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/widgets/CustomDialog.dart';

class PackingDetail extends StatefulWidget {
  SaleModel data;

  PackingDetail(this.data);

  _PackingDetailState createState() => _PackingDetailState();
}

class _PackingDetailState extends State<PackingDetail> {
  double totalWeight = 0;
  HomePackingController _homePackingController;
  bool _isLoading = false;

  ScrollController _scrollcontroller = ScrollController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _homePackingController = new HomePackingController();
    _initData();
  }

  /*calculate weight*/
  _initData() {
    widget.data.saleDetails.forEach((element) {
      int totalItem =
          int.parse(element.saleNumber) + int.parse(element.freeNumber);
      double itemWeight = double.parse(element.weight.toString()) *
          double.parse(totalItem.toString());
      setState(() {
        totalWeight += itemWeight;
      });
    });
  }

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

  void scan(int index) async {
    try {
      var result = await BarcodeScanner.scan();
      String scan = result;
      GlobalFunctions.log(message: scan, name: "packing");
      if (scan == widget.data.saleDetails[index].sku) {
        setState(() {
          widget.data.saleDetails[index].currentSaleNum++;
        });
      } else {
        CustomDialog.getDialog(
            title: "Perhatian",
            message: "Barcode tidak cocok.",
            context: context,
            popCount: 1);
      }
    } catch (e) {
      print(e);
    }
  }

  bool checkSaleNumber() {
    bool isTrue = true;
    int grandTotal;
    widget.data.saleDetails.forEach((element) {
      grandTotal =
          int.parse(element.saleNumber) + int.parse(element.freeNumber);
      if (element.currentSaleNum != grandTotal) {
        isTrue = false;
      }
    });
    return isTrue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[200],
        title: Text("Detail Penjualan"),
      ),
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: AppTheme.appBackground(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                "Transaksi",
                style: FontHelper.textTitle,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                "Nama Sales : "+widget.data.salesName.toString(),
                style: FontHelper.textSuccess,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Divider(
                height: 1,
                color: AppTheme.white,
                indent: 15,
                endIndent: 15,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      "No",
                      style: FontHelper.bodyBold,
                    ),
                  ),
                  Container(
                    child: Text(
                      "Nama dan SKU",
                      style: FontHelper.bodyBold,
                    ),
                  ),
                  Container(
                    child: Text(
                      "Jumlah",
                      style: FontHelper.bodyBold,
                    ),
                  ),
                  Container(
                    child: Text(
                      "Berat Produk",
                      style: FontHelper.bodyBold,
                    ),
                  ),
                  Container(
                    child: Text(
                      "Scan Produk",
                      style: FontHelper.bodyBold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                // height: 200,
                child: Scrollbar(
              isAlwaysShown: true,
              controller: _scrollcontroller,
              thickness: 8,
              child: ListView.builder(
                  itemCount: widget.data.saleDetails.length,
                  itemBuilder: (_, index) {
                    int totalItem =
                        int.parse(widget.data.saleDetails[index].saleNumber);
                    int freeItem =
                        int.parse(widget.data.saleDetails[index].freeNumber);
                    int grandTotal = totalItem + freeItem;
                    double totalWeightItem =
                        double.parse(widget.data.saleDetails[index].weight) *
                            grandTotal;
                    return Container(
                      margin: EdgeInsets.only(left: 10, right: 20, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            (index + 1).toString() + ".",
                            style: FontHelper.body,
                          ),
                          Container(
                            child: Text(
                              widget.data.saleDetails[index].productName +
                                  "\n" +
                                  widget.data.saleDetails[index].sku,
                              style: FontHelper.body,
                            ),
                            width: 100,
                          ),
                          Text(
                            widget.data.saleDetails[index].currentSaleNum
                                    .toString() +
                                "/" +
                                grandTotal.toString(),
                            style: widget.data.saleDetails[index].currentSaleNum
                                        .toString() !=
                                    grandTotal.toString()
                                ? FontHelper.textError
                                : FontHelper.textSuccess,
                          ),
                          Text(
                            totalWeightItem.toString(),
                            style: FontHelper.body,
                          ),
                          IconButton(
                              iconSize: 50,
                              icon: Icon(
                                Icons.camera_alt,
                                color: widget.data.saleDetails[index]
                                            .currentSaleNum
                                            .toString() !=
                                        grandTotal.toString()
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                              onPressed: widget.data.saleDetails[index]
                                          .currentSaleNum
                                          .toString() !=
                                      grandTotal.toString()
                                  ? () {
                                      scan(index);
                                    }
                                  : null)
                        ],
                      ),
                    );
                  }),
            )),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Total Berat",
                    style: FontHelper.bodyBold,
                  ),
                  Text(
                    totalWeight.toString(),
                    style: FontHelper.bodyBold,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: RaisedButton(
                shape: StadiumBorder(),
                color: AppTheme.yellow,
                onPressed: checkSaleNumber()
                    ? () async {
                        _homePackingController.accPackingSale(
                            context, setLoadingState, widget.data.id);
                      }
                    : null,
                child: Text("PACKING"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
