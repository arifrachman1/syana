import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:syana/models/MaterialModel.dart';
import 'package:syana/models/ProductModel.dart';
import 'package:syana/models/PurchasingModel.dart';
import 'package:syana/models/UserModel.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/utils/GlobalVars.dart';
import 'package:syana/utils/Strings.dart';
import 'package:syana/widgets/CustomDialog.dart';

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

    Map param = GlobalFunctions.generateMapParam(
        ["id_employee", "list_type"], [_userModel.id.toString(), type]);
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

  Future<List> getProductData(context, sku) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    FormData formData;

    Map param = GlobalFunctions.generateMapParam(["sku"], [sku]);
    formData = FormData.fromMap(param);
    print(formData.fields);

    final data = await GlobalFunctions.dioPostCall(
        params: formData,
        path: GlobalVars.baseUrl + "syana/purchasing/get-product-by-sku",
        options: Options(
            headers: {"Authorization": "Bearer " + _userModel.accessToken}),
        context: context);

    if (data != null) {
      print(data);
      if (data['status'] == 200) {
        List _productsSuggestionFromApi = data['data'];
        List<ProductModel> productsSuggestion = new List();
        _productsSuggestionFromApi.forEach((element) {
          productsSuggestion.add(new ProductModel.productSuggestions(
              element['id'].toString(),
              element['name'].toString(),
              element['sku'].toString()));
        });

        return productsSuggestion;
      }
    }
  }

  getMaterialData(context, setDataCallback, type) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    FormData formData;

    Map param = GlobalFunctions.generateMapParam(["material_type"], [type]);
    formData = FormData.fromMap(param);
    print(formData.fields);

    final data = await GlobalFunctions.dioPostCall(
        params: formData,
        path: GlobalVars.baseUrl + "syana/purchasing/get-material-by-type",
        options: Options(
            headers: {"Authorization": "Bearer " + _userModel.accessToken}),
        context: context);

    if (data != null) {
      print(data);
      if (data['status'] == 200) {
        List _materialsSuggestionFromApi = data['data'];
        List<MaterialModel> materialsSuggestion = new List();
        _materialsSuggestionFromApi.forEach((element) {
          materialsSuggestion.add(new MaterialModel.listMaterial(
              element['id'].toString(),
              element['harga'].toString(),
              element['nama'].toString(),
              element['sku'].toString(),
              element['satuan'].toString()));
        });

        if (materialsSuggestion.isNotEmpty) {
          setDataCallback(materialsSuggestion);
        }
      }
    }
  }

  setApprovalPurchasing(context, loadingStateCallback, setDataCallback,
      idPurchasingSub, statusApproval) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params = GlobalFunctions.generateMapParam(
        ['id_purchasing_submission', 'status_approval'],
        [idPurchasingSub, statusApproval]);

    FormData formData = FormData.fromMap(params);

    final data = await GlobalFunctions.dioPostCall(
      context: context,
      params: formData,
      options: Options(
          headers: {"Authorization": "Bearer " + _userModel.accessToken}),
      path: GlobalVars.baseUrl + "syana/purchasing/approval-purchasing",
    );

    if (data != null) {
      if (data['status'] == 200) {
        Navigator.pop(context);
        CustomDialog.getDialog(
            title: Strings.DIALOG_TITLE_SUCCESS,
            message: Strings.DIALOG_MESSAGE_CUSTOMER_SAVED,
            context: context,
            popCount: 1);
      }
    }
  }

  sendData(context, detailPurchasing, picture) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    FormData formData;

    Map param = GlobalFunctions.generateMapParam(
        ["id_employee", "purchasing_detail", "purchasing_image"],
        [_userModel.id, detailPurchasing, picture]);
    formData = FormData.fromMap(param);
    print(formData.fields);

    final data = await GlobalFunctions.dioPostCall(
        params: formData,
        path: GlobalVars.baseUrl + "syana/purchasing/submit-purchasing",
        options: Options(
            headers: {"Authorization": "Bearer " + _userModel.accessToken}),
        context: context);

    if (data != null) {
      print(data);
      if (data['status'] == 200) {
        Navigator.pop(context);
        Navigator.pop(context);
        CustomDialog.getDialog(
            title: Strings.DIALOG_TITLE_SUCCESS,
            message: data['message'],
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
  }

  getDetailPurchasing(
      context, loadingStateCallback, setDataCallback, idPurchasing) async {
    if (_userModel == null) {
      await _getPersistence();
    }
    loadingStateCallback();
    FormData formData;

    Map param = GlobalFunctions.generateMapParam(
        ["list_type"], [idPurchasing]);
    formData = FormData.fromMap(param);
    print(formData.fields);

    final data = await GlobalFunctions.dioPostCall(
        path: GlobalVars.baseUrl + "syana/purchasing/get-detail-purchasing",
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
