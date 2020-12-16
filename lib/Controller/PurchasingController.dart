import 'dart:developer';

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

import 'dart:developer' as dev;

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
        path: GlobalVars.purchasingUrl + "get-list-purchasing",
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
        path: GlobalVars.purchasingUrl + "get-product-by-sku",
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

  Future<List> getMaterialData(context, sku, type) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    FormData formData;

    Map param =
        GlobalFunctions.generateMapParam(["sku", "material_type"], [sku, type]);
    formData = FormData.fromMap(param);
    print(formData.fields);

    final data = await GlobalFunctions.dioPostCall(
        params: formData,
        path: GlobalVars.purchasingUrl + "get-material-by-sku",
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
          return materialsSuggestion;
        }
      }
    }
  }

  setApprovalPurchasing(context, loadingStateCallback, note, idPurchasingSub,
      statusApproval, tipe) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params = GlobalFunctions.generateMapParam(
        ['note', 'id_purchasing_submission', 'status_approval'],
        [note, idPurchasingSub, statusApproval]);

    FormData formData = FormData.fromMap(params);

    loadingStateCallback();

    final data = await GlobalFunctions.dioPostCall(
      context: context,
      params: formData,
      options: Options(
          headers: {"Authorization": "Bearer " + _userModel.accessToken}),
      path: GlobalVars.purchasingUrl + "approval-purchasing",
    );

    if (data != null) {
      print(data);
      if (data['status'] == 200) {
        if (tipe == 1) {
          Navigator.pop(context);
          CustomDialog.getDialog(
              title: Strings.DIALOG_TITLE_SUCCESS,
              message: data['message'],
              context: context,
              popCount: 1);
        } else {
          Navigator.pop(context);
          Navigator.pop(context);
          CustomDialog.getDialog(
              title: Strings.DIALOG_TITLE_SUCCESS,
              message: data['message'],
              context: context,
              popCount: 1);
        }
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

  sendData(context, loadingStateCallback, detailPurchasing, picture) async {
    if (_userModel == null) {
      await _getPersistence();
    }
    loadingStateCallback();

    FormData formData;

    Map param = GlobalFunctions.generateMapParam(
        ["id_employee", "purchasing_detail", "purchasing_image"],
        [_userModel.id, detailPurchasing, picture]);
    formData = FormData.fromMap(param);
    print(formData.fields);

    final data = await GlobalFunctions.dioPostCall(
        params: formData,
        path: GlobalVars.purchasingUrl + "submit-purchasing",
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
    loadingStateCallback();
  }

  getDetailPurchasing(
      context, loadingStateCallback, setDataCallback, idPurchasing) async {
    if (_userModel == null) {
      await _getPersistence();
    }
    loadingStateCallback();
    FormData formData;

    Map param = GlobalFunctions.generateMapParam(
        ["id_purchasing_submission"], [idPurchasing]);
    formData = FormData.fromMap(param);
    print(formData.fields);

    final data = await GlobalFunctions.dioPostCall(
        path: GlobalVars.purchasingUrl + "get-detail-purchasing",
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

  getDetailPurchasingNew(
      context, loadingStateCallback, setDataCallback, idPurchasing) async {
    if (_userModel == null) {
      await _getPersistence();
    }
    loadingStateCallback();

    FormData formData;

    Map param = GlobalFunctions.generateMapParam(
        ['id_purchasing_submission'], [idPurchasing]);

    formData = FormData.fromMap(param);
    print(formData.fields);

    final data = await GlobalFunctions.dioPostCall(
      path: GlobalVars.purchasingUrl + "get-detail-purchasing-new",
      params: formData,
      options: Options(
          headers: {"Authorization": "Bearer " + _userModel.accessToken}),
      context: context,
    );

    if (data != null) {
      if (data['status'] == 200) {
        PurchasingModel purchasing = new PurchasingModel.purchasing(
            data['data']['purchasing']['id_purchasing_submission'],
            data['data']['purchasing']['created_at'],
            data['data']['purchasing']['submitted_by'],
            data['data']['purchasing']['status']);

        List purchasingDetailFromApi = data['data']['purchasing_detail'];
        List<PurchasingModel> purchasingDetail = new List();

        purchasingDetailFromApi.forEach((element) {
          purchasingDetail.add(new PurchasingModel.detailPurchasing(
            element['id'],
            element['tipe'],
            element['nama'],
            element['sku'],
            element['jumlah'],
            element['harga'],
            element['harga_master'],
            element['total_harga'],
          ));
        });

        List purchasingStatusFromApi = data['data']['purchasing_status'];
        List<PurchasingModel> purchasingStatus = new List();

        purchasingStatusFromApi.forEach((element) {
          purchasingStatus.add(new PurchasingModel.listStatusPurchasing(
            element['id_purchasing_status'],
            element['status'],
            element['approved_at'],
            element['note'],
            element['idx_purchasing_submission'],
          ));
        });

        List purchasingImageFromApi = data['data']['purchasing_image'];
        List<PurchasingModel> purchasingImage = new List();

        purchasingImageFromApi.forEach((element) {
          purchasingImage.add(new PurchasingModel.listImagePurchasing(
            element['id_purchasing_image'],
            element['image'],
            element['status'],
            element['idx_purchasing_status'],
          ));
        });

        PurchasingModel purchasingMaster = new PurchasingModel.masterDetail(
            purchasing, purchasingDetail, purchasingImage, purchasingStatus);

        dev.log(purchasing.toString(), name: "PurchasingController");
        setDataCallback(purchasingMaster);
      }
    } else {}
    loadingStateCallback();
  }
}
