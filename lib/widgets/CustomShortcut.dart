import 'package:flutter/material.dart';
import 'package:syana/screens/home/SyanaBroadcastMessage.dart';
import 'package:syana/screens/inventory/SyanaStock.dart';
import 'package:syana/screens/product_rank/SyanaProductRank.dart';
import 'package:syana/screens/promo/SyanaPromo.dart';
import 'package:syana/screens/trace/SyanaTrace.dart';

class CustomShortcut {
  static const int SHORTCUT_INVENTORY_IN = 1,
      SHORTCUT_INVENTORY_STOCK = 2,
      SHORTCUT_INVENTORY_EX = 3,
      SHORTCUT_PRODUCT_RANK_TOP_FREE = 4,
      SHORTCUT_PRODUCT_RANK_BEST_SELLING = 5,
      SHORTCUT_PRODUCT_RANK_BEST = 6,
      SHORTCUT_PRODUCT_RANK_GLOBAL_CHART = 7,
      SHORTCUT_PRODUCT_RANK_TEAM_CHART = 8,
      SHORTCUT_PRODUCT_RANK_PRODUCT_CHART = 9,
      SHORTCUT_PRODUCT_RANK_TOP_RETURNS = 10,
      SHORTCUT_PRODUCT_RANK_TOP_COURIERS = 11,
      SHORTCUT_PRODUCT_RANK_TOP_LOCATIONS = 12,
      SHORTCUT_PRODUCT_RANK_TOP_CUSTOMERS = 13,
      SHORTCUT_PROFILE_ = 14,
      SHORTCUT_PROFILE_TRIPS = 15,
      SHORTCUT_PROFILE_MY_POINTS = 16,
      SHORTCUT_PROMO = 17,
      SHORTCUT_TRACES = 18,
      SHORTCUT_BROADCAST = 19,
      SHORTCUT_EMPTY = 99,
      SHORTCUT_INGRENDIENTS_RANK = 20,
      SHORTCUT_PACKAGING_RANK = 21,
		  SHORTCUT_OVERVIEW = 22,
		  SHORTCUT_SUMMARY = 23;

  static getShortcut(menu, context) {
    switch (menu) {
      case SHORTCUT_EMPTY:
        return IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            /*Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return InventoryMain(shortcutNavigator: SHORTCUT_INVENTORY_IN,);
            }));*/
            /*Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return StockMain();
            }));*/
          },
        );
        break;
      case SHORTCUT_INVENTORY_IN:
        return IconButton(
          icon: Icon(Icons.sort),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return InventoryMain(
                shortcutNavigator: SHORTCUT_INVENTORY_IN,
              );
            }));
            /*Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return StockMain();
            }));*/
          },
        );
        break;
      case SHORTCUT_INVENTORY_STOCK:
        return IconButton(
          icon: Icon(Icons.sort),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return InventoryMain(
                shortcutNavigator: SHORTCUT_INVENTORY_STOCK,
              );
            }));
            /*Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return StockMain();
            }));*/
          },
        );
        break;
      case SHORTCUT_INVENTORY_EX:
        return IconButton(
          icon: Icon(Icons.sort),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return InventoryMain(
                shortcutNavigator: SHORTCUT_INVENTORY_EX,
              );
            }));
            /*Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return StockMain();
            }));*/
          },
        );
        break;
      case SHORTCUT_PROMO:
        return IconButton(
          icon: Icon(Icons.attach_money),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return SyanaPromo();
            }));
            /*Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return StockMain();
            }));*/
          },
        );
        break;
      case SHORTCUT_TRACES:
        return IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return SyanaHomeTrace();
                },
              ),
            );
            /*Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return StockMain();
            }));*/
          },
        );
        break;
      case SHORTCUT_PRODUCT_RANK_TOP_FREE:
        return IconButton(
          icon: Icon(Icons.insert_chart),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
	                return ProductRank(
		                shortcutNavigator: SHORTCUT_PRODUCT_RANK_TOP_FREE,
	                );
                },
              ),
            );
            /*Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return StockMain();
            }));*/
          },
        );
        break;
      case SHORTCUT_PRODUCT_RANK_BEST_SELLING:
        return IconButton(
          icon: Icon(Icons.insert_chart),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
	                return ProductRank(
		                shortcutNavigator: SHORTCUT_PRODUCT_RANK_BEST_SELLING,
	                );
                },
              ),
            );
            /*Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return StockMain();
            }));*/
          },
        );
        break;
      case SHORTCUT_PRODUCT_RANK_BEST:
        return IconButton(
          icon: Icon(Icons.insert_chart),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
	                return ProductRank(
		                shortcutNavigator: SHORTCUT_PRODUCT_RANK_BEST,
	                );
                },
              ),
            );
            /*Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return StockMain();
            }));*/
          },
        );
        break;
      case SHORTCUT_PRODUCT_RANK_GLOBAL_CHART:
        return IconButton(
          icon: Icon(Icons.show_chart),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
	                return ProductRank(
		                shortcutNavigator: SHORTCUT_PRODUCT_RANK_GLOBAL_CHART,
	                );
                },
              ),
            );
            /*Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return StockMain();
            }));*/
          },
        );
        break;
      case SHORTCUT_PRODUCT_RANK_TEAM_CHART:
        return IconButton(
          icon: Icon(Icons.show_chart),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
	                return ProductRank(
		                shortcutNavigator: SHORTCUT_PRODUCT_RANK_TEAM_CHART,
	                );
                },
              ),
            );
            /*Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return StockMain();
            }));*/
          },
        );
        break;
      case SHORTCUT_PRODUCT_RANK_PRODUCT_CHART:
        return IconButton(
          icon: Icon(Icons.show_chart),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
	                return ProductRank(
		                shortcutNavigator: SHORTCUT_PRODUCT_RANK_PRODUCT_CHART,
	                );
                },
              ),
            );
            /*Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return StockMain();
            }));*/
          },
        );
        break;
      case SHORTCUT_PRODUCT_RANK_TOP_RETURNS:
        return IconButton(
          icon: Icon(Icons.backspace),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
	                return ProductRank(
		                shortcutNavigator: SHORTCUT_PRODUCT_RANK_TOP_RETURNS,
	                );
                },
              ),
            );
            /*Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return StockMain();
            }));*/
          },
        );
        break;
      case SHORTCUT_PRODUCT_RANK_TOP_COURIERS:
        return IconButton(
          icon: Icon(Icons.local_shipping),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
	                return ProductRank(
		                shortcutNavigator: SHORTCUT_PRODUCT_RANK_TOP_COURIERS,
	                );
                },
              ),
            );
            /*Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return StockMain();
            }));*/
          },
        );
        break;
      case SHORTCUT_PRODUCT_RANK_TOP_LOCATIONS:
        return IconButton(
          icon: Icon(Icons.location_on),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
	                return ProductRank(
		                shortcutNavigator: SHORTCUT_PRODUCT_RANK_TOP_LOCATIONS,
	                );
                },
              ),
            );
            /*Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return StockMain();
            }));*/
          },
        );
        break;
      case SHORTCUT_PRODUCT_RANK_TOP_CUSTOMERS:
        return IconButton(
          icon: Icon(Icons.supervised_user_circle),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
	                return ProductRank(
		                shortcutNavigator: SHORTCUT_PRODUCT_RANK_TOP_CUSTOMERS,
	                );
                },
              ),
            );
            /*Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return StockMain();
            }));*/
          },
        );
        break;
      case SHORTCUT_BROADCAST:
        return IconButton(
          icon: Icon(Icons.message),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return BroadcastMessage();
                },
              ),
            );
            /*Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return StockMain();
            }));*/
          },
        );
        break;

	    case SHORTCUT_INGRENDIENTS_RANK:
        return IconButton(
          icon: Icon(Icons.insert_chart),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
	                return ProductRank(
		                shortcutNavigator: SHORTCUT_INGRENDIENTS_RANK,
	                );
                },
              ),
            );
            /*Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return StockMain();
            }));*/
          },
        );
        break;
    }
  }
}
