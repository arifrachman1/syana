import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:syana/Controller/SaleController.dart';
import 'package:syana/models/EcommerceModel.dart';
import 'package:syana/screens/sale/SyanaCustomerInput.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import 'package:syana/utils/GlobalVars.dart';
import 'package:syana/widgets/CustomBottomNav.dart';

class SyanaEcommerce extends StatefulWidget {
  @override
  EcommerceState createState() => EcommerceState();
}

class EcommerceState extends State<SyanaEcommerce> {
  SaleController _saleController;
  List<EcommerceModel> ecommerceData = new List();
  List<DropdownMenuItem> ecommerceDropdownMenu = new List();

  int selectedEcommerce;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _saleController = new SaleController();
    _saleController.getEcommerce(context, setLoadingState, setEcommerce);
    if(GlobalVars.selectedEcommerce != 0){
      selectedEcommerce = GlobalVars.selectedEcommerce;
    }
  }

  void setLoadingState() {
    setState(() {
      isLoading = isLoading ? isLoading = false : isLoading = true;
    });
  }

  void onEcommerceChange(value) {
    GlobalVars.selectedEcommerce = value;
    setState(() {
      this.selectedEcommerce = value;
    });
  }

  populateDropdown(data) {
    if (data is List<EcommerceModel> && data != null) {
      data.forEach((element) {
        setState(() {
          ecommerceDropdownMenu.add(new DropdownMenuItem(
            child: Text(element.name),
            value: element.id,
          ));
        });
      });

      if(GlobalVars.selectedEcommerce != 0){
        setState(() {
          selectedEcommerce = GlobalVars.selectedEcommerce;
        });
      }else{
        GlobalVars.selectedEcommerce = data[0].id;
        setState(() {
          selectedEcommerce = data[0].id;
        });
      }
    }
  }

  setEcommerce(ecommerceData) {
    if (ecommerceData is List && ecommerceData.isNotEmpty) {
      setState(() {
        this.ecommerceData = ecommerceData;
      });
      populateDropdown(this.ecommerceData);
    }
  }

  executeManualAirwayBillEntry() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return CustomerInput();
    }));
  }

  executeAutoAirwayBillEntry() async {
    try{
      var result = await BarcodeScanner.scan();
      String airwayBillNumber = result;
      print(airwayBillNumber);

      GlobalVars.clearAirwayBillNumber();
      GlobalVars.airwayBillNumber = airwayBillNumber;

      Navigator.of(context).push(MaterialPageRoute(builder: (_){
        return CustomerInput();
      }));
    }catch (e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNav.getBottomNav(context, 1),
      body: Container(
        decoration: AppTheme.appBackground(),
        height: MediaQuery.of(context).size.height,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                margin: EdgeInsets.only(top: 50.0),
                padding:
                    EdgeInsets.only(top: 15.0, left: 20, right: 20, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            decoration: AppTheme.inputDecoration(),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: selectedEcommerce,
                                items: ecommerceDropdownMenu,
                                onChanged: onEcommerceChange
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Pilih metode input Resi',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: AppTheme.text_light,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: Dimens.buttonWidth(context),
                            child: AspectRatio(
                              aspectRatio: Dimens.buttonRatio(),
                              child: RaisedButton(
                                child: Text(
                                  'MANUAL',
                                ),
                                shape: AppTheme.roundButton(),
                                color: AppTheme.btn_default,
                                onPressed: executeManualAirwayBillEntry
                              ),
                            ),
                          ),
                          Container(
                            width: Dimens.buttonWidth(context),
                            child: AspectRatio(
                              aspectRatio: Dimens.buttonRatio(),
                              child: RaisedButton(
                                child: Text(
                                  'OTOMATIS',
                                  style: TextStyle(
                                    color: AppTheme.text_light,
                                  ),
                                ),
                                shape: AppTheme.roundButton(),
                                color: AppTheme.btn_success,
                                onPressed: executeAutoAirwayBillEntry
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
}
