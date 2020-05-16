import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/GlobalFunctions.dart';

class CustomBottomNav{
  static Widget getBottomNav(context, currentIndex){
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.dns),
          title: Text('Stok'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_basket),
          title: Text('Penjualan'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assessment),
          title: Text('Grafik'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          title: Text('Akun'),
        ),
      ],
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      // fixedColor: AppTheme.white,
      selectedItemColor: AppTheme.white,
      backgroundColor: AppTheme.teal_dark,
      unselectedItemColor: AppTheme.teal_light,
      onTap: (index){
        GlobalFunctions.navigate(context, index);
      },
    );
  }
}