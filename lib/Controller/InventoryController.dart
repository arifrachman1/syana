import 'package:flutter/material.dart';
import 'package:syana/models/ProductModel.dart';
import 'package:syana/models/TeamModel.dart';
import 'package:syana/models/UserModel.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/utils/GlobalVars.dart';

class InventoryController {
  UserModel _userModel;

  InventoryController() {
    _getPersistence();
  }

  _getPersistence() async {
    _userModel = await GlobalFunctions.getPersistence();
  }

  getStock(
      context, loadingStateCallback, setDataCallback, sortOrder, teamId) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params = GlobalFunctions.generateMapParam([
      'id_employee',
      'sort_order',
      'id_team'
    ], [
      _userModel.id.toString(),
      sortOrder,
      teamId == null
          ? _userModel.idTeam.toString()
          : teamId == 0 ? "global" : teamId.toString()
    ]);

    print(params);
    loadingStateCallback();
    final data = await GlobalFunctions.dioGetCall(
        path: GlobalVars.apiUrl + "get-stock",
        params: params,
        context: context);

    if (data != null) {
      print(data);
      if (data['status'] == 1) {
        List stockFromApi = data['product'];
        List<ProductModel> stocks = new List();

        if (stockFromApi.isNotEmpty) {
          stockFromApi.forEach((element) {
            stocks.add(new ProductModel.productStock(
                element['id'].toString(),
                element['status'].toString(),
                element['name'].toString(),
                element['image'].toString(),
                element['point'].toString(),
                element['stock'].toString(),
                element['critical_stock'].toString(),
                element['weight'].toString(),
                element['sku'].toString(),
                element['harga'].toString()));
          });
        }

        if (stocks.isNotEmpty) {
          setDataCallback(stocks);
        }
      }
    }
    loadingStateCallback();
  }

  getAddition(context, loadingStateCallback, setDataCallback, sortOrder,
      timeFilter, timeFrom, timeTo, teamId) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params = GlobalFunctions.generateMapParam([
      'filter_time',
      'time_from',
      'time_to',
      'id_team',
      'sort_order'
    ], [
      timeFilter.toString(),
      timeFrom,
      timeTo,
      teamId == null ? _userModel.idTeam.toString() : teamId.toString(),
      sortOrder
    ]);

    print(params);

    loadingStateCallback();
    final data = await GlobalFunctions.dioGetCall(
        context: context,
        path: GlobalVars.apiUrl + "get-addition",
        params: params);

    if (data != null) {
      print(data);
      if (data['status'] == 1) {
        List additionsFromApi = data['product'];
        List<ProductModel> additions = new List();

        if (additionsFromApi.isNotEmpty) {
          additionsFromApi.forEach((element) {
            additions.add(new ProductModel.productStock(
                element['id'].toString(),
                element['status'].toString(),
                element['name'].toString(),
                element['image'].toString(),
                element['point'].toString(),
                element['stock'].toString(),
                element['critical_stock'].toString(),
                element['weight'].toString(),
                element['sku'].toString(),
                element['price'].toString()));
          });
        }

        setDataCallback(additions);
      }
    }
    loadingStateCallback();
  }

  getSaleHistory(context, loadingStateCallback, setDataCallback, sortOrder,
      timeFilter, timeFrom, timeTo, teamId) async {
    if(_userModel == null){
      await _getPersistence();
    }

    var params = GlobalFunctions.generateMapParam([
      'filter_time',
      'time_from',
      'time_to',
      'id_team',
      'sort_order'
    ], [
      timeFilter.toString(),
      timeFrom,
      timeTo,
      teamId == null ? _userModel.idTeam.toString() : teamId.toString(),
      sortOrder
    ]);

    print(params);

    loadingStateCallback();
    final data = await GlobalFunctions.dioGetCall(
        context: context,
        path: GlobalVars.apiUrl + "get-addition",
        params: params);

    if(data != null){
      if(data['status'] == 1){
        List historyFromApi = data['product'];
        List<ProductModel> history = new List();

        if (historyFromApi.isNotEmpty) {
          historyFromApi.forEach((element) {
            history.add(new ProductModel.productStock(
                element['id'].toString(),
                element['status'].toString(),
                element['name'].toString(),
                element['image'].toString(),
                element['point'].toString(),
                element['stock'].toString(),
                element['critical_stock'].toString(),
                element['weight'].toString(),
                element['sku'].toString(),
                element['price'].toString()));
          });
        }

        setDataCallback(history);
      }
    }
    loadingStateCallback();
  }

  getTeams(context, loadingStateCallback, setDataCallback) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params =
        GlobalFunctions.generateMapParam(["id_employee"], [_userModel.id]);

    loadingStateCallback();
    final data = await GlobalFunctions.dioGetCall(
        context: context, params: params, path: GlobalVars.apiUrl + "get-team");

    if (data != null) {
      if (data['status'] == 1) {
        List teamsFromApi = data['team'];
        List<TeamModel> teams = new List();

        if (teamsFromApi.isNotEmpty) {
          teamsFromApi.forEach((element) {
            teams.add(new TeamModel.teamsDropdown(
                element['id'].toString(), element['name'].toString()));
          });
        }

        List<DropdownMenuItem> teamDropdownItems =
            _generateDropdownItems(teams);

        if (teamDropdownItems.isNotEmpty) {
          setDataCallback(teamDropdownItems);
        }
      }
    }
    loadingStateCallback();
  }

  _generateDropdownItems(List<TeamModel> objects) {
    List<DropdownMenuItem> temp = new List();
    temp.add(new DropdownMenuItem(
      child: Text("Global"),
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
}
