import 'package:flutter/material.dart';
import 'package:syana/Controller/PurchasingController.dart';
import 'package:syana/models/PurchasingModel.dart';
import 'package:syana/screens/Purchasing/ApprovalPurchasing.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import 'package:syana/utils/GlobalVars.dart';
import 'package:syana/widgets/CustomDialog.dart';
import 'package:syana/widgets/CustomImage.dart';

class CreatePurchasingDetail extends StatefulWidget {
  String idPurchasing;

  CreatePurchasingDetail({this.idPurchasing});
  @override
  _CreatePurchasingDetailState createState() => _CreatePurchasingDetailState();
}

class _CreatePurchasingDetailState extends State<CreatePurchasingDetail> {
  bool _isLoading = false;
  PurchasingController _purchasingController;
  PurchasingModel _purchasingModel;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _purchasingController = new PurchasingController();

    _initDataPurchasing();
  }

  _initDataPurchasing() async {
    await _purchasingController.getDetailPurchasingNew(
        context, setLoadingState, setData, widget.idPurchasing);
  }

  setData(data) {
    // TODO: implement setData
    if (data is PurchasingModel && data != null) {
      setState(() {
        _purchasingModel = data;
      });
    }
  }

  void setLoadingState() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[200],
      ),
      body: Container(
        decoration: AppTheme.appBackground(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: _purchasingModel.listDetail.length,
                              itemBuilder: (context, index) {
                                return _listDetail(index);
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: _purchasingModel.listImage.length,
                              itemBuilder: (context, index) {
                                return _listImage(index);
                              },
                            ),
                          ),
                        ],
                      ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 60, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5.0),
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () {
                          _showDialog(1);
                        },
                        color: AppTheme.btn_success,
                        textColor: AppTheme.white,
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 15.0,
                            ),
                            Text(" Approve")
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () {
                          _showDialog(0);
                        },
                        color: AppTheme.red,
                        textColor: AppTheme.white,
                        child: Row(
                          children: [
                            Icon(
                              Icons.dangerous,
                              size: 15.0,
                            ),
                            Text(" Reject")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listDetail(int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.lightGreen[200],
            AppTheme.teal[200],
          ],
        ),
      ),
      height: Dimens.listHeightSmall(context),
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              _purchasingModel.listDetail[index].name ?? "Nama Produk",
              softWrap: true,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: Table(
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: dataTable(
                        "Jumlah",
                        _purchasingModel.listDetail[index].totalItem ?? '-',
                        "Pcs",
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: dataTable(
                        "Harga Item",
                        'Rp',
                        _purchasingModel.listDetail[index].priceItem ?? "-",
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: dataTable(
                        "Total Cost",
                        'Rp',
                        _purchasingModel.listDetail[index].priceTotalItem ??
                            "-",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _listImage(int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Text(
              "Bukti Transaksi " + (index + 1).toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          Container(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: AppTheme.yellow,
              textColor: AppTheme.text_dark,
              onPressed: () async {
                CustomDialog.getDialogWithPicture(
                    "",
                    GlobalVars.baseUrl +
                        "purchasing/" +
                        _purchasingModel.listImage[index].image,
                    context);
              },
              child: Text("Lihat"),
            ),
          ),
        ],
      ),
    );
  }

  Widget dataTable(String title, String subtitle, String desc) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 80,
            alignment: Alignment.topLeft,
            child: Text(
              title,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              ": ",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            child: Expanded(
              child: Row(
                children: <Widget>[
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 3),
                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDialog(int approved) {
    widget.idPurchasing = _purchasingModel.listStatus[0].idPurchasingSubmission;
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 20,
            height: MediaQuery.of(context).size.height * 0.7,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: new BorderRadius.all(Radius.circular(15)),
            ),
            child: ApprovalPurchasing(),
          ),
        );
      },
    );
  }
}
