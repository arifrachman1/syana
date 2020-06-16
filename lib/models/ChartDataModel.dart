class ChartDataModel {
  String _chartValue, _chartDate, _dateMax, _dateMin;
  int _value;

  ChartDataModel.chartData(this._chartValue, this._chartDate);

  int get value => _value;

  ChartDataModel.chartTypeInt(this._value, this._chartDate);

  set value(int value) {
    _value = value;
  }

  ChartDataModel.checkMaxMin(this._dateMax, this._dateMin);

  get chartDate => _chartDate;

  set chartDate(value) {
    _chartDate = value;
  }

  get dateMax => _dateMax;

  set dateMax(value) {
    _dateMax = value;
  }

  String get chartValue => _chartValue;

  set chartValue(String value) {
    _chartValue = value;
  }

  get dateMin => _dateMin;

  set dateMin(value) {
    _dateMin = value;
  }

  @override
  String toString() {
    return 'ChartDataModel{_chartValue: $_chartValue, _chartDate: $_chartDate, _dateMax: $_dateMax, _dateMin: $_dateMin, _value: $_value}';
  }
}
