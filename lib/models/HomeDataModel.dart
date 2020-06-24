import 'package:syana/models/HomeDataDetailModel.dart';

class HomeDataModel {
  String _day,
      _totalPackageSentToday,
      _totalPackageSentThisMonth,
      _myTeamPackageSentToday;
  String _productSoldToday,
      _productSoldYesterday,
      _productSoldThisMonth,
      _productSoldLastMonth;
  String _allTeamPointThisMonth,
      _allTeamPointLastMonth,
      _grandTotalPoint,
      _grandTotalPackage,
      _grandTotalPointTeam,
      _grandTotalPackageTeam;
  String _myTeamQuote;
  List<HomeDataDetailModel> _detail;

  HomeDataModel();

  HomeDataModel.starSeller(
      this._day,
      this._totalPackageSentToday,
      this._myTeamPackageSentToday,
      this._productSoldToday,
      this._productSoldYesterday,
      this._productSoldThisMonth,
      this._productSoldLastMonth,
      this._allTeamPointThisMonth,
      this._allTeamPointLastMonth,
      this._grandTotalPoint,
      this._grandTotalPackage,
      this._grandTotalPointTeam,
      this._grandTotalPackageTeam,
      this._myTeamQuote,
      this._detail);

  HomeDataModel.Owner(
      this._day,
      this._totalPackageSentToday,
      this._totalPackageSentThisMonth,
      this._productSoldToday,
      this._productSoldYesterday,
      this._productSoldThisMonth,
      this._productSoldLastMonth,
      this._allTeamPointThisMonth,
      this._allTeamPointLastMonth,
      this._grandTotalPoint,
      this._grandTotalPackage,
      this._grandTotalPointTeam,
      this._grandTotalPackageTeam,
      this._detail);

  List<HomeDataDetailModel> get detail => _detail;

  set detail(List<HomeDataDetailModel> value) {
    _detail = value;
  }

  String get myTeamQuote => _myTeamQuote;

  set myTeamQuote(String value) {
    _myTeamQuote = value;
  }

  get grandTotalPackageTeam => int.parse(_grandTotalPackageTeam);

  set grandTotalPackageTeam(value) {
    _grandTotalPackageTeam = value;
  }

  double get grandTotalPointTeam => double.parse(_grandTotalPointTeam);

  set grandTotalPointTeam(value) {
    _grandTotalPointTeam = value;
  }

  get grandTotalPackage => int.parse(_grandTotalPackage);

  set grandTotalPackage(value) {
    _grandTotalPackage = value;
  }

  double get grandTotalPoint => double.parse(_grandTotalPoint);

  set grandTotalPoint(value) {
    _grandTotalPoint = value;
  }

  get allTeamPointLastMonth => double.parse(_allTeamPointLastMonth);

  set allTeamPointLastMonth(value) {
    _allTeamPointLastMonth = value;
  }

  get allTeamPointThisMonth => double.parse(_allTeamPointThisMonth);

  set allTeamPointThisMonth(value) {
    _allTeamPointThisMonth = value;
  }

  get myTeamPackageSentToday =>
      _myTeamPackageSentToday != null ? _myTeamPackageSentToday : "0";

  set myTeamPackageSentToday(value) {
    _myTeamPackageSentToday = value;
  }

  get totalPackageSentToday => int.parse(_totalPackageSentToday);

  set totalPackageSentToday(value) {
    _totalPackageSentToday = value;
  }

  get day => _day;

  set day(value) {
    _day = value;
  }

  get totalPackageSentThisMonth => _totalPackageSentThisMonth;

  set totalPackageSentThisMonth(value) {
    _totalPackageSentThisMonth = value;
  }

  get productSoldLastMonth => _productSoldLastMonth;

  set productSoldLastMonth(value) {
    _productSoldLastMonth = value;
  }

  get productSoldThisMonth => _productSoldThisMonth;

  set productSoldThisMonth(value) {
    _productSoldThisMonth = value;
  }

  get productSoldYesterday => _productSoldYesterday;

  set productSoldYesterday(value) {
    _productSoldYesterday = value;
  }

  String get productSoldToday => _productSoldToday;

  set productSoldToday(String value) {
    _productSoldToday = value;
  }


}
