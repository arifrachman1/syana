import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recase/recase.dart';
import 'package:syana/Controller/CustomerController.dart';
import 'package:syana/models/CustomerModel.dart';
import 'package:syana/models/TransactionHistoryModel.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Strings.dart';
import 'package:syana/widgets/CustomDialog.dart';

class SyanaProductRankDetailCustomer extends StatefulWidget {
  String idCustomer;

  SyanaProductRankDetailCustomer({this.idCustomer});

  @override
  SyanaProductRankDetailCustomerState createState() =>
      SyanaProductRankDetailCustomerState();
}

class SyanaProductRankDetailCustomerState
    extends State<SyanaProductRankDetailCustomer> {
  CustomerController _customerController;
  CustomerModel dataCustomer;
  List<TransactionHistoryModel> historiesCustomer = new List();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _customerController = new CustomerController();
    initDataCustomer();
  }

  initDataCustomer() async {
    setLoadingState();
    await _customerController.getDataCustomer(
        context, setLoadingState, setData, widget.idCustomer);
    await _customerController.getHistoryCustomer(
        context, setLoadingState, setData, widget.idCustomer);
    setLoadingState();
  }

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

  setData(data) {
    if (data is CustomerModel && data != null) {
      setState(() {
        dataCustomer = data;
      });
    } else if (data is List<TransactionHistoryModel> && data.isNotEmpty) {
      setState(() {
        historiesCustomer = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightGreen[200],
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.lightGreen[200],
          title: Text("Detail Customer"),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: AppTheme.appBackground(),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Nama"),
                            Text(
                                dataCustomer.fullName.toString().titleCase ??
                                    "-",
                                style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Username"),
                            Text(
                                dataCustomer.nickName.toString().snakeCase ??
                                    "-",
                                style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("No. Telp"),
                            Text(dataCustomer.phoneNumber ?? "-",
                                style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Alamat"),
                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                            ),
                            Text(dataCustomer.address ?? "-",
                                style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Kota"),
                            Text(dataCustomer.city ?? "-",
                                style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Provinsi"),
                            Text(dataCustomer.province ?? "-",
                                style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Kode Pos"),
                            Text(dataCustomer.zipCode ?? "-",
                                style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("E-Commerce"),
                            Text(
                              dataCustomer.nameEcommerce ?? "-",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text("Riwayat Pembelian (" + historiesCustomer.length.toString() + ")"),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
//                          physics: ScrollPhysics(),
                          itemCount: historiesCustomer.length,
                          itemBuilder: (context, position) {
                            return ListTile(
                              leading: Text((position + 1).toString()),
                              title: Text(historiesCustomer[position]
                                  .transactionNumber),
                              subtitle: Text(
                                  historiesCustomer[position].datetimeCreated),
                              trailing: IconButton(
                                icon: Icon(Icons.content_copy),
                                onPressed: () {
                                  CustomDialog.getDialog(
                                      title: Strings.DIALOG_TITLE_SUCCESS,
                                      message: Strings
                                          .DIALOG_MESSAGE_API_COPY_SUCCESS,
                                      context: context,
                                      popCount: 1);
                                  Clipboard.setData(new ClipboardData(
                                      text: historiesCustomer[position]
                                          .transactionNumber));
                                },
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ));
  }
}
