class CourierModel{
  String _id, _name;

  CourierModel(this._id, this._name);

  get name => _name;

  set name(value) {
    _name = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  @override
  String toString() {
    return 'CourierModel{_id: $_id, _name: $_name}';
  }


}