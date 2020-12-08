import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:syana/Controller/HomePackingController.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/utils/GlobalVars.dart';
import 'package:syana/widgets/CustomButton.dart';
import 'package:syana/widgets/CustomDialog.dart';

class SyanaHomePacking extends StatefulWidget {
  _PackingState createState() => _PackingState();
}

class _PackingState extends State<SyanaHomePacking> {
  HomePackingController _homePackingController;
  bool _isLoading = false;
  TextEditingController _noResi = new TextEditingController();

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
    _homePackingController.logout(context, setLoadingState);
  }

  scan() async {
    try {
      var result = await BarcodeScanner.scan();
      String airwayBillNumber = result;
      GlobalFunctions.log(message: airwayBillNumber, name: "home_packing");

      _homePackingController.getSalesByAirwayBillNumber(
          context, airwayBillNumber, setLoadingState);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                child: Text(
                  "Selamat datang, Username",
                  style: TextStyle(color: AppTheme.white),
                ),
              ),
              Container(
                child: CustomButton.getCustomButton(
                    context: context,
                    callbackFunction: scan,
                    buttonText: "Pindai Barcode"),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: RaisedButton(
                  onPressed: () {
                    buildDialog();
                  },
                  color: AppTheme.text_light,
                  shape: AppTheme.roundButton(),
                  child: Text("Input Manual"),
                ),
              )
            ],
          ),
        ));
  }

  buildDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _noResi,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7)),
                        labelText: "Input No. Resi",
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: CustomButton.getCustomButton(
                          context: context,
                          callbackFunction: () {
                            if (_noResi.text != "") {
                              _homePackingController.getSalesByAirwayBillNumber(
                                  context, _noResi.text, setLoadingState);
                              setState(() {
                                _noResi.clear();
                              });
                            } else {
                              CustomDialog.getDialog(
                                  title: "Perhatian",
                                  message:
                                      "Harap input No. Resi terlebih dahulu",
                                  context: context,
                                  popCount: 1);
                            }
                          },
                          buttonText: "Submit"),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
