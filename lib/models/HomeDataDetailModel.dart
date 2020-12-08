class HomeDataDetailModel implements Comparable {
  String _idTeam, _packageToday, _packageYesterday, _packageThisMonth, _packageLastMonth;
  String _pointThisMonth, _pointLastMonth, _pointToday, _pointYesterday;
  String _teamName;

  HomeDataDetailModel(
      this._idTeam,
      this._packageToday,
      this._packageYesterday,
      this._packageThisMonth,
      this._pointThisMonth,
      this._pointLastMonth,
      this._pointToday,
      this._pointYesterday,
      this._teamName, this._packageLastMonth);

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


  get packageLastMonth => _packageLastMonth;

  set packageLastMonth(value) {
    _packageLastMonth = value;
  }

  @override
  String toString() {
    return 'HomeDataDetailModel\n{_idTeam: $_idTeam,\n _packageToday: $_packageToday,\n _packageYesterday: $_packageYesterday,\n _packageThisMonth: $_packageThisMonth,\n _pointThisMonth: $_pointThisMonth,\n _pointLastMonth: $_pointLastMonth,\n _pointToday: $_pointToday,\n _pointYesterday: $_pointYesterday,\n _teamName: $_teamName}';
  }

  /*12-06-2020 revision
  * to implement comparable, then add a compareTo function
  * to compare each values*/
  @override
  int compareTo(other) {
    if (other is HomeDataDetailModel) {
      int a = int.parse(this.packageThisMonth.toString()),
          b = int.parse(other.packageThisMonth.toString());

      return b - a;
    }
  }
}
