import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syana/models/ChartDataModel.dart';
import 'package:syana/models/CourierModel.dart';
import 'package:syana/models/OverviewModel.dart';
import 'package:syana/models/ProductModel.dart';
import 'package:syana/models/RankDataModel.dart';
import 'package:syana/models/SaleDetailModel.dart';
import 'package:syana/models/SummaryEcommerceModel.dart';
import 'package:syana/models/SummaryModel.dart';
import 'package:syana/models/TeamModel.dart';
import 'package:syana/models/TraceModel.dart';
import 'package:syana/models/UserModel.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/utils/GlobalVars.dart';
import 'package:syana/utils/Strings.dart';
import 'package:syana/widgets/CustomDialog.dart';

enum RankDataKey { teamWithSummary, ecommerceWithSummary, summary }

class RankDataController {
  BuildContext _context;
  UserModel _userModel;
  List<ProductModel> _selectedProducts;

  RankDataController() {
    _getPersistence();
  }

  _getPersistence() async {
    _userModel = await GlobalFunctions.getPersistence();
  }

  /*get rank*/
  getRankProducts(context, loadingStateCallback, setDataCallback, dataType, filterTime, timeFrom, timeTo, idTeam) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params = GlobalFunctions.generateMapParam(
            ["data_type", "filter_time", "time_from", "time_to", "id_team"], [dataType, filterTime, timeFrom, timeTo, idTeam]);

    final data = await GlobalFunctions.dioGetCall(path: GlobalVars.apiUrl + "get-product-rank", context: context, params: params);

    if (data != null) {
      if (data['status'] == 1) {
        List rankFromApi = data['product'];
        List<ProductModel> rankProducts = new List();

        rankFromApi.forEach((element) {
          rankProducts.add(new ProductModel.productRank(element['id'], element['name'], element['image'], element['sku'], element['rank_value']));
        });

        if (rankProducts.isNotEmpty) {
          setDataCallback(rankProducts);
        }
      }
    } else {}
  }

  /*get top return*/
  getTopReturn(context, loadingStateCallback, setDataCallback, filterTime, timeFrom, timeTo, idTeam) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params = GlobalFunctions.generateMapParam(["filter_time", "time_from", "time_to", "id_team"], [filterTime, timeFrom, timeTo, idTeam]);

    final data = await GlobalFunctions.dioGetCall(path: GlobalVars.apiUrl + "get-top-return", context: context, params: params);

    if (data != null) {
      if (data['status'] == 1) {
        List rankFromApi = data['data'];
        List<ProductModel> rankProducts = new List();

        rankFromApi.forEach((element) {
          rankProducts.add(new ProductModel.rankTopData(element['value'], element['rank_value']));
        });

        if (rankProducts.isNotEmpty) {
          setDataCallback(rankProducts);
        }
      }
    } else {}
  }

  /*get top courier*/
  getTopCourier(context, loadingStateCallback, setDataCallback, filterTime, timeFrom, timeTo, idTeam) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params = GlobalFunctions.generateMapParam(["filter_time", "time_from", "time_to", "id_team"], [filterTime, timeFrom, timeTo, idTeam]);

    final data = await GlobalFunctions.dioGetCall(path: GlobalVars.apiUrl + "get-top-courier", context: context, params: params);

    if (data != null) {
      if (data['status'] == 1) {
        List rankFromApi = data['data'];
        List<ProductModel> rankProducts = new List();

        rankFromApi.forEach((element) {
          rankProducts.add(new ProductModel.rankTopData(element['value'], element['rank_value']));
        });

        if (rankProducts.isNotEmpty) {
          setDataCallback(rankProducts);
        }
      }
    } else {}
  }

  /*get top 50 customer*/
  getTop50Customer(context, loadingStateCallback, setDataCallback, filterTime, timeFrom, timeTo, idTeam) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params = GlobalFunctions.generateMapParam(["filter_time", "time_from", "time_to", "id_team"], [filterTime, timeFrom, timeTo, idTeam]);

    final data = await GlobalFunctions.dioGetCall(path: GlobalVars.apiUrl + "get-top-50-customer", context: context, params: params);

    if (data != null) {
      if (data['status'] == 1) {
        List rankFromApi = data['data'];
        List<RankDataModel> rankProducts = new List();

        rankFromApi.forEach((element) {
          rankProducts.add(new RankDataModel.top50(element['id_value'], element['value'], element['city'], element['rank_value']));
        });

        if (rankProducts.isNotEmpty) {
          setDataCallback(rankProducts);
        }
      }
    } else {}
  }

  /*get overview*/
  getOverview(context, loadingStateCallback, setDataCallback, filterTime, timeFrom, timeTo, idTeam) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var options = Options(headers: {"Authorization": "Bearer " + _userModel.accessToken.toString()});

    var params = GlobalFunctions.generateMapParam(["filter_time", "time_from", "time_to", "id_team"], [filterTime, timeFrom, timeTo, idTeam]);
    FormData formData = FormData.fromMap(params);
    final data =
    await GlobalFunctions.dioPostCall(path: GlobalVars.summaryUrl + "get-overview", context: context, params: formData, options: options);

    if (data != null) {
      if (data['status'] == 200) {
        var _overview = data['data'];

        OverviewModel _rankOverview = new OverviewModel.getOverview(
                _overview['profit_bruto'], _overview['cost_terjual'], _overview['cost_free'], _overview['profit_netto'], _overview['omzet']);

        if (_rankOverview != null) {
          setDataCallback(_rankOverview);
        }
      } else {
        CustomDialog.getDialog(title: Strings.DIALOG_TITLE_ERROR, message: data['message'], context: context, popCount: 1);
      }
    } else {
      CustomDialog.getDialog(title: Strings.DIALOG_TITLE_ERROR, message: Strings.DIALOG_MESSAGE_API_CALL_FAILED, context: context, popCount: 1);
    }
  }

  /*get top location*/
  getTopLocation(context, loadingStateCallback, setDataCallback, filterTime, timeFrom, timeTo, idTeam, type) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params =
    GlobalFunctions.generateMapParam(["filter_time", "time_from", "time_to", "id_team", "type"], [filterTime, timeFrom, timeTo, idTeam, type]);

    final data = await GlobalFunctions.dioGetCall(path: GlobalVars.apiUrl + "get-top-city", context: context, params: params);

    if (data != null) {
      if (data['status'] == 1) {
        List rankFromApi = data['data'];
        List<ProductModel> rankProducts = new List();

        rankFromApi.forEach((element) {
          rankProducts.add(new ProductModel.rankTopData(element['value'], element['rank_value']));
        });

        if (rankProducts.isNotEmpty) {
          setDataCallback(rankProducts);
        }
      }
    } else {}
  }

  /* Get Ingrendients Rank */
  getIngrendientsRank(context, loadingStateCallback, setDataCallback, filterTime, timeFrom, timeTo, idTeam) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var options = Options(headers: {"Authorization": "Bearer " + _userModel.accessToken.toString()});

    var params = GlobalFunctions.generateMapParam(["filter_time", "time_from", "time_to", "id_team"], [filterTime, timeFrom, timeTo, idTeam]);

    FormData formData = FormData.fromMap(params);

    final data =
    await GlobalFunctions.dioPostCall(context: context, options: options, path: GlobalVars.rankUrl + "get-rank-ingredient", params: formData);

    print(GlobalVars.rankUrl + "get-rank-ingredient");
    print(params);

    if (data != null) {
      if (data['status'] == 200) {
        List _ingrendientsFromApi = data['data'];
        List<ProductModel> _rankIngrendientsProducts = new List();

        _ingrendientsFromApi.forEach((element) {
          _rankIngrendientsProducts.add(new ProductModel.materialRank(
            element['nama_bahan'],
            element['create_at'],
            element['sku'],
            element['total_item'],
            element['code_satuan'],
          ));
        });
        if (_rankIngrendientsProducts.isNotEmpty) {
          setDataCallback(_rankIngrendientsProducts);
        }
      } else {
        CustomDialog.getDialog(title: Strings.DIALOG_TITLE_WARNING, message: data['message'], context: context, popCount: 1);
      }
    } else {
      CustomDialog.getDialog(title: Strings.DIALOG_TITLE_ERROR, message: Strings.DIALOG_MESSAGE_API_CALL_FAILED, context: context, popCount: 1);
    }
  }

  /* Get Packaging Rank */
  getPackagingRank(context, loadingStateCallback, setDataCallback, filterTime, timeFrom, timeTo, idTeam) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var options = Options(headers: {"Authorization": "Bearer " + _userModel.accessToken.toString()});

    var params = GlobalFunctions.generateMapParam(["filter_time", "time_from", "time_to", "id_team"], [filterTime, timeFrom, timeTo, idTeam]);

    FormData formData = FormData.fromMap(params);

    final data =
    await GlobalFunctions.dioPostCall(context: context, options: options, path: GlobalVars.rankUrl + "get-rank-packaging", params: formData);

    print(GlobalVars.rankUrl + "get-rank-packaging");
    print(params);

    if (data != null) {
      if (data['status'] == 200) {
        List _packagingFromApi = data['data'];
        List<ProductModel> _rankpackagingProducts = new List();

        _packagingFromApi.forEach((element) {
          _rankpackagingProducts.add(new ProductModel.materialRank(
            element['nama_bahan'],
            element['create_at'],
            element['sku'],
            element['total_item'],
            element['code_satuan'],
          ));
        });
        if (_rankpackagingProducts.isNotEmpty) {
          setDataCallback(_rankpackagingProducts);
        }
      }
    } else {}
  }

  /*strip categories from products*/
  getCategoriesFromProducts(List products) {
    Map<String, String> categories = new Map();
    categories["0"] = "All";
    if (products is List<ProductModel> && products.isNotEmpty) {
      List<String> ids = new List(), names = new List();
      products.forEach((element) {
        ids.add(element.idCategory);
        names.add(element.categoryName);
      });

      var distinctIds = ids.toSet().toList();
      var distinctNames = names.toSet().toList();

      print("distinct ids length : " + distinctIds.length.toString() + ", distinct names length : " + distinctNames.length.toString());

      if (distinctIds.length == distinctNames.length) {
        int i = 0;
        distinctIds.forEach((element) {
          categories[element] = distinctNames[i];
          i++;
        });
      }

      return categories;
    }
  }

  /*get products by supplied category*/
  getProductsByCategory(List products, idCategory) {
    List<ProductModel> categorizedProducts = new List();
    if (products is List<ProductModel> && products.isNotEmpty) {
      products.forEach((element) {
        if (element.idCategory == idCategory) {
          categorizedProducts.add(element);
        }
      });

      return categorizedProducts;
    }
  }

  setSale(context, loadingStateCallback, transNumber, courierId, List details) async {
    FormData formData;
    print(details);
    String paramDetail = GlobalFunctions.generateJsonParam(["detail"], [details]);
    print(paramDetail);
    Map param = GlobalFunctions.generateMapParam(["id_employee", "id_customer", "transaction_number", "detail", "courier"],
            [_userModel.id.toString(), GlobalVars.customerId, transNumber, paramDetail, courierId]);
    formData = FormData.fromMap(param);
    print(formData.fields);

    loadingStateCallback();
    final data = await GlobalFunctions.dioPostCall(path: GlobalVars.apiUrl + "sale-product", params: formData, context: context);
    if (data != null) {
      if (data['status'] == 1) {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        CustomDialog.getDialog(
                title: Strings.DIALOG_TITLE_SUCCESS, message: Strings.DIALOG_MESSAGE_TRANSACTION_SUCCESS, context: context, popCount: 1);
      } else {
        CustomDialog.getDialog(title: Strings.DIALOG_TITLE_ERROR, message: data['message'], context: context, popCount: 1);
        print(data['message']);
      }
    } else {
      CustomDialog.getDialog(title: Strings.DIALOG_TITLE_ERROR, message: Strings.DIALOG_MESSAGE_API_CALL_FAILED, context: context, popCount: 1);
    }
    loadingStateCallback();
  }

  getCourier(context, loadingStateCallback, setDataCallback) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    loadingStateCallback();
    final data = await GlobalFunctions.dioGetCall(
      path: GlobalVars.apiUrl + "get-all-courier",
      context: context,
    );

    if (data != null) {
      if (data['status'] == 1) {
        List courierFromApi = data['courier'];
        List<CourierModel> temp = new List();
        courierFromApi.forEach((element) {
          temp.add(new CourierModel(element['id'].toString(), element['name'].toString()));
        });

        if (temp.isNotEmpty) {
          setDataCallback(_generateDropdownMenuItems(temp));
        }
      }
    }
    loadingStateCallback();
  }

  List _generateDropdownMenuItems(List<CourierModel> objects) {
    List<DropdownMenuItem> temp = new List();
    if (objects.isNotEmpty) {
      objects.forEach((element) {
        temp.add(new DropdownMenuItem(
          child: Text(element.name),
          value: int.parse(element.id),
        ));
      });
    }
    return temp;
  }

  //Trace - Products Dropdown
  getProductsDropdown(context, loadingStateCallback, setDataCallback) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params = GlobalFunctions.generateMapParam(["id_employee"], [_userModel.id]);

    loadingStateCallback();
    final data = await GlobalFunctions.dioGetCall(context: context, params: params, path: GlobalVars.apiUrl + "get-list-product");

    if (data != null) {
      if (data['status'] == 1) {
        List productsFromApi = data['product'];
        List<ProductModel> products = new List();

        if (productsFromApi.isNotEmpty) {
          productsFromApi.forEach((element) {
            products.add(new ProductModel.productsDropdown(element['id'].toString(), element['name'].toString()));
          });
        }

        List<DropdownMenuItem> productDropdownItems = _generateDropdownProducts(products);

        if (productDropdownItems.isNotEmpty) {
          setDataCallback(productDropdownItems);
        }
      }
    }
    loadingStateCallback();
  }

  _generateDropdownProducts(List<ProductModel> objects) {
    List<DropdownMenuItem> temp = new List();
    temp.add(new DropdownMenuItem(
      child: Text("Pilih Produk"),
      value: 0,
    ));
    if (objects.isNotEmpty) {
      objects.forEach((element) {
        temp.add(new DropdownMenuItem(
          child: Text(element.name),
          value: int.parse(element.id),
        ));
      });
    }
    return temp;
  }

  //Trace - Add Trace
  sendTrace(context, loadingStateCallback, productId, traceDate, trace, type) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params = GlobalFunctions.generateMapParam(
            ["product_id", "trace_date", "trace", "type", "id_employee"], [productId, traceDate, trace, type, _userModel.id]);

    FormData formData = FormData.fromMap(params);

    final data = await GlobalFunctions.dioPostCall(context: context, path: GlobalVars.apiUrl + "set-trace", params: formData);

    print(GlobalVars.apiUrl + "set-trace");
    print(params);

    if (data != null) {
      if (data['status'] == 1) {
        Navigator.pop(context);
        Navigator.pop(context);
        CustomDialog.getDialog(title: Strings.DIALOG_TITLE_SUCCESS, message: Strings.DIALOG_MESSAGE_CUSTOMER_SAVED, context: context, popCount: 1);
      }
    }
  }

  //Trace - Get Trace List Data
  getTraceListData(context, loadingStateCallback, setDataCallback) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params = GlobalFunctions.generateMapParam(["id_employee"], [_userModel.id]);

    final data = await GlobalFunctions.dioGetCall(path: GlobalVars.apiUrl + "get-trace-by-employee", context: context, params: params);

    if (data != null) {
      if (data['status'] == 1) {
        List traceFromApi = data['trace'];
        List<TraceModel> traceLists = new List();

        traceFromApi.forEach((element) {
          traceLists.add(new TraceModel.traceData(element['trace_id'], element['product_id'], element['employee_team_id'], element['employee_id'],
                  element['trace_date'], element['trace'], element['product_name'], element['team_name'], element['employee_name']));
        });

        if (traceLists.isNotEmpty) {
          setDataCallback(traceLists);
        }
      }
    } else {}
  }

  //Trace - Get All Trace
  getAllTrace(context, setDataCallback, selectedDate) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params = GlobalFunctions.generateMapParam(["trace_date"], [selectedDate]);

    final data = await GlobalFunctions.dioGetCall(path: GlobalVars.apiUrl + "get-all-trace", context: context, params: params);

    if (data != null) {
      if (data['status'] == 1) {
        List traceFromApi = data['trace'];
        List<TraceModel> traceLists = new List();

        traceFromApi.forEach((element) {
          traceLists.add(new TraceModel.traceData(element['trace_id'], element['product_id'], element['employee_team_id'], element['employee_id'],
                  element['trace_date'], element['trace'], element['product_name'], element['team_name'], element['employee_name']));
        });

        if (traceLists.isNotEmpty) {
          setDataCallback(traceLists);
        }
      }
    } else {}
  }

  //Chart

  /*get chart*/
  getChartData(context, loadingStateCallback, setDataCallback, dataType, filterType, timeStart, timeEnd, idTeam, idProduct) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params = GlobalFunctions.generateMapParam(["data_type", "filter_type", "time_start", "time_end", "id_employee_team", "id_product"],
            [dataType, filterType, timeStart, timeEnd, idTeam, idProduct]);

    final data = await GlobalFunctions.dioGetCall(path: GlobalVars.apiUrl + "get-chart-data", context: context, params: params);

    if (data != null) {
      if (data['status'] == "1") {
        List chartFromApi = data['data'];
        List<ChartDataModel> chartGlobal = new List();

        chartFromApi.forEach((element) {
          if (filterType == "3") {
            chartGlobal.add(new ChartDataModel.chartTypeInt(element['value'], element['date']));
          } else {
            chartGlobal.add(new ChartDataModel.chartData(element['value'], element['date']));
          }
        });

        if (chartGlobal.isNotEmpty) {
          setDataCallback(chartGlobal);
        }
      }
    } else {}
  }

  //Get Dropdown Teams without "Global"
  getTeams(context, loadingStateCallback, setDataCallback) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params = GlobalFunctions.generateMapParam(["id_employee"], [_userModel.id]);

    loadingStateCallback();
    final data = await GlobalFunctions.dioGetCall(context: context, params: params, path: GlobalVars.apiUrl + "get-team");

    if (data != null) {
      if (data['status'] == 1) {
        List teamsFromApi = data['team'];
        List<TeamModel> teams = new List();

        if (teamsFromApi.isNotEmpty) {
          teamsFromApi.forEach((element) {
            teams.add(new TeamModel.teamsDropdown(element['id'].toString(), element['name'].toString()));
          });
        }

        if (teams.isNotEmpty) {
          setDataCallback(teams);
        }
      }
    }
    loadingStateCallback();
  }

  //Filter - MAX
  checkMaxFilter(context, setDataCallback) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    final data = await GlobalFunctions.dioGetCall(path: GlobalVars.apiUrl + "get-first-and-last-date", context: context);

    if (data != null) {
      if (data['status'] == 1) {
        ChartDataModel dateMaxMin = new ChartDataModel.checkMaxMin(
          data['max'],
          data['min'],
        );

        setDataCallback(dateMaxMin);
      }
    } else {}
  }

  getTeamsWithSummary(context, setData, setLoadingState, timeFilter, dateFrom, dateTo) async {
    setLoadingState();
    _userModel = await GlobalFunctions.getPersistence();

    Map _param =
    GlobalFunctions.generateMapParam(['id_team', 'filter_time', 'time_from', 'time_to'], [_userModel.idTeam, timeFilter, dateFrom, dateTo]);

    final data = await GlobalFunctions.dioPostCall(
            context: context,
            path: GlobalVars.summaryUrl + "get-team-with-summary",
            params: _param,
            options: Options(headers: {"Authorization": "Bearer " + _userModel.accessToken.toString()}));

    if (data != null) {
      if (data['status'] == 200) {
        List _dataFromApi = data['data'];
        List<SummaryEcommerceModel> _list = new List();
        List<DropdownMenuItem> _listToSend = new List();

        for (var element in _dataFromApi) {
          _list.add(new SummaryEcommerceModel(element['id'].toString(), element['name'], ""));
          _list.last.countAll = int.parse(element['sale_count_all']);
          _list.last.countProcessed = int.parse(element['sale_count_processed']);
          _list.last.countUnprocessed = int.parse(element['sale_count_unprocessed']);
        }

        for (SummaryEcommerceModel element in _list) {
          _listToSend.add(new DropdownMenuItem(
            child: Text("${element.name} | ${element.countAll} | ${element.countProcessed} | ${element.countUnprocessed}"),
            value: element.id,
          ));
        }

        Map _toSend = GlobalFunctions.generateMapParam(['key', 'payload'], [RankDataKey.teamWithSummary, _listToSend]);

        setData(_toSend);
      } else {
        log("${Strings.DIALOG_MESSAGE_API_CALL_FAILED} error trace : ${data['message']}");
      }
    } else {
      log(Strings.DIALOG_MESSAGE_API_CALL_FAILED);
    }

    setLoadingState();
  }

  getEcommerceWithSummary(context, setData, setLoadingState, idTeam, timeFilter, dateFrom, dateTo) async {
    setLoadingState();

    var params = GlobalFunctions.generateMapParam(['id_team', 'filter_time', 'time_from', 'time_to'], [idTeam, timeFilter, dateFrom, dateTo]);

    _userModel = await GlobalFunctions.getPersistence();

    final data = await GlobalFunctions.dioPostCall(
            context: context,
            path: GlobalVars.summaryUrl + "get-ecommerce-with-summary",
            params: params,
            options: Options(headers: {"Authorization": "Bearer " + _userModel.accessToken.toString()}));

    if (data != null) {
      if (data['status'] == 200) {
        List _dataFromApi = data['data'];
        List<SummaryEcommerceModel> _list = new List();
        List<DropdownMenuItem> _listToSend = new List();

        for (var element in _dataFromApi) {
          _list.add(new SummaryEcommerceModel(element['id'], element['name'], element['status']));
          _list.last.countAll = int.parse(element['count_all']);
          _list.last.countProcessed = int.parse(element['count_processed']);
          _list.last.countUnprocessed = int.parse(element['count_unprocessed']);
        }

        for (SummaryEcommerceModel element in _list) {
          _listToSend.add(new DropdownMenuItem(
            child: Text("${element.name} | ${element.countAll} | ${element.countProcessed} | ${element.countUnprocessed}"),
            value: element.id,
          ));
        }

        Map _toSend = GlobalFunctions.generateMapParam(['key', 'payload'], [RankDataKey.ecommerceWithSummary, _listToSend]);
        setData(_toSend);
      } else {
        log("${Strings.DIALOG_MESSAGE_API_CALL_FAILED} error trace : ${data['message']}");
      }
    } else {
      log(Strings.DIALOG_MESSAGE_API_CALL_FAILED);
    }

    setLoadingState();
  }

  getSummary(context, setData, setLoadingState, idTeam, idEcommerce, filterTime, dateFrom, dateTo) async {
    setLoadingState();

    var params = GlobalFunctions.generateMapParam(
            ['id_team', 'id_ecommerce', 'filter_time', 'time_from', 'time_to'], [idTeam, idEcommerce, filterTime, dateFrom, dateTo]);

    _userModel = await GlobalFunctions.getPersistence();

    final data = await GlobalFunctions.dioPostCall(
            context: context,
            path: GlobalVars.summaryUrl + "get-summary",
            params: params,
            options: Options(headers: {"Authorization": "Bearer " + _userModel.accessToken.toString()}));

    if (data != null) {
      if (data['status'] == 200) {
        List _dataFromApi = data['data'];
        List<SummaryModel> _list = new List();

        for (var element in _dataFromApi) {
          List<SaleDetailModel> _details = new List();
          var profitNetto = 0,
                  profitBruto = 0,
                  omzet = 0,
                  costTotal = 0;
          int _numbering = 0;
          for (var elementDetail in element['saleDetails']) {
            profitNetto += int.parse(elementDetail['profit_netto']);
            profitBruto += int.parse(elementDetail['profit_bruto']);
            omzet += int.parse(elementDetail['omzet']);
            costTotal += int.parse(elementDetail['product']['cost_total']);

            _details.add(new SaleDetailModel.initSummary(
                    elementDetail['id'],
                    elementDetail['id_sale'],
                    elementDetail['sale_number'],
                    elementDetail['free_number'],
                    int.parse(elementDetail['profit_bruto']),
                    int.parse(elementDetail['profit_netto']),
                    int.parse(elementDetail['omzet']),
                    elementDetail['product']['name'],
                    int.parse(elementDetail['product']['cost_total'])));
          }

          _list.add(new SummaryModel.init(
                  int.parse(element['id']),
                  int.parse(element['status']),
                  omzet,
                  profitBruto,
                  profitNetto,
                  element['transaction_number'],
                  element['employee']['full_name'],
                  element['employeePacking'] != null ? element['employeePacking']['full_name'] : "-",
                  _details,
                  costTotal,
                  _numbering + 1));

          _numbering++;
        }

        Map _toSend = GlobalFunctions.generateMapParam(['key', 'payload'], [RankDataKey.summary, _list]);

        setData(_toSend);
      } else {
        log("${Strings.DIALOG_MESSAGE_API_CALL_FAILED} error trace : ${data['message']}");
      }
    } else {
      log(Strings.DIALOG_MESSAGE_API_CALL_FAILED);
    }

    setLoadingState();
  }
}
