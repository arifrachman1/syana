import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syana/models/UserModel.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/utils/GlobalVars.dart';
import 'package:syana/widgets/CustomShortcut.dart';

import 'dart:developer' as dev;

class ShortcutController{
  UserModel _userModel;
  String _devTitle = "shortcut controller";

  CustomerController() {
    _getPersistence();
  }

  _getPersistence() async {
    _userModel = await GlobalFunctions.getPersistence();
  }

  getShortcuts() async {
    List<int> shortcuts = new List();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    shortcuts.add(prefs.get(GlobalVars.firstShortcutKey));
    shortcuts.add(prefs.get(GlobalVars.secondShortcutKey));
    shortcuts.add(prefs.get(GlobalVars.thirdShortcutKey));

    return shortcuts;
  }
  
  setShortcuts(values, context) async{
    if(values is Map && values.isNotEmpty){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      values.forEach((key, value) {
        dev.log(key + " " + value.toString(), name: _devTitle);
        prefs.setInt(key, value);
      });

      Navigator.of(context).pop();
    }
  }

  generateList(){
    List<DropdownMenuItem> list = new List();
    list.add(new DropdownMenuItem(child: Text("Kosong"),value: CustomShortcut.SHORTCUT_EMPTY,));
    list.add(new DropdownMenuItem(child: Text("Inventory - Stok Masuk"),value: CustomShortcut.SHORTCUT_INVENTORY_IN,));
    list.add(new DropdownMenuItem(child: Text("Inventory - Stok"),value: CustomShortcut.SHORTCUT_INVENTORY_STOCK,));
    list.add(new DropdownMenuItem(child: Text("Inventory - Stok Keluar"),value: CustomShortcut.SHORTCUT_INVENTORY_EX,));
    list.add(new DropdownMenuItem(child: Text("Product Rank - Top Free"),value: CustomShortcut.SHORTCUT_PRODUCT_RANK_TOP_FREE,));
    list.add(new DropdownMenuItem(child: Text("Product Rank - Terlaku"),value: CustomShortcut.SHORTCUT_PRODUCT_RANK_BEST_SELLING,));
    list.add(new DropdownMenuItem(child: Text("Product Rank - Terbaik"),value: CustomShortcut.SHORTCUT_PRODUCT_RANK_BEST,));
    list.add(new DropdownMenuItem(child: Text("Product Rank - Grafik Global"),value: CustomShortcut.SHORTCUT_PRODUCT_RANK_GLOBAL_CHART,));
    list.add(new DropdownMenuItem(child: Text("Product Rank - Grafik Tim"),value: CustomShortcut.SHORTCUT_PRODUCT_RANK_TEAM_CHART,));
    list.add(new DropdownMenuItem(child: Text("Product Rank - Grafik Produk"),value: CustomShortcut.SHORTCUT_PRODUCT_RANK_PRODUCT_CHART,));
    list.add(new DropdownMenuItem(child: Text("Product Rank - Top Return"),value: CustomShortcut.SHORTCUT_PRODUCT_RANK_TOP_RETURNS,));
    list.add(new DropdownMenuItem(child: Text("Product Rank - Top Kurir"),value: CustomShortcut.SHORTCUT_PRODUCT_RANK_TOP_COURIERS,));
    list.add(new DropdownMenuItem(child: Text("Product Rank - Top Lokasi"),value: CustomShortcut.SHORTCUT_PRODUCT_RANK_TOP_LOCATIONS,));
    list.add(new DropdownMenuItem(child: Text("Product Rank - Top 50 Customer"),value: CustomShortcut.SHORTCUT_PRODUCT_RANK_TOP_CUSTOMERS,));
    return list;
  }
}