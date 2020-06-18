import 'package:flutter/material.dart';
import 'package:syana/models/SaleModel.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/FontHelper.dart';

class PackingDetail extends StatefulWidget {
  SaleModel data;

  PackingDetail(this.data);

  _PackingDetailState createState() => _PackingDetailState();
}

class _PackingDetailState extends State<PackingDetail> {
  double totalWeight = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              ],
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                  itemCount: widget.data.saleDetails.length,
                  itemBuilder: (_, index) {
                    return Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            widget.data.saleDetails[index].saleNumber,
                            style: FontHelper.body,
                          ),
                          Text(
                            widget.data.saleDetails[index].weight,
                            style: FontHelper.body,
                          )
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
            )
          ],
        ),
      ),
    );
  }
}
