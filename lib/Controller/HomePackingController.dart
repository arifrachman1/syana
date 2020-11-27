import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syana/models/SaleDetailModel.dart';
import 'package:syana/models/SaleModel.dart';
import 'package:syana/models/UserModel.dart';
import 'package:syana/screens/credentials/Login.dart';
import 'package:syana/screens/packing/PackingDetail.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/utils/GlobalVars.dart';
import 'package:syana/utils/Strings.dart';
import 'package:syana/widgets/CustomDialog.dart';

class HomePackingController {
  UserModel _userModel;

  HomePackingController() {
    _getPersistence();
  }

  _getPersistence() async {
    _userModel = await GlobalFunctions.getPersistence();
  }

  getSalesByAirwayBillNumber(
      context, airwayBillNumber, loadingStateCallback) async {
    if (_userModel == null) {
      await _getPersistence();
    }
    FormData formData;
    Map param = GlobalFunctions.generateMapParam([
      "airway_bill_number",
    ], [
      airwayBillNumber,
    ]);
    formData = FormData.fromMap(param);
    print(formData.fields);

    final data = await GlobalFunctions.dioPostCall(
        context: context,
        params: formData,
        options: Options(
            headers: {"Authorization": "Bearer " + _userModel.accessToken}),
        path: GlobalVars.baseUrl +
            "syana/sale/" +
            "get-sales-by-airway-bill-number");

    print(data);
    print("WOIII");

    if (data != null) {
      if (data['status'] == 200) {
        GlobalFunctions.log(
            message: data.toString(), name: "packaging_controller");

        List<SaleDetailModel> saleDetailModels = new List();
        SaleModel saleModel;

        List _detailFromApi = data['data']['sale_detail'];

        _detailFromApi.forEach((element) {
          saleDetailModels.add(new SaleDetailModel.init(
            element['id'].toString(),
            element['id_sale'].toString(),
            element['id_product'].toString(),
            element['product_name'].toString(),
            element['sale_number'].toString(),
            element['point'].toString(),
            element['sku'].toString(),
            element['price'].toString(),
            element['weight'].toString(),
            0,
          ));
        });

        saleModel = new SaleModel.init(
          data['data']['sale']['id'].toString(),
          data['data']['sale']['transaction_number'].toString(),
          data['data']['sale']['total_point'].toString(),
          data['data']['sale']['datetime_created'].toString(),
          data['data']['sale']['username_customer'].toString(),
          data['data']['sale']['name_ecommerce'].toString(),
          saleDetailModels,
          data['data']['sale']['status'].toString(),
        );

        if (saleModel.status != "1") {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return PackingDetail(saleModel);
          }));
        } else {
          CustomDialog.getDialog(
              title: "Peringatan",
              message: "Data pembelian sudah dipacking.",
              context: context,
              popCount: 1);
        }
      }
    }
  }

  accPackingSale(context, loadingStateCallback, idSale) async {
    FormData formData;
    Map param = GlobalFunctions.generateMapParam([
      "id_employee",
      "id_sale",
    ], [
      _userModel.id.toString(),
      idSale,
    ]);
    formData = FormData.fromMap(param);
    print(formData.fields);

    loadingStateCallback();
    final data = await GlobalFunctions.dioPostCall(
        path: GlobalVars.baseUrl + "syana/sale/" + "packing-acc-sales",
        params: formData,
        options: Options(
            headers: {"Authorization": "Bearer " + _userModel.accessToken}),
        context: context);
    if (data != null) {
      if (data['status'] == 200) {
        Navigator.pop(context);
        CustomDialog.getDialog(
            title: Strings.DIALOG_TITLE_SUCCESS,
            message: Strings.DIALOG_MESSAGE_TRANSACTION_SUCCESS,
            context: context,
            popCount: 1);
      } else {
        CustomDialog.getDialog(
            title: Strings.DIALOG_TITLE_ERROR,
            message: data['message'],
            context: context,
            popCount: 1);
        print(data['message']);
      }
    } else {
      CustomDialog.getDialog(
          title: Strings.DIALOG_TITLE_ERROR,
          message: Strings.DIALOG_MESSAGE_API_CALL_FAILED,
          context: context,
          popCount: 1);
    }
    loadingStateCallback();
  }

  clearPersistence() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(GlobalVars.idKey);
    prefs.remove(GlobalVars.nameKey);
    prefs.remove(GlobalVars.fullNameKey);
    prefs.remove(GlobalVars.dateTimeJoinedKey);
    prefs.remove(GlobalVars.idRoleKey);
    prefs.remove(GlobalVars.idTeamKey);
    prefs.remove(GlobalVars.accessTokenKey);
  }

  logout(context) async {
    await clearPersistence();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) {
      return Login();
    }), (route) => false);
  }
}
