import 'package:flutter/material.dart';
import 'package:syana/Controller/ShortcutController.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/GlobalVars.dart';
import 'package:syana/widgets/CustomButton.dart';

class ShortcutSettings extends StatefulWidget {
  _ShortcutState createState() => _ShortcutState();
}

class _ShortcutState extends State<ShortcutSettings> {
  ShortcutController _shortcutController;
  List<int> _currentShortcuts = new List(3);
  List<DropdownMenuItem> _shortcutItems = new List();

  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _shortcutController = new ShortcutController();
    _initData();
  }

  _initData() async {
    setLoadingState();
    setState(() {
      _shortcutItems = _shortcutController.generateList();
      _currentShortcuts[0] = _shortcutItems[0].value;
      _currentShortcuts[1] = _shortcutItems[0].value;
      _currentShortcuts[2] = _shortcutItems[0].value;

    });

    _currentShortcuts = await _shortcutController.getShortcuts();

    setLoadingState();
  }

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

  save() {
    _shortcutController.setShortcuts({
      GlobalVars.firstShortcutKey: _currentShortcuts[0],
      GlobalVars.secondShortcutKey: _currentShortcuts[1],
      GlobalVars.thirdShortcutKey: _currentShortcuts[2]
    }, context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.lightGreen[200],
          title: Text('Konfigurasi Shortcut'),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
          decoration: AppTheme.appBackground(),
          child: LayoutBuilder(
            builder: (_, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints:
                  BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Shortcut 1"),
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                            value: _currentShortcuts[0],
                            items: _shortcutItems,
                            onChanged: (value) {
                              setState(() {
                                _currentShortcuts[0] = value;
                              });
                            }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Shortcut 2"),
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                            value: _currentShortcuts[1],
                            items: _shortcutItems,
                            onChanged: (value) {
                              setState(() {
                                _currentShortcuts[1] = value;
                              });
                            }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Shortcut 3"),
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                            value: _currentShortcuts[2],
                            items: _shortcutItems,
                            onChanged: (value) {
                              setState(() {
                                _currentShortcuts[2] = value;
                              });
                            }),
                      ),
                    ],
                  ),
                  CustomButton.getCustomButton(
                      context: context,
                      callbackFunction: save,
                      buttonText: "Simpan")
                  ],
                ),
              ),);
            },
          ),
        ));
  }

  _shortcutSetting() {
    return Row(
      children: <Widget>[
        Text("Shortcut 1"),
        DropdownButtonHideUnderline(
          child: DropdownButton(
              value: _currentShortcuts[0],
              items: _shortcutItems,
              onChanged: (value) {
                setState(() {
                  _currentShortcuts[0] = value;
                });
              }),
        ),
      ],
    );
  }
}
