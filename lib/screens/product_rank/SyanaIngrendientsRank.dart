import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/Dimens.dart';
import 'package:syana/widgets/CustomImage.dart';

class SyanaIngrendientsRank extends StatefulWidget {
  _State createState() => _State();
}

class _State extends State<SyanaIngrendientsRank> {
  bool _isLoading = false;

  String selectedTime;
  String selectedTeam;

  List _waktu = [
    'Hari ini',
    'Minggu ini',
    'Bulan ini',
    'Minggu lalu',
    'Bulan lalu',
    'Grand Total',
    'Tentukan sendiri'
  ];

  List _team = [
    'Global',
    'Healthy Noona',
    'Bunda Cerdas',
  ];

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.lightGreen[200],
      body: _isLoading
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
                                  items: _waktu.map((value) {
                                    return DropdownMenuItem(
                                      child: Text(value),
                                      value: value,
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTime = value;
                                    });
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
                                    value: selectedTeam,
                                    items: _team.map((value) {
                                      return DropdownMenuItem(
                                        child: Text(value),
                                        value: value,
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedTeam = value;
                                      });
                                    },
                                  ),
                                )),
                          ),
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      /* showsDatePicker(
                      int.parse(_currentTimes),
                    ), */
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
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
                              /* Flexible(
                              flex: 17,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: CustomImage.getProductImage(rankBestProducts[index].image)
                              ),
                            ), */
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
                                        'Produk A'
                                        /* rankBestProducts[index].name, */,
                                        softWrap: true,
                                        style: TextStyle(
                                            color: index < 3
                                                ? AppTheme.text_darker
                                                : AppTheme.text_light,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'SKU A'
                                        /* rankBestProducts[index].sku */,
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
                                    '50'
                                    /* rankBestProducts[index].rankValue */,
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
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
