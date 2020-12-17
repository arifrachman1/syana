import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syana/Controller/PurchasingController.dart';
import 'package:syana/models/PurchasingModel.dart';
import 'package:syana/utils/AppTheme.dart';

class ApprovalPurchasing extends StatefulWidget {
  String idPurchasing;
  int approved;
  final int tipe;

  ApprovalPurchasing({this.idPurchasing, this.approved, this.tipe});

  @override
  _ApprovalPurchasingState createState() => _ApprovalPurchasingState();
}

class _ApprovalPurchasingState extends State<ApprovalPurchasing> {
  bool _isLoading = false;

  PurchasingController _purchasingController;
  TextEditingController _komentarController;

  @override
  void initState() {
    super.initState();
    _purchasingController = new PurchasingController();
  }

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 5),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(right: 5),
              child: Container(
                child: IconButton(
                  iconSize: 25,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                ),
              ),
            ),
            widget.approved == 1 ? headerRevision() : headerDecline(),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: AppTheme.orange_light,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 5)
                    ]),
                child: TextField(
                  controller: _komentarController,
                  maxLines: 8,
                  style: TextStyle(
                    color: AppTheme.text_dark,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Tulis komentar',
                    hintStyle: TextStyle(
                      color: AppTheme.text_dark,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              padding: EdgeInsets.all(0),
              child: RaisedButton(
                  onPressed: () async {
                    var result =
                        await _purchasingController.setApprovalPurchasing(
                            context,
                            setLoadingState,
                            _komentarController,
                            widget.idPurchasing,
                            widget.approved,
                            widget.tipe);

                    log(result.toString());
                  },
                  color: AppTheme.btn_success,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Container(
                    width: 90,
                    padding: EdgeInsets.only(top: 4, bottom: 4),
                    child: Text(
                      'Kirim',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerApprove() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 5, right: 5, bottom: 0),
            child: Text(
              "Terima Kasih",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppTheme.text_dark,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5, right: 5, bottom: 20),
            child: Text(
              "Anda telah melakukan persetujuan",
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5, right: 5, bottom: 0),
            child: Text(
              "Tulis Komentar",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppTheme.text_dark, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: Text(
              "Anda telah menyetujui pengajuan ini. Mohon tulis komentar dan pesan",
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
          ),
        ],
      ),
    );
  }

  Widget headerDecline() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 5, right: 5, bottom: 20),
            child: Text(
              "Anda telah menolak pengajuan ini",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppTheme.text_dark,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: Text(
              "Mohon tulis alasan anda menolak pengajuan ini",
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
          ),
        ],
      ),
    );
  }

  Widget headerRevision() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 5, right: 5, bottom: 20),
            child: Text(
              "Anda telah merevisi pengajuan ini",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppTheme.text_dark,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: Text(
              "Mohon tulis alasan anda merevisi pengajuan ini",
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
          ),
        ],
      ),
    );
  }
}
