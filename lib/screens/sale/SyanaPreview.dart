import 'package:flutter/material.dart';
import 'package:syana/Controller/SaleController.dart';
import 'package:syana/screens/sale/SyanaCustomerInput.dart';
import 'package:syana/screens/sale/SyanaWaitingList.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import 'package:syana/utils/GlobalVars.dart';
import 'package:syana/widgets/CustomTextInput.dart';

class Preview extends StatefulWidget {
  @override
  PreviewState createState() => PreviewState();
}

class PreviewState extends State<Preview> {
  bool isLoading = false;

  SaleController _saleController;
  TextEditingController _airwayBillController;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _saleController = new SaleController();
    if (GlobalVars.airwayBillNumber != "") {
      _airwayBillController =
          new TextEditingController(text: GlobalVars.airwayBillNumber);
    } else {
      _airwayBillController = new TextEditingController();
    }
  }

  @override
  void setLoadingState() {
    setState(() {
      isLoading = isLoading ? isLoading = false : isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: AppTheme.appBackground(),
        height: MediaQuery.of(context).size.height,
        child: Container(
          margin: EdgeInsets.only(top: 50.0),
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "No. Resi",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.white,
                      ),
                    ),
                  ),
                  CustomTextInput.getCustomTextField(
                    context: context,
                    controller: _airwayBillController,
                    textInputType: TextInputType.text,
                    isPasswordField: false,
                    enabled: false,
                    hint: "No. Resi",
                  ),
                  SizedBox(height: 15),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Dimens.buttonWidth(context),
                          child: AspectRatio(
                            aspectRatio: Dimens.buttonRatio(),
                            child: RaisedButton(
                              child: Text('Kembali'),
                              shape: AppTheme.roundButton(),
                              color: AppTheme.btn_default,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: Dimens.buttonWidth(context),
                          child: AspectRatio(
                            aspectRatio: Dimens.buttonRatio(),
                            child: RaisedButton(
                              child: Text('Lanjut'),
                              shape: AppTheme.roundButton(),
                              color: AppTheme.yellow,
                              onPressed: () async {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                                  return CustomerInput(tipe: 2);
                                }));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
