import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:syana/Controller/HomePackingController.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/utils/GlobalVars.dart';
import 'package:syana/widgets/CustomButton.dart';

class SyanaHomePacking extends StatefulWidget {
  _PackingState createState() => _PackingState();
}

class _PackingState extends State<SyanaHomePacking> {
  HomePackingController _homePackingController;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _homePackingController = new HomePackingController();
  }

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

  void logout() {
    _homePackingController.logout(context);
  }

  scan() async {
    try {
      var result = await BarcodeScanner.scan();
      String airwayBillNumber = result;
      GlobalFunctions.log(message: airwayBillNumber, name: "home_packing");

      _homePackingController.getSalesByAirwayBillNumber(context, airwayBillNumber, setLoadingState);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: AppTheme.appBackground(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GlobalVars.isDevMode
                ? Container(
              child: IconButton(
                onPressed: logout,
                icon: Icon(Icons.exit_to_app),
                color: Colors.white,
              ),
            )
                : Container(),
            Container(
              alignment: Alignment.center,
              child: Text("Selamat datang, Username", style: TextStyle(color: AppTheme.white),),
            ),
            Container(
              child: CustomButton.getCustomButton(
                  context: context,
                  callbackFunction: scan,
                  buttonText: "Pindai Barcode"),
            )
          ],
        ),
      )
    );
  }
}
