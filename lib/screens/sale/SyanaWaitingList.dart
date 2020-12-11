import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syana/Controller/SaleController.dart';
import 'package:syana/models/SaleModel.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';

class WaitingList extends StatefulWidget {
  @override
  WaitingListState createState() => WaitingListState();
}

class WaitingListState extends State<WaitingList> {
  bool isLoading = false;

  SaleController _saleController;
  List<SaleModel> waitingList = new List();

  @override
  void setLoadingState() {
    setState(() {
      isLoading = isLoading ? isLoading = false : isLoading = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _saleController = new SaleController();
    _saleController.getWaitingListOrder(
        context, setLoadingState, setWaitingList);
  }

  setWaitingList(waitingList) {
    if (waitingList is List && waitingList.isNotEmpty) {
      setState(() {
        this.waitingList = waitingList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[200],
        title: Text("Waiting List Transactions"),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration: AppTheme.appBackground(),
              child: Column(
                children: [
                  Container(height: 15),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 8, left: 8),
                      child: ListView.builder(
                        itemCount: waitingList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: _waitingList(index),
                            onTap: () {
                              print("Detail List");
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _waitingList(int index) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12),
      ),
      height: Dimens.listHeightExtraSmall(context),
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 10,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                (index + 1).toString() + ". ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 53,
            fit: FlexFit.tight,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "No. Resi : " + waitingList[index].transactionNumber ?? "-",
                    softWrap: true,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  waitingList[index].status == "0"
                      ? Text(
                          "Status : " + "Menunggu Dipacking",
                        )
                      : Text(
                          "Status : " + "Sudah Dipacking",
                        )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 20,
            child: Container(
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black87,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
