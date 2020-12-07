class MaterialModel {
  String _id, _price;
  String _name, _sku, _code;


  MaterialModel.listMaterial(this._id, this._price, this._name, this._sku, this._code);

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  get price => _price;

  get code => _code;

  set code(value) {
    _code = value;
  }

  get sku => _sku;

  set sku(value) {
    _sku = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  set price(value) {
    _price = value;
  }

  @override
  String toString() {
    return 'MaterialModel{_id: $_id, _price: $_price, _name: $_name, _sku: $_sku, _code: $_code}';
  }
}