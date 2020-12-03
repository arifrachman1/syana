import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';
import 'package:syana/Controller/CustomerController.dart';
import 'package:syana/Controller/InventoryController.dart';
import 'package:syana/Controller/RankDataController.dart';
import 'package:syana/models/CustomerModel.dart';
import 'package:syana/models/OverviewModel.dart';
import 'package:syana/models/RankDataModel.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/GlobalFunctions.dart';

class SyanaOverview extends StatefulWidget {
  @override
  SyanaOverviewState createState() => SyanaOverviewState();
}

class SyanaOverviewState extends State<SyanaOverview> {
  // *
  // *
  // *
  // Komponen DatePicker
  // ==============================================
  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();

  DateFormat formatDate = DateFormat("yyyy-MM-dd");

  String dayFrom = "DD";
  String monthFrom = "MM";
  String yearFrom = "YY";

  String dayTo = "DD";
  String monthTo = "MM";
  String yearTo = "YY";
  String _dateFrom = "";
  String _dateTo = "";

  Future<Null> selectDateFrom(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDateFrom,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateFrom)
      setState(
        () {
          selectedDateFrom = picked;
          var toSplit = picked.toString();
          getDay(val) {
            String dayTime = val.split('-')[2];
            String day = dayTime.split(' ')[0];
            return day;
          }

          dayFrom = getDay(toSplit);
          monthFrom = toSplit.split('-')[1];
          yearFrom = toSplit.split('-')[0];
        },
      );
    _dateFrom = formatDate.format(selectedDateFrom);
    if (_dateFrom != "" && _dateTo != "") {
      // rankTop50Customer.clear();
      setLoadingState();
      await _rankDataController.getOverview(context, setLoadingState, setData,
          _currentTimes, _dateFrom, _dateTo, _currentTeams);
      setLoadingState();
    }
  }

  Future<Null> selectDateTo(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDateTo,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateTo)
      setState(
        () {
          selectedDateTo = picked;
          var toSplit = picked.toString();
          getDay(val) {
            String dayTime = val.split('-')[2];
            String day = dayTime.split(' ')[0];
            return day;
          }

          dayTo = getDay(toSplit);
          monthTo = toSplit.split('-')[1];
          yearTo = toSplit.split('-')[0];
        },
      );
    _dateTo = formatDate.format(selectedDateTo);
    if (_dateFrom != "" && _dateTo != "") {
      // rankTop50Customer.clear();
      setLoadingState();
      await _rankDataController.getOverview(context, setLoadingState, setData,
          _currentTimes, _dateFrom, _dateTo, _currentTeams);
      setLoadingState();
    }
  }

  showsDatePicker(index) {
    if (index == 6) {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          'From',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      // margin: EdgeInsets.only(top: 10),
                      // padding: EdgeInsets.only(left: 10),
                      decoration: AppTheme.dateDecorationShadow(),
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.date_range,
                            color: AppTheme.white,
                          ),
                          Text(
                            dayFrom + ' - ' + monthFrom + ' - ' + yearFrom,
                            style: TextStyle(color: AppTheme.white),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      selectDateFrom(context);
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          'To',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      decoration: AppTheme.dateDecorationShadow(),
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.date_range,
                            color: AppTheme.white,
                          ),
                          Text(
                            dayTo + ' - ' + monthTo + ' - ' + yearTo,
                            style: TextStyle(color: AppTheme.white),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      selectDateTo(context);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  // *
  // *
  // Komponen Dropdown button
  // ===========================================
  List<String> waktu = [
    'Hari ini',
    'Minggu ini',
    'Bulan ini',
    'Minggu lalu',
    'Bulan lalu',
    'Grand Total',
    'Tentukan sendiri'
  ];
  List<String> cakupan = ['Global', 'Lokal'];

  String selectedWaktu;
  String selectedCakupan;

  void onChangedCakupan(value) {
    setState(() {
      this.selectedCakupan = value;
    });
  }

  // ===== API Component/Variables
  String selectedTime;
  String _currentTimes;

  int _currentTeams = 0;

  InventoryController _inventoryController;
  CustomerController _customerController;
  RankDataController _rankDataController;

  bool _isLoading = false;

  List<RankDataModel> rankTop50Customer = new List();
  OverviewModel overview = new OverviewModel();
  List<DropdownMenuItem> teams = new List();

  CustomerModel dataCustomer;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _inventoryController = new InventoryController();
    // _customerController = new CustomerController();
    _rankDataController = new RankDataController();
    selectedTime = waktu[0];
    _currentTimes = 0.toString();

    initDataRank();
  }

  initDataRank() async {
    setLoadingState();
    await _rankDataController.getOverview(context, setLoadingState, setData,
        _currentTimes, "", "", _currentTeams);
    await _inventoryController.getTeams(
        context, setLoadingState, setDropdownData, true);
    setLoadingState();
  }

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

  //Dropdown Filter Teams
  void setDropdownData(data) {
    if (data is List<DropdownMenuItem> && data.isNotEmpty) {
      setState(() {
        teams = data;
        _currentTeams = teams[0].value;
      });
    }
  }

  //OnChanged Dropdown Filter Time
  void onChangedWaktu(value) async {
    setState(() {
      this.selectedTime = value;
      _currentTimes = getFilterTime(value);
      _dateFrom = "";
      _dateTo = "";
    });
    if (_currentTimes != "7") {
      // rankTop50Customer.clear();
      setLoadingState();
      await _rankDataController.getOverview(context, setLoadingState, setData,
          _currentTimes, _dateFrom, _dateTo, _currentTeams);
      setLoadingState();
    }
    print(selectedTime);
    print(_currentTimes);
  }

  setData(data) {
    if (data is OverviewModel && data != null) {
      setState(() {
        overview = data;
      });
    } else if (data is CustomerModel && data != null) {
      setState(() {
        dataCustomer = data;
      });
    }
  }

  String getFilterTime(String filterTime) {
    String filterTemp = "";
    if (filterTime == "Hari ini") {
      filterTemp = "0";
    } else if (filterTime == "Minggu ini") {
      filterTemp = "1";
    } else if (filterTime == "Bulan ini") {
      filterTemp = "2";
    } else if (filterTime == "Minggu lalu") {
      filterTemp = "3";
    } else if (filterTime == "Bulan lalu") {
      filterTemp = "4";
    } else if (filterTime == "Grand Total") {
      filterTemp = "5";
    } else if (filterTime == "Tentukan sendiri") {
      filterTemp = "6";
    }
    return filterTemp;
  }

  // ============================================

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 10),
                            decoration: AppTheme.inputDecorationShadow(),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: selectedTime,
                                items: waktu.map(
                                  (String val) {
                                    return DropdownMenuItem(
                                      value: val,
                                      child: Text(
                                        val,
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (String value) {
                                  onChangedWaktu(value);
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.03,
                        ),
                        Expanded(
                          child: Container(
                              // width: 150,
                              padding: EdgeInsets.only(left: 10),
                              decoration: AppTheme.inputDecorationShadow(),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Text("Pilih Team"),
                                  items: teams,
                                  value: _currentTeams,
                                  onChanged: (value) async {
                                    setState(() {
                                      _currentTeams = value;
                                    });
                                    setLoadingState();
                                    // rankTop50Customer.clear();
                                    await _rankDataController.getOverview(
                                        context,
                                        setLoadingState,
                                        setData,
                                        _currentTimes,
                                        _dateFrom,
                                        _dateTo,
                                        _currentTeams);
                                    setLoadingState();
                                  },
                                ),
                              )),
                        ),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    showsDatePicker(
                      int.parse(_currentTimes),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    margin: EdgeInsets.only(top: 10, right: 20, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,                     
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Profit Bruto: ',
                                style: TextStyle(
                                  color: AppTheme.text_light,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Rp. ' +
                                    GlobalFunctions.convertRupiah(
                                        overview.profitBruto),
                                style: TextStyle(
                                  color: AppTheme.text_light,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Cost Terjual: ',
                                style: TextStyle(
                                  color: AppTheme.text_light,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),),
                              Text('Rp. ' +
                                  GlobalFunctions.convertRupiah(
                                      overview.costTerjual),
                                style: TextStyle(
                                  color: AppTheme.text_light,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),)
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Cost Free: ',
                                style: TextStyle(
                                  color: AppTheme.text_light,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),),
                              Text('Rp. ' +
                                  GlobalFunctions.convertRupiah(
                                      overview.costFree),
                                style: TextStyle(
                                  color: AppTheme.text_light,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),)
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Profit Netto: ',
                                style: TextStyle(
                                  color: AppTheme.text_light,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),),
                              Text('Rp. ' +
                                  GlobalFunctions.convertRupiah(
                                      overview.profitNetto),
                                style: TextStyle(
                                  color: AppTheme.text_light,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),)
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Omzet: ',
                                style: TextStyle(
                                  color: AppTheme.text_light,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),),
                              Text('Rp. ' +
                                  GlobalFunctions.convertRupiah(overview.omzet),
                                style: TextStyle(
                                  color: AppTheme.text_light,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),)
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ],
          );
  }

  detailCustomerPop() {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          String name = dataCustomer.fullName;
          return AlertDialog(
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("TUTUP",
                        style: TextStyle(color: AppTheme.teal_light))),
              ],
              content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text("Data Pelanggan"),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Provinsi"),
                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                            ),
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
                        child: Text("Riwayat Pembelian"),
                      ),
                      Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: 4,
                          itemBuilder: (context, position) {
                            return ListTile(
                              leading: Text((position + 1).toString()),
                              title: Text("TEST"),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
              }));
        });
  }
}
