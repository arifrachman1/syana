import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:syana/models/ProductModel.dart';
import 'package:syana/models/PromoDetailInModel.dart';
import 'package:syana/models/PromoDetailModel.dart';
import 'package:syana/models/PromoDetailOutModel.dart';
import 'package:syana/models/PromoModel.dart';
import 'package:syana/models/UserModel.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/utils/GlobalVars.dart';

class PromoController {
  UserModel _userModel;
  final String _devTitle = "promo_controller";

  PromoController() {
    _getPersistence();
  }

  _getPersistence() async {
    _userModel = await GlobalFunctions.getPersistence();
  }

  getListPromo(context, loadingStateCallback, setDataCallback) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params = GlobalFunctions.generateMapParam(
        ['id_team'], [_userModel.idTeam.toString()]);

    loadingStateCallback();
    final data = await GlobalFunctions.dioGetCall(
        context: context,
        path: GlobalVars.apiUrl + "get-promo",
        params: params);

    if (data != null) {
      if (data['status'] == 1) {
        List promosFromApi = data['promo'];
        List<PromoModel> promos = new List();
        List<PromoDetailModel> promoDetails = new List();
        List<PromoDetailInModel> promoDetailIns = new List();
        List<PromoDetailOutModel> promoDetailOuts = new List();

        if (promosFromApi.isNotEmpty) {
          promosFromApi.forEach((element) {
            List promoDetailsFromApi = element['promo_details'];
            promoDetailsFromApi.forEach((elementDetail) {
              List promoDetailInFromApi = elementDetail['promo_detail_in'];
              promoDetailInFromApi.forEach((elementIn) {
                promoDetailIns.add(new PromoDetailInModel.init(
                    elementIn['id_promo_detail_in'].toString(),
                    elementIn['id_promo_detail'].toString(),
                    elementIn['id_product_required'].toString(),
                    elementIn['amount_required'].toString(),
                    elementIn['required_type'].toString()));
              });

              List promoDetailOutFromApi = elementDetail['promo_detail_out'];
              promoDetailOutFromApi.forEach((elementOut) {
                promoDetailOuts.add(new PromoDetailOutModel.init(
                    elementOut['id_promo_detail_out'].toString(),
                    elementOut['id_promo_detail'].toString(),
                    elementOut['id_product_free'].toString(),
                    elementOut['amount_free'].toString()));
              });

              promoDetails.add(new PromoDetailModel.init(
                  elementDetail['id_promo_detail'].toString(),
                  elementDetail['id_promo'].toString(),
                  promoDetailIns,
                  promoDetailOuts));
            });

            promos.add(new PromoModel.init(
                element['id_promo'].toString(),
                element['judul_promo'].toString(),
                element['tanggal_mulai_promo'].toString(),
                element['tanggal_selesai_promo'].toString(),
                element['status_promo'].toString(),
                element['jangka_waktu_promo'].toString(),
                element['tipe_promo'].toString(),
                element['id_team'].toString(),
                promoDetails));
          });
        }

        setDataCallback(promos, false, true);
      }
    }

    loadingStateCallback();
  }

  getPromoForSales(context, loadingStateCallback, setDataCallback) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params = GlobalFunctions.generateMapParam(
        ['id_team'], [_userModel.idTeam.toString()]);

    loadingStateCallback();
    final data = await GlobalFunctions.dioGetCall(
        context: context,
        path: GlobalVars.apiUrl + "get-promo",
        params: params);

    if (data != null) {
      if (data['status'] == 1) {
        List promosFromApi = data['promo'];
        List<PromoModel> promos = new List();
        List<PromoDetailModel> promoDetails = new List();
        List<PromoDetailInModel> promoDetailIns = new List();
        List<PromoDetailOutModel> promoDetailOuts = new List();

        if (promosFromApi.isNotEmpty) {
          promosFromApi.forEach((element) {
            List promoDetailsFromApi = element['promo_details'];
            promoDetailsFromApi.forEach((elementDetail) {
              List promoDetailInFromApi = elementDetail['promo_detail_in'];
              promoDetailInFromApi.forEach((elementIn) {
                promoDetailIns.add(new PromoDetailInModel.init(
                    elementIn['id_promo_detail_in'].toString(),
                    elementIn['id_promo_detail'].toString(),
                    elementIn['id_product_required'].toString(),
                    elementIn['amount_required'].toString(),
                    elementIn['required_type'].toString()));
              });

              List promoDetailOutFromApi = elementDetail['promo_detail_out'];
              promoDetailOutFromApi.forEach((elementOut) {
                promoDetailOuts.add(new PromoDetailOutModel.init(
                    elementOut['id_promo_detail_out'].toString(),
                    elementOut['id_promo_detail'].toString(),
                    elementOut['id_product_free'].toString(),
                    elementOut['amount_free'].toString()));
              });

              promoDetails.add(new PromoDetailModel.init(
                  elementDetail['id_promo_detail'].toString(),
                  elementDetail['id_promo'].toString(),
                  promoDetailIns,
                  promoDetailOuts));
            });

            promos.add(new PromoModel.init(
                element['id_promo'].toString(),
                element['judul_promo'].toString(),
                element['tanggal_mulai_promo'].toString(),
                element['tanggal_selesai_promo'].toString(),
                element['status_promo'].toString(),
                element['jangka_waktu_promo'].toString(),
                element['tipe_promo'].toString(),
                element['id_team'].toString(),
                promoDetails));
          });
        }

        setDataCallback(promos);
      }
    }

    loadingStateCallback();
  }

  filterOutPromo(setDataCallback, loadingStateCallback, List<PromoModel> data,
      showDisabled) {
    List<PromoModel> temp = new List();
    loadingStateCallback();
    if (showDisabled == false) {
      data.forEach((element) {
        if (element.status.toString().compareTo("1") == 0) {
          temp.add(element);
        }
      });
    } else {
      data.forEach((element) {
        if (element.status.toString().compareTo("1") != 0) {
          temp.add(element);
        }
      });
    }
    loadingStateCallback();

    setDataCallback(temp, true, false);
  }

  Future<List> getProductData(context, sku, teamId) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params = GlobalFunctions.generateMapParam([
      "sku",
      "id_team"
    ], [
      sku,
      teamId != null ? teamId.toString() : _userModel.idTeam.toString()
    ]);

    final data = await GlobalFunctions.dioGetCall(
        context: context,
        params: params,
        path: GlobalVars.apiUrl + "get-product-like-sku");

    if (data != null) {
      print(data);
      if (data['status'] == 1) {
        List _productsSuggestionFromApi = data['product'];
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

  checkPromoInput(
      {option,
      firstRequired,
      firstMinimum,
      secondRequired,
      secondMinimum,
      freeItem,
      freeSize,
      minPrice}) {
    var pass = false;
    if (option == 0) {
      if ((firstRequired != null || firstRequired != "") &&
          (firstMinimum != null || firstMinimum != "") &&
          (freeSize != null || freeSize != "")) {
        pass = true;
      } else {
        pass = false;
      }
    } else if (option == 1) {
      if ((firstRequired != null || firstRequired != "") &&
          (firstMinimum != null || firstMinimum != "") &&
          (freeItem != null || freeItem != "") &&
          (freeSize != null || freeSize != "")) {
        pass = true;
      } else {
        pass = false;
      }
    } else if (option == 2) {
      if ((firstRequired != null || firstRequired != "") &&
          (firstMinimum != null || firstMinimum != "") &&
          (secondRequired != null || secondRequired != "") &&
          (secondMinimum != null || secondMinimum != "") &&
          (freeItem != null || freeItem != "") &&
          (freeSize != null || freeSize != "")) {
        pass = true;
      } else {
        pass = false;
      }
    } else if (option == 3) {
      if ((minPrice != null || minPrice != "") &&
          (freeItem != null || freeItem != "") &&
          (freeSize != null || freeSize != "")) {
        pass = true;
      } else {
        pass = false;
      }
    }
    return pass;
  }

  generatePromo(Map params, which) {
    switch (which) {
      case 0:
        var detailIn = PromoDetailInModel.createPromo(
            params['selectedFirstProducts'],
            params['firstMinimum'],
            (which + 1).toString());
        var detailOut = PromoDetailOutModel.createPromo(
            params['selectedFirstProducts'], params['freeSize']);
        var detail = PromoDetailModel.createPromo([detailIn], [detailOut]);
        return detail;
        break;
      case 1:
        var detailIn = PromoDetailInModel.createPromo(
            params['selectedFirstProducts'],
            params['firstMinimum'],
            (which + 1).toString());
        var detailOut = PromoDetailOutModel.createPromo(
            params['selectedFree'], params['freeSize']);
        var detail = PromoDetailModel.createPromo([detailIn], [detailOut]);
        return detail;
        break;
      case 2:
        var firstDetailIn = PromoDetailInModel.createPromo(
            params['selectedFirstProducts'],
            params['firstMinimum'],
            (which + 1).toString());
        var secondDetailIn = PromoDetailInModel.createPromo(
            params['selectedSecondProducts'],
            params['secondMinimum'],
            (which + 1).toString());
        var detailOut = PromoDetailOutModel.createPromo(
            params['selectedFree'], params['freeSize']);
        var detail = PromoDetailModel.createPromo(
            [firstDetailIn, secondDetailIn], [detailOut]);
        return detail;
        break;
      case 3:
        var detailIn = PromoDetailInModel.createMinimumPricePromo(
            params['minimumPrice'], (which + 1).toString());
        var detailOut = PromoDetailOutModel.createPromo(
            params['selectedFree'], params['freeSize']);
        var detail = PromoDetailModel.createPromo([detailIn], [detailOut]);
        return detail;
        break;
    }
  }

  setPromo(context, loadingStateCallback, Map functionParams) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params = GlobalFunctions.generateMapParam([
      "judul_promo",
      "tipe_promo",
      "jangka_waktu_promo",
      "tanggal_mulai_promo",
      "tanggal_selesai_promo",
      "id_team",
      "promo_details"
    ], [
      functionParams['title'],
      functionParams['type'],
      functionParams['length'],
      functionParams['startDate'],
      functionParams['endDate'],
      functionParams['teamId'],
      GlobalFunctions.generateJsonFromList([functionParams['details']])
    ]);

    FormData formParam = FormData.fromMap(params);

    print(params);

    final data = await GlobalFunctions.dioPostCall(
        context: context,
        params: formParam,
        path: GlobalVars.apiUrl + "set-promo");

    if (data != null) {
      print(data);
      if (data['status'] == 1) {
        print("success!");
        Navigator.of(context).pop(200);
        Navigator.of(context).pop(200);
      }
    }
  }

  Map checkAvailablePromo(
      selectedProduct, selectedProductSaleNumber, promos, totalPrice) {
    log("begin checking...", name: _devTitle);
    Map<String, dynamic> returnValues = new Map();
    if (promos is List<PromoModel> && promos.isNotEmpty) {
      promos.forEach((promoElement) {
        if (promoElement.status.toString().compareTo("1") == 0) {
          log("promo status on...", name: _devTitle);
          bool _doesMeetRequirements = false;
          promoElement.promoDetails.forEach((promoDetailElement) {
            promoDetailElement.promoDetailIns.forEach((detailInElement) {
              /*to check whether the provided id matching the required product id*/
              if (selectedProduct
                      .toString()
                      .compareTo(detailInElement.idProductRequired) ==
                  0) {
                log("product match...", name: _devTitle);
                /*check promos*/
                if (detailInElement.requiredType.toString().compareTo("1") ==
                        0 ||
                    detailInElement.requiredType.toString().compareTo("2") ==
                        0) {
                  /*to check whether the provided sale number fulfilling the required minimum*/
                  if (selectedProductSaleNumber %
                          int.parse(detailInElement.amountRequired) ==
                      0) {
                    log("product amount matched the required amount...", name: _devTitle);
                    /*matched*/
                    log("returning data...", name: _devTitle);
                    promoDetailElement.promoDetailOuts
                        .forEach((detailOutElement) {
                      returnValues['status'] = true;
                      returnValues['freeProduct'] =
                          detailOutElement.idProductFree;
                      returnValues['freeAmount'] = detailOutElement.amountFree;
                    });
                  } else if (selectedProductSaleNumber %
                          int.parse(detailInElement.amountRequired) !=
                      0) {
                    log("product amount did not match the required amount...", name: _devTitle);
                    log("returning data...", name: _devTitle);
                    promoDetailElement.promoDetailOuts
                        .forEach((detailOutElement) {
                      returnValues['status'] = false;
                      returnValues['freeProduct'] =
                          detailOutElement.idProductFree;
                      returnValues['freeAmount'] = detailOutElement.amountFree;
                    });
                  }
                } else if (detailInElement.requiredType == "3") {
                  /*to check whether the provided sale number fulfilling the required minimum*/
                  if (selectedProductSaleNumber %
                          detailInElement.amountRequired ==
                      0) {
                    /*matched*/
                    detailInElement.fulfilled = true;
                  }

                  _doesMeetRequirements = promoElement
                      .checkFulfillment(promoDetailElement.promoDetailIns);

                  if (_doesMeetRequirements) {
                    promoDetailElement.promoDetailOuts
                        .forEach((detailOutElement) {
                      returnValues['status'] = true;
                      returnValues['freeProduct'] =
                          detailOutElement.idProductFree;
                      returnValues['freeAmount'] = detailOutElement.amountFree;
                    });
                  }
                } else {
                  if (totalPrice >= detailInElement.amountRequired &&
                      !promoElement.isPromoGet) {
                    promoDetailElement.promoDetailOuts
                        .forEach((detailOutElement) {
                      returnValues['status'] = true;
                      returnValues['freeProduct'] =
                          detailOutElement.idProductFree;
                      returnValues['freeAmount'] = detailOutElement.amountFree;
                      returnValues['isPromoGet'] = true;
                    });
                    promoElement.isPromoGet = true;
                  }
                }
              }
            });
          });
        }
      });
    } else {
      log("promos is not a list and is empty...", name: _devTitle);
    }
    return returnValues;
  }

  getPromoDetail(
      context, loadingStateCallback, setDataCallback, promoId) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params = GlobalFunctions.generateMapParam(['id_promo'], [promoId]);

    loadingStateCallback();
    final data = await GlobalFunctions.dioGetCall(
        context: context,
        params: params,
        path: GlobalVars.apiUrl + "get-promo-detail");

    if (data != null) {
      if (data['status'] == 1) {
        List<PromoDetailInModel> _promoDetailIns = new List();
        List<PromoDetailOutModel> _promoDetailOuts = new List();

        List _inFromApi = data['promo_detail']['promo_detail_in'];
        List _outFromApi = data['promo_detail']['promo_detail_out'];

        _inFromApi.forEach((element) {
          _promoDetailIns.add(new PromoDetailInModel.init(
              element['id_promo_detail_in'].toString(),
              element['id_promo_detail'].toString(),
              element['id_product_required'].toString(),
              element['amount_required'].toString(),
              element['required_type'].toString()));
        });

        _outFromApi.forEach((element) {
          _promoDetailOuts.add(new PromoDetailOutModel.init(
              element['id_promo_detail_out'].toString(),
              element['id_promo_detail'].toString(),
              element['id_product_free'].toString(),
              element['amount_free'].toString()));
        });

        Map returnValues = new Map();

        returnValues['promoId'] = data['promo_detail']['id_promo'];
        returnValues['promoTitle'] = data['promo_detail']['judul_promo'];
        returnValues['type'] = data['promo_detail']['tipe'];
        returnValues['startDate'] =
            data['promo_detail']['tanggal_mulai_promo'] ?? "-";
        returnValues['endDate'] =
            data['promo_detail']['tanggal_selesai_promo'] ?? "-";
        returnValues['detailIn'] = _promoDetailIns;
        returnValues['detailOut'] = _promoDetailOuts;

        setDataCallback(returnValues);
      }
    }
    loadingStateCallback();
  }

  setPromoStatus(context, promoId, status) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params = GlobalFunctions.generateMapParam(
        ['id_promo', 'status'], [promoId, status]);

    log(params.toString(), name: _devTitle);

    FormData _formData = FormData.fromMap(params);

    final data = await GlobalFunctions.dioPostCall(
        context: context,
        path: GlobalVars.apiUrl + "change-promo-status",
        params: _formData);

    if (data != null) {
      log(data.toString(), name: _devTitle);
      if (data['status'] == 1) {
        return true;
      } else {
        return false;
      }
    }
  }
}
