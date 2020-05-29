class ChartDataModel{
  String _chartValue,_chartDate;

  ChartDataModel.chartData(this._chartValue, this._chartDate);

  get chartDate => _chartDate;

  set chartDate(value) {
    _chartDate = value;
  }

  String get chartValue => _chartValue;

  set chartValue(String value) {
    _chartValue = value;
  }
}