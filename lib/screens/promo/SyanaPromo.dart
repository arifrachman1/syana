import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syana/Controller/PromoController.dart';
import 'package:syana/models/PromoModel.dart';
import 'package:syana/screens/promo/SyanaAddPromo.dart';
import 'package:syana/screens/promo/SyanaPromoDetail.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import 'package:syana/utils/Strings.dart';
import 'package:syana/widgets/CustomDialog.dart';

class SyanaPromo extends StatefulWidget {
  @override
  SyanaPromoState createState() => SyanaPromoState();
}

class SyanaPromoState extends State<SyanaPromo> {
  final String _devTitle = "promo";

  List<PromoModel> _promos = new List();
  List<PromoModel> _filteredPromos = new List();
  PromoController _promoController;

  bool _isLoading = false, _showDisabled = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _promoController = new PromoController();
    _initData();
  }

  _initData() async {
    await _promoController.getListPromo(context, setLoadingState, setData);
    await _promoController.filterOutPromo(
        setData, setLoadingState, _promos, false);
  }

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

  setData(data, isDisabledPromo, isInit) {
    if (data is List<PromoModel> && !isDisabledPromo && isInit) {
      setState(() {
        _promos = data;
      });
    }

    if (data is List<PromoModel> && isDisabledPromo && !isInit) {
      setState(() {
        _filteredPromos = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppTheme.yellow,
          foregroundColor: Colors.black,
          tooltip: 'Add',
          child: Icon(Icons.add),
          onPressed: () async {
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return SyanaAddPromo();
                },
              ),
            );

            print("result : " + result.toString());

            if (result == 200) {
              _initData();
            }
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.lightGreen[200],
          title: Text('Promo'),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.remove_red_eye,
                ),
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    _showDisabled = _showDisabled ? false : true;
                  });
                  _promoController.filterOutPromo(
                      setData, setLoadingState, _promos, _showDisabled);
                }),
          ],
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () {
                  _initData();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: AppTheme.appBackground(),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 10,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _filteredPromos.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: EdgeInsets.only(
                                  left: 10, top: 20, bottom: 20),
                              decoration: AppTheme.listBackground(),
                              height: Dimens.listHeightLarge(context),
                              margin: EdgeInsets.only(top: 7, bottom: 7),
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    fit: FlexFit.tight,
                                    flex: 85,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            _filteredPromos[index].title,
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: AppTheme.text_light,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            _filteredPromos[index].length == 1
                                                ? (_filteredPromos[index]
                                                        .startDate +
                                                    " s/d " +
                                                    _filteredPromos[index]
                                                        .endDate)
                                                : _filteredPromos[index]
                                                            .length ==
                                                        2
                                                    ? "Lifetime"
                                                    : "-",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppTheme.text_light,
                                            ),
                                          ),
                                        ),
                                        /*Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            getPromo(index, 2),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppTheme.text_light,
                                            ),
                                          ),
                                        ),*/
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    flex: 15,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: PopupMenuButton(
                                        onSelected: (value) async {
                                          switch (value) {
                                            case 1:
                                              var result =
                                                  await _promoController
                                                      .setPromoStatus(
                                                          context,
                                                          _filteredPromos[index]
                                                              .idPromo,
                                                          _filteredPromos[index]
                                                              .status);
                                              if (result) {
                                                _initData();
                                              } else {
                                                CustomDialog.getDialog(
                                                    title: Strings
                                                        .DIALOG_TITLE_ERROR,
                                                    message: Strings
                                                        .DIALOG_MESSAGE_SET_PROMO_STATUS_FAILED,
                                                    context: context,
                                                    popCount: 1);
                                              }
                                              break;
                                            case 2:
                                              log(_filteredPromos[index].title,
                                                  name: _devTitle);
                                              log(
                                                  _filteredPromos[index]
                                                      .promoDetails
                                                      .length
                                                      .toString(),
                                                  name: _devTitle);
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) {
                                                return SyanaPromoDetail(
                                                    _filteredPromos[index]
                                                        .idPromo);
                                              }));
                                              break;
                                          }
                                        },
                                        icon: Icon(
                                          Icons.more_vert,
                                          color: AppTheme.white,
                                        ),
                                        itemBuilder: (BuildContext context) => [
                                          PopupMenuItem(
                                            child: Text('Non-aktifkan'),
                                            value: 1,
                                          ),
                                          PopupMenuItem(
                                            child: Text('Detail'),
                                            value: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      /*Container(
                        margin: EdgeInsets.only(bottom: 20, right: 10),
                        alignment: Alignment.bottomRight,
                        child: 
                      ),*/
                    ],
                  ),
                ),
              ));
  }
}
