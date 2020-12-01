import 'package:flutter/material.dart';
import 'package:syana/models/UserModel.dart';
import 'package:syana/screens/product_rank/SyanaIngrendientsRank.dart';
import 'package:syana/screens/product_rank/SyanaOverview.dart';
import 'package:syana/screens/product_rank/SyanaPackagingRank.dart';
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
import 'package:syana/screens/product_rank/SyanaSummary.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/widgets/CustomBottomNav.dart';
import 'package:syana/widgets/CustomShortcut.dart';

class ProductRank extends StatefulWidget {
  int shortcutNavigator;

  ProductRank({this.shortcutNavigator});

  @override
  ProductRankState createState() => ProductRankState();
}
/*TODO THIS PAGE HAS ROLE CONFIGURATION*/
class ProductRankState extends State<ProductRank> with SingleTickerProviderStateMixin {
  TabController tabController;
  UserModel _userModel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
	  setLoadingState();

	  _userModel = await GlobalFunctions.getPersistence();

	  tabController = TabController(
			  vsync: this,
			  length: _userModel.idRole == 2 ? 14 : 12,
			  initialIndex: widget.shortcutNavigator != null
					  ? (widget.shortcutNavigator == CustomShortcut.SHORTCUT_PRODUCT_RANK_TOP_FREE
					  ? 0
					  : widget.shortcutNavigator == CustomShortcut.SHORTCUT_PRODUCT_RANK_BEST_SELLING
					  ? 1
					  : widget.shortcutNavigator == CustomShortcut.SHORTCUT_PRODUCT_RANK_BEST
					  ? 2
					  : widget.shortcutNavigator == CustomShortcut.SHORTCUT_PRODUCT_RANK_GLOBAL_CHART
					  ? 3
					  : widget.shortcutNavigator == CustomShortcut.SHORTCUT_PRODUCT_RANK_TEAM_CHART
					  ? 4
					  : widget.shortcutNavigator == CustomShortcut.SHORTCUT_PRODUCT_RANK_PRODUCT_CHART
					  ? 5
					  : widget.shortcutNavigator == CustomShortcut.SHORTCUT_PRODUCT_RANK_TOP_RETURNS
					  ? 6
					  : widget.shortcutNavigator == CustomShortcut.SHORTCUT_PRODUCT_RANK_TOP_COURIERS
					  ? 7
					  : widget.shortcutNavigator == CustomShortcut.SHORTCUT_PRODUCT_RANK_TOP_LOCATIONS
					  ? 8
					  : widget.shortcutNavigator == CustomShortcut.SHORTCUT_PRODUCT_RANK_TOP_CUSTOMERS
					  ? 9
					  : widget.shortcutNavigator == CustomShortcut.SHORTCUT_INGRENDIENTS_RANK
					  ? 10
					  : widget.shortcutNavigator == CustomShortcut.SHORTCUT_PACKAGING_RANK
					  ? 11
					  : _userModel.idRole == 2
					  ? (widget.shortcutNavigator == CustomShortcut.SHORTCUT_OVERVIEW
					  ? 12
					  : widget.shortcutNavigator == CustomShortcut.SHORTCUT_OVERVIEW ? 13 : 1)
					  : 1)
					  : 1);

	  setLoadingState();
  }

  setLoadingState() {
	  setState(() {
		  _isLoading = !_isLoading;
	  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNav.getBottomNav(context, 3),
      body: Container(
        decoration: AppTheme.appBackground(),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
	      child: _isLoading
			      ? CircularProgressIndicator()
			      : Column(
		      children: <Widget>[
			      Row(
				      children: <Widget>[
					      _userModel.idRole == 2
							      ? Expanded(
						      child: Container(
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
									      Container(
										      child: Text(
											      'Ingrendients Rank',
											      softWrap: false,
											      style: TextStyle(fontSize: 13),
										      ),
									      ),
									      Container(
										      child: Text(
											      'Packaging Rank',
											      softWrap: false,
											      style: TextStyle(fontSize: 13),
										      ),
									      ),
									      Container(
										      child: Text(
											      'Overview',
											      softWrap: false,
											      style: TextStyle(fontSize: 13),
										      ),
									      ),
									      Container(
										      child: Text(
											      'Summary',
											      softWrap: false,
											      style: TextStyle(fontSize: 13),
										      ),
									      ),
								      ],
							      ),
						      ),
					      )
							      : Expanded(
						      child: Container(
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
									      Container(
										      child: Text(
											      'Ingrendients Rank',
											      softWrap: false,
											      style: TextStyle(fontSize: 13),
										      ),
									      ),
									      Container(
										      child: Text(
											      'Packaging Rank',
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
					      child: _userModel.idRole == 2
							      ? TabBarView(
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
							      SyanaIngrendientsRank(),
							      SyanaPackagingRank(),
							      SyanaOverview(),
							      SyanaSummary()
						      ],
					      )
							      : TabBarView(
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
							      SyanaIngrendientsRank(),
							      SyanaPackagingRank()
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
