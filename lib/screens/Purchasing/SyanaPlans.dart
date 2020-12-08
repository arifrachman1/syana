import 'package:flutter/material.dart';
import 'package:syana/Controller/PurchasingController.dart';
import 'package:syana/DefaultView.dart';
import 'package:syana/models/PurchasingModel.dart';
import 'package:syana/screens/Purchasing/SyanaPlansAdd.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaPlans extends StatefulWidget {
  @override
  _SyanaPlansState createState() => _SyanaPlansState();
}

class _SyanaPlansState extends State<SyanaPlans> {
  List<String> _nama = new List();
  PurchasingController purchasingController;
  List<PurchasingModel> listPlanPurchasing = new List();

  namaItem() {
    setState(() {
      _nama.add("Ads Fb");
      _nama.add("Instagram");
      _nama.add("Whatsapp");
      _nama.add("Ads Fb");
      _nama.add("Instagram");
      _nama.add("Whatsapp");
      _nama.add("Ads Fb");
      _nama.add("Instagram");
      _nama.add("Whatsapp");
      _nama.add("Ads Fb");
      _nama.add("Instagram");
      _nama.add("Whatsapp");
      _nama.add("Ads Fb");
      _nama.add("Instagram");
      _nama.add("Whatsapp");
      _nama.add("Ads Fb");
      _nama.add("Instagram");
      _nama.add("Whatsapp");
      _nama.add("Ads Fb");
      _nama.add("Instagram");
      _nama.add("Whatsapps");
    });
  }

  bool isLoading = false;

  setData(data) {
    // TODO: implement setData
    if (data is List<PurchasingModel> && data.isNotEmpty) {
      setState(() {
        listPlanPurchasing = data;
      });
    }
  }

  setLoadingState() {
    // TODO: implement setLoadingState
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void initState() {
    super.initState();
    purchasingController = new PurchasingController();
    initData();
  }

  initData() async {
    await purchasingController.getListPurchasing(
        context, setLoadingState, setData, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SyanaPlansAdd()),
            );
          },
          label: Text('Tambah Plan'),
          icon: Icon(Icons.add_circle),
          backgroundColor: AppTheme.btn_success,
        ),
        appBar: AppBar(
            title: Text("Plans"), backgroundColor: Colors.lightGreen[300]),
        body: Container(
          decoration: AppTheme.appBackground(),
          child: Column(
            children: <Widget>[
              Flexible(
                  child: Container(
                      child: ListView.builder(
                          itemCount: listPlanPurchasing.length,
                          itemBuilder: (context, index) {
                            return Container(
                                //color: Colors.red,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1.0,
                                      color: AppTheme.white,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.center,
                                padding:
                                    EdgeInsets.fromLTRB(8.0, 5.0, 5.0, 4.0),
                                //padding: EdgeInsets.all(5.0),
                                margin: EdgeInsets.all(5.0),
                                child: ListTile(
                                  onTap: () {},
                                  title: Text(
                                    listPlanPurchasing[index].name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppTheme.white,
                                    ),
                                  ),
                                  subtitle: Text(
                                    listPlanPurchasing[index].createdAt,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: AppTheme.white,
                                    ),
                                  ),
                                  trailing: Icon(Icons.chevron_right_outlined),
                                  leading: Icon(
                                    Icons.access_time_outlined,
                                    color: AppTheme.yellow,
                                  ),
                                ));
                          }))),
            ],
          ),
        ));
  }
}
