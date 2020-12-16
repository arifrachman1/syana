import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syana/Controller/PurchasingController.dart';
import 'package:syana/DefaultView.dart';
import 'package:syana/models/PurchasingModel.dart';
import 'package:syana/screens/Purchasing/CreatePurchasingDetail.dart';
import 'package:syana/utils/AppTheme.dart';

class Notifications extends StatefulWidget {
  @override
  NotificationsState createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {
  @override
  bool isLoading = false;

  PurchasingController _purchasingController;
  List<PurchasingModel> purchasingList = new List();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  setLoadingState() {
    // TODO: implement setLoadingState
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
    // TODO: implement initState
    super.initState();
    _purchasingController = new PurchasingController();
    _init();
  }

  _init() async {
    purchasingList.clear();
    _purchasingController.getListPurchasing(
        context, setLoadingState, setPurchasingList, 0);
  }

  setPurchasingList(purchasingList) {
    if (purchasingList is List && purchasingList.isNotEmpty) {
      setState(() {
        this.purchasingList = purchasingList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[200],
        title: Text("Notifications"),
      ),
      body: Container(
        decoration: AppTheme.appBackground(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                header: ClassicHeader(),
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 1));
                  _init();
                  _refreshController.refreshCompleted();
                },
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: purchasingList.length,
                        itemBuilder: (context, index) {
                          return _purchasingList(index);
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _purchasingList(int index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(10),
      decoration: AppTheme.inputDecorationShadow(),
      child: ListTile(
        title: Text(
          "Pengajuan Purchasing",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Ada pengajuan purchasing baru oleh " +
                    purchasingList[index].name ??
                "-"),
            Text(
              purchasingList[index].createdAt ?? "-",
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.chevron_right),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => CreatePurchasingDetail(
                      idPurchasing:
                          purchasingList[index].idPurchasingSubmission,
                    )));
          },
        ),
      ),
    );
  }
}
