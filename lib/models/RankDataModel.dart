class RankDataModel {
  String _id, _rankValue, _value, _city;


  RankDataModel.top50(this._id, this._value, this._city, this._rankValue);

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  @override
  String toString() {
    return 'RankDataModel{_id: $_id, _value: $_value, _rankValue: $_rankValue, _city: $_city,}';
  }

  get rankValue => _rankValue;

  get city => _city;

  set city(value) {
    _city = value;
  }

  get value => _value;

  set value(value) {
    _value = value;
  }

  set rankValue(value) {
    _rankValue = value;
  }
}
