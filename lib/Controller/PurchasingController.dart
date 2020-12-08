import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:syana/models/PurchasingModel.dart';
import 'package:syana/models/UserModel.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/utils/GlobalVars.dart';

class PurchasingController {
  BuildContext _context;
  UserModel _userModel;

  SaleController() {
    _getPersistence();
  }

  _getPersistence() async {
    _userModel = await GlobalFunctions.getPersistence();
  }

  getListPurchasing(
      context, loadingStateCallback, setDataCallback, type) async {
    if (_userModel == null) {
      await _getPersistence();
    }
    loadingStateCallback();
    FormData formData;

    Map param = GlobalFunctions.generateMapParam([
      "id_employee",
      "list_type"
    ], [
      _userModel.id.toString(),
      type
    ]);
    formData = FormData.fromMap(param);
    print(formData.fields);

    final data = await GlobalFunctions.dioPostCall(
        path: GlobalVars.baseUrl + "syana/purchasing/get-list-purchasing",
        params: formData,
        options: Options(
            headers: {"Authorization": "Bearer " + _userModel.accessToken}),
        context: context);

    if (data != null) {
      if (data['status'] == 200) {
        List purchasingFromApi = data['data'];
        List<PurchasingModel> purchasing = new List();

        purchasingFromApi.forEach((element) {
          purchasing.add(new PurchasingModel.listPurchasing(
              element['id_purchasing_submission'],
              element['submitted_by'],
              element['id_product'],
              element['status'],
              element['created_at'],
              element['full_name']));
        });

        if (purchasing.isNotEmpty) {
          setDataCallback(purchasing);
        }
      }
    } else {}
    loadingStateCallback();
  }
}
