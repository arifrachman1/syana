import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syana/models/BookmarkModel.dart';
import 'package:syana/models/SummaryModel.dart';
import 'package:syana/models/UserModel.dart';
import 'package:syana/screens/product_rank/SyanaSummaryDetail.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/utils/GlobalVars.dart';

enum BookmarkDataKey { list }

class BookmarkController {
  UserModel _userModel;

  getTitleFromEnum(type) {
    switch (type) {
      case BookmarkType.summaryDetail:
        return "Summary Detail";
        break;
    }
  }

  translateTypeEnumFromMobileToDb(type) {
    switch (type) {
      case BookmarkType.summaryDetail:
        return "summaryDetail";
        break;
    }
  }

  translateTypeEnumFromDbToMobile(type) {
    switch (type) {
      case "summaryDetail":
        return BookmarkType.summaryDetail;
        break;
    }
  }

  translateAndNavigateTo(BookmarkModel _model, context) async {
    switch (_model.type) {
      case BookmarkType.summaryDetail:
        SummaryModel _detailModel = new SummaryModel();
        Map _map = json.decode(_model.payloads);
        _detailModel.fromJson(_map);
//        log(_detailModel.toString());
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => SyanaSummaryDetail(
                  _detailModel,
                  doesLaunchedFromBookmark: true,
                )));
        break;
    }
  }

  setBookmark(context, setLoadingState, type, payload, {date}) async {
    setLoadingState();

    _userModel = await GlobalFunctions.getPersistence();

    String _type = translateTypeEnumFromMobileToDb(type);

    String title = getTitleFromEnum(type);

    Map _params = GlobalFunctions.generateMapParam(
        ['type', 'payload', 'title', 'date'], [_type, payload, title, date != null ? date : DateTime.now().toString()]);

    final data = await GlobalFunctions.dioPostCall(
        context: context,
        path: GlobalVars.bookmarkUrl + "set-bookmark",
        options: Options(headers: {"Authorization": "Bearer " + _userModel.accessToken.toString()}),
        params: json.encode(_params));

    if (data != null) {
      if (data['status'] == 200) {
        log(data['message'].toString());
      } else {
        log(data['message'].toString());
      }
    } else {
      log("data is null");
    }

    setLoadingState();
  }

  getBookmarks(context, setLoadingState, setData) async {
    setLoadingState();

    _userModel = await GlobalFunctions.getPersistence();

    final data = await GlobalFunctions.dioPostCall(
        context: context,
        path: GlobalVars.bookmarkUrl + "get-bookmark",
        options: Options(headers: {"Authorization": "Bearer " + _userModel.accessToken.toString()}));

    if (data != null) {
      if (data['status'] == 200) {
        List _dataFromApi = data['data'];
        List<BookmarkModel> _list = new List();

        for (var element in _dataFromApi) {
          BookmarkType _type = translateTypeEnumFromDbToMobile(element['type']);
          _list.add(new BookmarkModel.init(int.parse(element['id'].toString()), _type, element['payload'], element['title'], element['date']));
        }

        Map _data = GlobalFunctions.generateMapParam(['key', 'payload'], [BookmarkDataKey.list, _list]);

        setData(_data);
      } else {
        log(data['message'].toString());
      }
    } else {
      log("data is null");
    }

    setLoadingState();
  }

  removeBookmark(context, setLoadingState, id) async {
    setLoadingState();

    _userModel = await GlobalFunctions.getPersistence();

    var params = GlobalFunctions.generateMapParam(['id'], [id]);

    final data = await GlobalFunctions.dioPostCall(
        context: context,
        path: GlobalVars.bookmarkUrl + "remove-bookmark",
        params: params,
        options: Options(headers: {"Authorization": "Bearer " + _userModel.accessToken.toString()}));

    if (data != null) {
      if (data['status'] == 200) {
        log(data['message'].toString());
        setLoadingState();

        return 200;
      } else {
        log(data['message'].toString());
      }
    } else {
      log("data is null");
    }

    setLoadingState();
  }
}
