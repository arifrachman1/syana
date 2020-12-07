import 'package:flutter/material.dart';
import 'package:syana/DefaultView.dart';
import 'package:syana/Controller/BookmarkController.dart';
import 'package:syana/models/BookmarkModel.dart';
import 'package:syana/models/SaleDetailModel.dart';
import 'package:syana/models/SummaryModel.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaSummaryDetail extends StatefulWidget {
  SummaryModel model;
  bool doesLaunchedFromBookmark;

  SyanaSummaryDetail(this.model, {@required this.doesLaunchedFromBookmark});

  _SyanaSummaryDetailState createState() => _SyanaSummaryDetailState();
}

class _SyanaSummaryDetailState extends DefaultView<SyanaSummaryDetail> {
  List<String> _item = new List();

  BookmarkController _bookmarkController;

  bool _isLoading = false;

  itemSummary() {
    setState(() {
      _item.add("Item A 1x");
      _item.add("Item B 2x");
      _item.add("Item C 3x");
      _item.add("Item D 4x");
      _item.add("Item E 5x");
      _item.add("Item F 6x");
      _item.add("Item G 7x");
      _item.add("Item H 8x");
      _item.add("Item I 9x");
      _item.add("Item J 10x");
      _item.add("Item K 11x");
      _item.add("Item L 12x");
      _item.add("Item M 13x");
      _item.add("Item N 14x");
    });
  }

  @override
  void initState() {
    super.initState();
    _bookmarkController = new BookmarkController();
    itemSummary();
  }

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

  //List<BookmarkModel> _bookmarkModel = new List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen[200],
          title: Text('Detail'),
          actions: [
            getWidget().doesLaunchedFromBookmark
                ? Container()
                : PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text("Simpan Bookmark"),
                        value: 1,
                      ),
                    ],
                    onSelected: (value) {
                      switch (value) {
                        case 1:
                          _bookmarkController.setBookmark(
                              context,
                              setLoadingState,
                              BookmarkType.summaryDetail,
                              getWidget().model.toJson());
                          break;
                      }
                    },
                  )
          ],
        ),
        backgroundColor: Colors.lightGreen[200],
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                decoration: AppTheme.appBackground(),
                child: Center(
                    child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      //color: Colors.red,
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Text(
                              "Sales : ",
                              style: TextStyle(
                                color: AppTheme.text_light,
                                fontSize: 21,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              "${getWidget().model.cashierName}",
                              style: TextStyle(
                                color: AppTheme.text_light,
                                fontSize: 21,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: Row(
                        children: [
                          Text(
                            "Packer : ",
                            style: TextStyle(
                              color: AppTheme.text_light,
                              fontSize: 21,
                            ),
                          ),
                          Text(
                            "${getWidget().model.packerName}",
                            style: TextStyle(
                              color: AppTheme.text_light,
                              fontSize: 21,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Text(
                        "Detail penjualan : ",
                        style: TextStyle(
                          color: AppTheme.text_light,
                        ),
                      ),
                    ),
                    Flexible(
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            //color: Colors.red,
                            child: ListView.builder(
                                itemCount:
                                    getWidget().model.transDetails.length,
                                itemBuilder: (context, index) {
                                  SaleDetailModel _details =
                                      getWidget().model.transDetails[index];
                                  return ListTile(
                                    leading: Text(
                                      (index + 1).toString(),
                                      style: TextStyle(
                                        color: AppTheme.text_light,
                                      ),
                                    ),
                                    title: Text(
                                      "${_details.productName} | omzet : ${_details.omzet} | profit netto : ${_details.profitNetto}",
                                      style: TextStyle(
                                        color: AppTheme.text_light,
                                        fontSize: 14,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "Terjual : ${_details.saleNumber} | Free : ${_details.freeNumber}",
                                      style: TextStyle(
                                        color: AppTheme.text_light,
                                      ),
                                    ),
                                  );
                                }))),
                  ],
                )),
              ));
  }

  @override
  setData(data) {
    throw UnimplementedError();
  }
}
