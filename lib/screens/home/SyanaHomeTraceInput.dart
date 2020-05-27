import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syana/Controller/CustomerController.dart';
import 'package:syana/models/CustomerModel.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import 'package:syana/utils/Strings.dart';
import 'package:syana/widgets/CustomDialog.dart';
import 'package:syana/widgets/CustomTextInput.dart';
import '../../main.dart';

class SyanaHomeTraceInput extends StatefulWidget {
  @override
  SyanaHomeTraceInputState createState() => SyanaHomeTraceInputState();
}

class SyanaHomeTraceInputState extends State<SyanaHomeTraceInput> {
  int selectedButton = 0;
  TextEditingController _traceController = new TextEditingController(),
      _traceDateController = new TextEditingController();
  CustomerController _customerController;
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _customerController = new CustomerController();
  }

  void setLoadingState() {
    setState(() {
      isLoading = isLoading ? isLoading = false : isLoading = true;
    });
  }

  void onChangedButton(int value) {
    setState(() {
      this.selectedButton = value;
    });
  }


//  save() {
//    if (_traceController.text != "" &&
//        _traceDateController.text != "") {
//      _customerController.saveCustomer(
//          context,
//          setLoadingState,
//          _phoneNumberController.text,
//          _nameController.text);
//    } else {
//      CustomDialog.getDialog(
//          title: Strings.DIALOG_TITLE_WARNING,
//          message: Strings.DIALOG_MESSAGE_INSUFFICENT_INPUT,
//          context: context,
//          popCount: 1);
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.appBackground(),
        height: MediaQuery.of(context).size.height,
        child: Container(
          margin: EdgeInsets.only(top: 50.0),
          padding: EdgeInsets.only(top: 15.0, left: 20, right: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Masukkan data pelanggan',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.text_light,
                  ),
                ),
              ),
              Container(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Column(
                  children: <Widget>[
                    CustomTextInput.getCustomTextField(
                        context: context,
                        controller: _traceController,
                        hint: "Jejak",
                        textInputType: TextInputType.text),
                    CustomTextInput.getCustomTextField(
                        context: context,
                        controller: _traceDateController,
                        textInputType: TextInputType.number,
                        hint: "Tanggal")
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                width: Dimens.buttonWidth(context),
                child: AspectRatio(
                  aspectRatio: Dimens.buttonRatio(),
                  child: RaisedButton(
                      child: Text(
                        'TAMBAHKAN JEJAK',
                        style: TextStyle(
                          color: AppTheme.text_dark,
                        ),
                      ),
                      shape: AppTheme.roundButton(),
                      color: AppTheme.yellow,
                      onPressed: (){}),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
