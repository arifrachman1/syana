import 'package:flutter/material.dart';
import 'package:syana/Controller/ProfileController.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/widgets/CustomBottomNav.dart';

class SyanaMyPoints extends StatefulWidget {
  SyanaMyPointsState createState() => SyanaMyPointsState();
}

class SyanaMyPointsState extends State<SyanaMyPoints> {
  List<List> point = [
    [0, 0],
    [6, 22],
  ];

  ProfileController _profileController;

  bool _isLoading = false;

  Map _myPoints = new Map();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _profileController = new ProfileController();
    _initData();
  }

  _initData() async {
    await _profileController.getMyPoints(context, setLoadingState, setData);
  }

  void setLoadingState() {
    if (this.mounted) {
      setState(() {
        _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
      });
    }
  }

  void setData(data) {
    if (data is Map) {
      setState(() {
        _myPoints = data;
        print(_myPoints);
      });
    }
  }

  getPoint(index, index2) {
    var selectedPoint = point[index];
    return selectedPoint[index2];
  }

  tableBorder() {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: AppTheme.yellow,
          width: 2,
        ),
      ),
    );
  }

  rowHeight(context) {
    return MediaQuery.of(context).size.height * 0.05;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: CustomBottomNav.getBottomNav(context, 4),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: rowHeight(context),
                    decoration: tableBorder(),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          flex: 50,
                          fit: FlexFit.tight,
                          child: Text(''),
                        ),
                        Flexible(
                          flex: 25,
                          fit: FlexFit.tight,
                          child: Text(
                            'Poin',
                            style: TextStyle(
                              color: AppTheme.text_light,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 25,
                          fit: FlexFit.tight,
                          child: Text(
                            'Paket',
                            style: TextStyle(
                              color: AppTheme.text_light,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: rowHeight(context),
                    decoration: tableBorder(),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          flex: 50,
                          fit: FlexFit.tight,
                          child: Text(
                            'Bulan ini',
                            style: TextStyle(
                              color: AppTheme.text_light,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 25,
                          fit: FlexFit.tight,
                          child: Text(
                            _myPoints['pointsThisMonth'] != null
                                ? double.parse(_myPoints['pointsThisMonth'])
                                    .round()
                                    .toString()
                                : "0",
                            style: TextStyle(
                              color: AppTheme.text_light,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 25,
                          fit: FlexFit.tight,
                          child: Text(
                            _myPoints['packagesThisMonth'] != null
                                ? double.parse(_myPoints['packagesThisMonth'])
                                    .round()
                                    .toString()
                                : "0",
                            style: TextStyle(
                              color: AppTheme.text_light,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: rowHeight(context),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          flex: 50,
                          fit: FlexFit.tight,
                          child: Text(
                            '3 Bulan yang lalu',
                            style: TextStyle(
                              color: AppTheme.text_light,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 25,
                          fit: FlexFit.tight,
                          child: Text(
                            _myPoints['pointsThreeMonthsPrior'] != null
                                ? double.parse(
                                        _myPoints['pointsThreeMonthsPrior'])
                                    .round()
                                    .toString()
                                : "0",
                            style: TextStyle(
                              color: AppTheme.text_light,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 25,
                          fit: FlexFit.tight,
                          child: Text(
                            _myPoints['packagesThreeMonthsPrior'] != null
                                ? double.parse(
                                        _myPoints['packagesThreeMonthsPrior'])
                                    .round()
                                    .toString()
                                : "0",
                            style: TextStyle(
                              color: AppTheme.text_light,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
