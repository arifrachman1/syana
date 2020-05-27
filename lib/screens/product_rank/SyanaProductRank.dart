import 'package:flutter/material.dart';
import 'package:syana/screens/product_rank/SyanaProductRankGlobal.dart';
import 'package:syana/screens/product_rank/SyanaProductRankGrafikTim.dart';
import 'package:syana/screens/product_rank/SyanaProductRankProduct.dart';
import 'package:syana/screens/product_rank/SyanaProductRankTerbaik.dart';
import 'package:syana/screens/product_rank/SyanaProductRankTerlaris.dart';
import 'package:syana/screens/product_rank/SyanaProductRankTop50Customer.dart';
import 'package:syana/screens/product_rank/SyanaProductRankTopFree.dart';
import 'package:syana/screens/product_rank/SyanaProductRankTopKurir.dart';
import 'package:syana/screens/product_rank/SyanaProductRankTopLokasi.dart';
import 'package:syana/screens/product_rank/SyanaProductRankTopReturn.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/widgets/CustomBottomNav.dart';
import '../../main.dart';

class ProductRank extends StatefulWidget {
  @override
  ProductRankState createState() => ProductRankState();
}

class ProductRankState extends State<ProductRank>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 10, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNav.getBottomNav(context, 3),
      body: Container(
        decoration: AppTheme.appBackground(),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: 
                  Container(
              decoration: AppTheme.tabbarDecoration(),
              height: 50,
              margin: EdgeInsets.only(top: 35),
              child: TabBar(
                isScrollable: true,
                controller: tabController,
                indicatorColor: AppTheme.teal,
                unselectedLabelColor: AppTheme.teal,
                labelColor: AppTheme.teal,
                tabs: <Widget>[
                  Container(
                    child: Text(
                      'Top FREE',
                      softWrap: false,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Terlaris',
                      softWrap: false,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Terbaik',
                      softWrap: false,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Grafik Global',
                      softWrap: false,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Grafik Tim',
                      softWrap: false,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Grafik Produk',
                      softWrap: false,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Top Return',
                      softWrap: false,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Top Kurir',
                      softWrap: false,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Top Lokasi',
                      softWrap: false,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Container(
                    child: Text(
                      'Top 50 Customer',
                      softWrap: false,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10.0),
                child: TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    SyanaProductRankTopFree(),
                    SyanaProductRankTerlaris(),
                    SyanaProductRankTerbaik(),
                    GrafikGlobal(),
                    GrafikTim(),
                    GrafikProduk(),
                    SyanaProductRankTopReturn(),
                    SyanaProductRankTopKurir(),
                    SyanaProductRankTopLokasi(),
                    SyanaProductRankTop50Customer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
