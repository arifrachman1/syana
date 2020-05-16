class HomeDataDetailModel {
  String _idTeam, _packageToday, _packageYesterday, _packageThisMonth;
  String _pointThisMonth, _pointLastMonth, _pointToday, _pointYesterday;
  String _teamName;

  HomeDataDetailModel(this._idTeam, this._packageToday, this._packageYesterday,
      this._packageThisMonth, this._pointThisMonth, this._pointLastMonth,
      this._pointToday, this._pointYesterday, this._teamName);

  String get teamName => _teamName;

  set teamName(String value) {
    _teamName = value;
  }

  double get pointYesterday => double.parse(_pointYesterday);

  set pointYesterday(value) {
    _pointYesterday = value;
  }

  double get pointToday => double.parse(_pointToday);

  set pointToday(value) {
    _pointToday = value;
  }

  double get pointLastMonth => double.parse(_pointLastMonth);

  set pointLastMonth(value) {
    _pointLastMonth = value;
  }

  double get pointThisMonth => double.parse(_pointThisMonth);

  set pointThisMonth(value) {
    _pointThisMonth = value;
  }

  get packageThisMonth => int.parse(_packageThisMonth);

  set packageThisMonth(value) {
    _packageThisMonth = value;
  }

  get packageYesterday => int.parse(_packageYesterday);

  set packageYesterday(value) {
    _packageYesterday = value;
  }

  get packageToday => int.parse(_packageToday);

  set packageToday(value) {
    _packageToday = value;
  }

  get idTeam => _idTeam;

  set idTeam(value) {
    _idTeam = value;
  }

  @override
  String toString() {
    return 'HomeDataDetailModel{_idTeam: $_idTeam, _packageToday: $_packageToday, _packageYesterday: $_packageYesterday, _packageThisMonth: $_packageThisMonth, _pointThisMonth: $_pointThisMonth, _pointLastMonth: $_pointLastMonth, _pointToday: $_pointToday, _pointYesterday: $_pointYesterday, _teamName: $_teamName}';
  }


}
