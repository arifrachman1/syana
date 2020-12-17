import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaPayoutMonitoringOwner extends StatefulWidget {
  @override
  _SyanaPayoutMonitoringOwnerState createState() =>
      _SyanaPayoutMonitoringOwnerState();
}

class _SyanaPayoutMonitoringOwnerState
    extends State<SyanaPayoutMonitoringOwner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.appBackground(),
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 20, top: 50),
          child: Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 35.0,
                      color: Colors.white,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 25.0)),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Payout',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 30.0)),
              Container(
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    hintText: "Cari karyawan...",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 32.0),
                        borderRadius: BorderRadius.circular(18.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 32.0),
                        borderRadius: BorderRadius.circular(18.0)),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 32.0),
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 40.0)),
              Flexible(
                child: SizedBox(
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 5.0)),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                            width: 276,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
