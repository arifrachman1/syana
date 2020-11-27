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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homePackingController = new HomePackingController();
    _initData();
  }

  /*calculate weight*/
  _initData() {
    widget.data.saleDetails.forEach((element) {
      double itemWeight = double.parse(element.weight.toString());
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
      if (scan == widget.data.saleDetails[index].idProduct) {
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
    widget.data.saleDetails.forEach((element) {
      if (element.currentSaleNum != int.parse(element.saleNumber)) {
        isTrue = false;
      }
    });
    return isTrue;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
              child: Text(
                "Transaksi",
                style: FontHelper.textTitle,
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
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
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
            SizedBox(
              height: 200,
              child: ListView.builder(
                  itemCount: widget.data.saleDetails.length,
                  itemBuilder: (_, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text(
                              widget.data.saleDetails[index].productName +
                                  "\n" +
                                  widget.data.saleDetails[index].sku,
                              style: FontHelper.body,
                            ),
                            width: 110,
                          ),
                          Text(
                            widget.data.saleDetails[index].currentSaleNum
                                    .toString() +
                                "/" +
                                widget.data.saleDetails[index].saleNumber,
                            style: widget.data.saleDetails[index].currentSaleNum
                                        .toString() !=
                                    widget.data.saleDetails[index].saleNumber
                                ? FontHelper.textError
                                : FontHelper.textSuccess,
                          ),
                          Text(
                            widget.data.saleDetails[index].weight,
                            style: FontHelper.body,
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.qr_code_scanner,
                                color: widget.data.saleDetails[index]
                                            .currentSaleNum
                                            .toString() !=
                                        widget
                                            .data.saleDetails[index].saleNumber
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                              onPressed: widget.data.saleDetails[index]
                                          .currentSaleNum
                                          .toString() !=
                                      widget.data.saleDetails[index].saleNumber
                                  ? () {
                                      scan(index);
                                    }
                                  : null)
                        ],
                      ),
                    );
                  }),
            ),
            Row(
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
            checkSaleNumber()
                ? Container(
              margin: EdgeInsets.only(top: 20),
                    child: RaisedButton(
                      shape: StadiumBorder(),
                      color: AppTheme.yellow,
                      onPressed: () async {
                        _homePackingController.accPackingSale(
                            context, setLoadingState, widget.data.id);
                      },
                      child: Text("PACKING"),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
