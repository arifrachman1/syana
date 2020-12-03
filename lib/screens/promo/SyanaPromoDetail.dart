import 'package:flutter/material.dart';
import 'package:syana/Controller/PromoController.dart';
import 'package:syana/models/PromoDetailInModel.dart';
import 'package:syana/models/PromoDetailOutModel.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/GlobalFunctions.dart';

class SyanaPromoDetail extends StatefulWidget {
  String promoId;

  SyanaPromoDetail(this.promoId);

  _DetailState createState() => _DetailState();
}

class _DetailState extends State<SyanaPromoDetail> {
  List<PromoDetailInModel> _promoRequirements = new List();
  List<PromoDetailOutModel> _promoFreeItems = new List();

  final String _devTitle = "promo_detail";

  PromoController _promoController;

  bool _isLoading = false;

  Map _promoDetails = new Map();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _promoController = new PromoController();
    _initData();
  }

  _initData() async {
    await _promoController.getPromoDetail(
        context, setLoadingState, setData, widget.promoId);
  }

  _assignPromo() {
    setState(() {
      _promoRequirements = _promoDetails['detailIn'];
      _promoFreeItems = _promoDetails['detailOut'];
    });

    GlobalFunctions.log(message: "assign initialized...", name: "check_detail");

    GlobalFunctions.log(
        message: "in : " + _promoRequirements.toString(),
        name: "check_detail");

    GlobalFunctions.log(
        message: "out : " + _promoFreeItems.toString(),
        name: "check_detail");
  }

  setData(data) async {
    if (data is Map) {
      setState(() {
        _promoDetails = data;
      });

      await _assignPromo();
    }
  }

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[200],
        title: Text('Detail Promo'),
      ),
      body: Container(
        decoration: AppTheme.appBackground(),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : LayoutBuilder(
                builder: (context, BoxConstraints constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 32),
                            child: Text(
                              "Judul Promo : " +
                                  (_promoDetails['promoTitle'] ??
                                      "Judul Promo"),
                              style: TextStyle(
                                fontSize: 20,
                                color: AppTheme.text_light,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 32),
                            child: Text(
                              "Tipe Promo : " +
                                  (_promoDetails['type'] ?? "Tipe Promo"),
                              style: TextStyle(
                                fontSize: 20,
                                color: AppTheme.text_light,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 32),
                            child: Text(
                              "Jangka Waktu Berlaku Promo : " +
                                  (_promoDetails != null
                                      ? (_promoDetails['startDate'] != null
                                          ? (_promoDetails['startDate'] +
                                              " - " +
                                              _promoDetails['endDate'])
                                          : "Berlaku Selamanya")
                                      : "Tanggal Berlaku Promo"),
                              style: TextStyle(
                                fontSize: 20,
                                color: AppTheme.text_light,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  "Syarat",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppTheme.text_light,
                                  ),
                                ),
                                Text(
                                  "Produk Free",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppTheme.text_light,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 32),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  SizedBox(
                                    width: constraints.maxWidth * 0.4,
                                    height: constraints.maxHeight * 0.35,
                                    child: ListView.builder(
                                        itemCount: _promoRequirements.length,
                                        itemBuilder: (_, index) {
                                          return Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 32),
                                            child: Text(
                                              (_promoRequirements[index]
                                                          .productname
                                                          .toString() ??
                                                      "Item 1") +
                                                  " sebanyak " +
                                                  (_promoRequirements[index]
                                                      .amountRequired
                                                      .toString()),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: AppTheme.text_light,
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  SizedBox(
                                    width: constraints.maxWidth * 0.4,
                                    height: constraints.maxHeight * 0.35,
                                    child: ListView.builder(
                                        itemCount: _promoFreeItems.length,
                                        itemBuilder: (_, index) {
                                          return Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 32),
                                            child: Text(
                                              (_promoFreeItems[index]
                                                          .productName
                                                          .toString() ??
                                                      "Item Free 1") +
                                                  " sebanyak " +
                                                  (_promoFreeItems[index]
                                                      .amountFree
                                                      .toString()),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: AppTheme.text_light,
                                              ),
                                            ),
                                          );
                                        }),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
