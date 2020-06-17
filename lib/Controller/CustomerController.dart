import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syana/models/CustomerModel.dart';
import 'package:syana/models/TransactionHistoryModel.dart';
import 'package:syana/models/UserModel.dart';
import 'package:syana/screens/sale/SyanaSale.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/utils/GlobalVars.dart';
import 'package:syana/utils/Strings.dart';
import 'package:syana/widgets/CustomDialog.dart';

import 'dart:developer' as dev;

class CustomerController {
  UserModel _userModel;

  CustomerController() {
    _getPersistence();
  }

  _getPersistence() async {
    _userModel = await GlobalFunctions.getPersistence();
  }

  Future<List> getCustomerData(context, phoneNumber) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params =
        GlobalFunctions.generateMapParam(["phone_number"], [phoneNumber]);

    final data = await GlobalFunctions.dioGetCall(
        context: context,
        path: GlobalVars.apiUrl + "get-customer-by-phone-number",
        params: params);

    if (data != null) {
      print(data);
      if (data['status'] == 1) {
        List _customerSuggestionFromApi = data['customer'];
        List<CustomerModel> customerSuggestions = new List();
        _customerSuggestionFromApi.forEach((element) {
          customerSuggestions.add(new CustomerModel.customerSuggestions(
              element['id'],
              element['full_name'],
              element['phone_number'],
              element['zip_code']));
        });

        return customerSuggestions;
      }
    }
  }

  Future<List> getZipCode(context, zipCode) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params = GlobalFunctions.generateMapParam(["zip_code"], [zipCode]);

    final data = await GlobalFunctions.dioGetCall(
        context: context,
        path: GlobalVars.apiUrl + "get-zip-code",
        params: params);

    if (data != null) {
      print(data);
      if (data['status'] == 1) {
        List _zipCodeFromApi = data['zip_codes'];
        List<CustomerModel> zipCodeSuggestions = new List();

        _zipCodeFromApi.forEach((element) {
          zipCodeSuggestions.add(new CustomerModel.zipCode(
              element['city'], element['province'], element['zip_code']));
        });

        return zipCodeSuggestions;
      }
    }
  }

  saveCustomer(
      context, loadingStateCallback, phoneNumber, fullName, zipCode) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params = GlobalFunctions.generateMapParam([
      "name",
      "phone_number",
      "zip_code",
      "id_ecommerce",
      "id_employee"
    ], [
      fullName,
      phoneNumber,
      zipCode,
      GlobalVars.selectedEcommerce.toString(),
      _userModel.id
    ]);

    FormData formData = FormData.fromMap(params);

    final data = await GlobalFunctions.dioPostCall(
        context: context,
        path: GlobalVars.apiUrl + "create-customer",
        params: formData);

    print(GlobalVars.apiUrl + "create-customer");
    print(params);

    if (data != null) {
      if (data['status'] == 1) {
        GlobalVars.customerId = data['id_customer'].toString();
        GlobalVars.customerFullName = fullName;
        /*CustomDialog.getDialog(
            title: Strings.DIALOG_TITLE_SUCCESS,
            message: Strings.DIALOG_MESSAGE_CUSTOMER_SAVED,
            context: context,
            popCount: 1);*/

        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return Sale();
        }));
      }
    }
  }

  /*get data customer*/
  getDataCustomer(
      context, loadingStateCallback, setDataCallback, customerId) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params =
        GlobalFunctions.generateMapParam(["customer_id"], [customerId]);

    final data = await GlobalFunctions.dioGetCall(
        path: GlobalVars.apiUrl + "get-customer-detail",
        context: context,
        params: params);

    if (data != null) {
      if (data['status'] == 1) {
        CustomerModel detailCustomer = new CustomerModel.full(
            data['customer']['id'],
            data['customer']['full_name'],
            data['customer']['nickname'],
            data['customer']['phone_number'],
            data['customer']['address'],
            data['customer']['city'],
            data['customer']['province'],
            data['customer']['zip_code'],
            data['customer']['id_ecommerce'],
            data['customer']['date_time_created'],
            data['customer']['date_time_modified'],
            data['customer']['id_employee'],
            data['customer']['id_employee_team'],
            data['customer']['name_ecommerce']);

        dev.log(detailCustomer.toString(), name: "CustomerController");
        setDataCallback(detailCustomer);
      }
    } else {}
  }

  /*get history*/
  getHistoryCustomer(
      context, loadingStateCallback, setDataCallback, idCustomer) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params =
        GlobalFunctions.generateMapParam(["id_customer"], [idCustomer]);

    final data = await GlobalFunctions.dioGetCall(
        path: GlobalVars.apiUrl + "get-history-sales",
        context: context,
        params: params);

    if (data != null) {
      if (data['status'] == 1) {
        List historiesFromApi = data['history'];
        List<TransactionHistoryModel> historiesProduct = new List();

        historiesFromApi.forEach((element) {
          historiesProduct.add(new TransactionHistoryModel.getHistoryCustomer(
              element['transaction_number'], element['datetime_created']));
        });

        if (historiesProduct.isNotEmpty) {
          setDataCallback(historiesProduct);
        }
      }
    } else {}
  }
}
