import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syana/Controller/CustomerController.dart';
import 'package:syana/models/CustomerModel.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import 'package:syana/utils/Strings.dart';
import 'package:syana/widgets/CustomDialog.dart';
import 'package:syana/widgets/CustomTextInput.dart';

class CustomerInput extends StatefulWidget {
  @override
  CustomerInputState createState() => CustomerInputState();
}

class CustomerInputState extends State<CustomerInput> {
  int selectedButton = 0;
  TextEditingController _phoneNumberController = new TextEditingController(),
      _nameController = new TextEditingController(),
      _zipCodeController = new TextEditingController();
  List<CustomerModel> customerSuggestions = new List();
  CustomerController _customerController;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _customerController = new CustomerController();
  }

  void setLoadingState() {
    setState(() {
      isLoading = isLoading ? isLoading = false : isLoading = true;
    });
  }

  setSuggestion(data) {
    if (data is List<CustomerModel> && data.isNotEmpty) {
      setState(() {
        print("suggestion updated!");
        customerSuggestions = data;
      });
    }
  }

  void onChangedButton(int value) {
    setState(() {
      this.selectedButton = value;
    });
  }

  FutureOr<Iterable<dynamic>> onPhoneNumberChanged(pattern) async {
    if (pattern.toString().length > 8) {
      return await _customerController.getCustomerData(context, pattern);
    }
  }

  FutureOr<Iterable<dynamic>> onZipCodeChanged(pattern) async {
    if (pattern.toString().length > 3) {
      return await _customerController.getZipCode(context, pattern);
    }
  }

  onPhoneNumberSelected(suggestion) {
    print(suggestion);
    if (suggestion is CustomerModel) {
      setState(() {
        _phoneNumberController.text = suggestion.phoneNumber;
        _nameController.text = suggestion.fullName;
        _zipCodeController.text = suggestion.zipCode;
      });
    }
  }

  onZipCodeSelected(suggestion) {
    print(suggestion);
    if (suggestion is CustomerModel) {
      setState(() {
        _zipCodeController.text = suggestion.zipCode;
      });
    }
  }

  save() {
    if (_phoneNumberController.text != "" &&
        _nameController.text != "" &&
        _zipCodeController.text != "") {
      _customerController.saveCustomer(
          context,
          setLoadingState,
          _phoneNumberController.text,
          _nameController.text,
          _zipCodeController.text);
    } else {
      CustomDialog.getDialog(
          title: Strings.DIALOG_TITLE_WARNING,
          message: Strings.DIALOG_MESSAGE_INSUFFICENT_INPUT,
          context: context,
          popCount: 1);
    }
  }

  Widget customerItemBuilder(context, item) {
    return ListTile(
      title: Text(item.phoneNumber),
      subtitle: Text(item.fullName),
    );
  }

  Widget zipCodeItemBuilder(context, item) {
    return ListTile(
      title: Text(item.zipCode),
    );
  }

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
                    CustomTextInput.getCustomAutoCompleteField(
                        controller: _phoneNumberController,
                        context: context,
                        textInputType: TextInputType.phone,
                        hint: "Nomor Telepon",
                        itemBuilderCallback: customerItemBuilder,
                        suggestionCallback: onPhoneNumberChanged,
                        onSuggestionSelectedCallback: onPhoneNumberSelected),
                    CustomTextInput.getCustomTextField(
                        context: context,
                        controller: _nameController,
                        hint: "Nama Pelanggan",
                        textInputType: TextInputType.text),
                    CustomTextInput.getCustomAutoCompleteField(
                        context: context,
                        controller: _zipCodeController,
                        textInputType: TextInputType.number,
                        hint: "Kode Pos",
                        suggestionCallback: onZipCodeChanged,
                        onSuggestionSelectedCallback: onZipCodeSelected,
                        itemBuilderCallback: zipCodeItemBuilder)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: Dimens.buttonWidth(context),
                      child: AspectRatio(
                        aspectRatio: Dimens.buttonRatio(),
                        child: RaisedButton(
                          child: Text(
                            'KEMBALI',
                          ),
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
                          child: Text(
                            'SIMPAN',
                            style: TextStyle(
                              color: AppTheme.text_light,
                            ),
                          ),
                          shape: AppTheme.roundButton(),
                          color: AppTheme.btn_success,
                          onPressed: save
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
