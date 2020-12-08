import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';
import 'package:syana/Controller/CustomerController.dart';
import 'package:syana/Controller/InventoryController.dart';
import 'package:syana/Controller/RankDataController.dart';
import 'package:syana/models/CustomerModel.dart';
import 'package:syana/models/RankDataModel.dart';
import 'package:syana/screens/product_rank/SyanaProductRankDetailCustomer.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';

class SyanaProductRankTop50Customer extends StatefulWidget {
  @override
  SyanaProductRankTop50CustomerState createState() =>
      SyanaProductRankTop50CustomerState();
}

class SyanaProductRankTop50CustomerState
    extends State<SyanaProductRankTop50Customer> {
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
      rankTop50Customer.clear();
      setLoadingState();
      await _rankDataController.getTop50Customer(context, setLoadingState,
          setData, _currentTimes, _dateFrom, _dateTo, _currentTeams);
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
      rankTop50Customer.clear();
      setLoadingState();
      await _rankDataController.getTop50Customer(context, setLoadingState,
          setData, _currentTimes, _dateFrom, _dateTo, _currentTeams);
      setLoadingState();
    }
  }

  showsDatePicker(index) {
    if (index == 7) {
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
    _customerController = new CustomerController();
    _rankDataController = new RankDataController();
    selectedTime = waktu[0];
    _currentTimes = 0.toString();

    initDataRank();
  }

  initDataRank() async {
    setLoadingState();
    await _rankDataController.getTop50Customer(context, setLoadingState,
        setData, _currentTimes, "", "", _currentTeams);
    await _inventoryController.getTeams(
        context, setLoadingState, setDropdownData, true);
    print("list length : " + rankTop50Customer.length.toString());
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
      _currentTimes = getFilterTime(selectedTime);
      _dateFrom = "";
      _dateTo = "";
    });
    if (_currentTimes != "7") {
      rankTop50Customer.clear();
      setLoadingState();
      await _rankDataController.getTop50Customer(context, setLoadingState,
          setData, _currentTimes, _dateFrom, _dateTo, _currentTeams);
      setLoadingState();
    }
    print(selectedTime);
    print(_currentTimes);
  }

  setData(data) {
    if (data is List<RankDataModel> && data.isNotEmpty) {
      setState(() {
        rankTop50Customer = data;
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
      filterTemp = "4";
    } else if (filterTime == "Bulan lalu") {
      filterTemp = "5";
    } else if (filterTime == "Grand Total") {
      filterTemp = "6";
    } else if (filterTime == "Tentukan sendiri") {
      filterTemp = "7";
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
                                    rankTop50Customer.clear();
                                    await _rankDataController.getTop50Customer(
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
                  margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: rankTop50Customer.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return SyanaProductRankDetailCustomer(
                                  idCustomer: rankTop50Customer[index].id,
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                index < 3 ? AppTheme.teal_light : AppTheme.teal,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          height: Dimens.listHeightSmall(context),
                          margin: EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                flex: 10,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    (index + 1).toString(),
                                    style: TextStyle(
                                      color: index < 3
                                          ? AppTheme.text_darker
                                          : AppTheme.text_light,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        rankTop50Customer[index]
                                            .value
                                            .toString()
                                            .titleCase,
                                        softWrap: true,
                                        style: TextStyle(
                                          color: index < 3
                                              ? AppTheme.text_darker
                                              : AppTheme.text_light,
                                          fontSize: 15,
		                                        fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      rankTop50Customer[index].city == null
                                          ? Text(
                                              "-",
                                              softWrap: true,
                                              style: TextStyle(
                                                color: index < 3
                                                    ? AppTheme.text_darker
                                                    : AppTheme.text_light,
                                                fontSize: 15,
                                              ),
                                            )
                                          : Text(
                                              rankTop50Customer[index]
                                                  .city
                                                  .toString()
                                                  .titleCase,
                                              softWrap: true,
                                              style: TextStyle(
                                                color: index < 3
                                                    ? AppTheme.text_darker
                                                    : AppTheme.text_light,
                                                fontSize: 15,
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 20,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    rankTop50Customer[index].rankValue,
                                    softWrap: true,
                                    style: TextStyle(
                                      color: index < 3
                                          ? AppTheme.text_darker
                                          : AppTheme.text_light,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
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
                        margin: EdgeInsets.only(top: 10,bottom: 10),
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
                        margin: EdgeInsets.only(top:10),
                        child: Text("Riwayat Pembelian"),
                      ),
                      Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: 4,
                          itemBuilder: (context, position) {
                            return ListTile(
                              leading: Text((position+1).toString()),
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
