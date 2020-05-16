class EcommerceModel{
  String _id;
  String _name;
  String _status;

  EcommerceModel(this._id, this._name, this._status);

  int get status => int.parse(_status);

  set status(int value) {
    _status = value.toString();
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get id => int.parse(_id);

  set id(int value) {
    _id = value.toString();
  }


}