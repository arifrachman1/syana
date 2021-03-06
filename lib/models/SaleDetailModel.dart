import 'dart:convert';

class SaleDetailModel {
  String _id,
      _idSale,
      _idProduct,
      _productName,
      _saleNumber,
      _freeNumber,
      _point,
      _sku,
      _price,
      _weight,
      _status;

  int _currentSaleNum, _profitBruto, _profitNetto, _omzet, _cost;

  SaleDetailModel();

  SaleDetailModel.init(
    this._id,
    this._idSale,
    this._idProduct,
    this._productName,
    this._saleNumber,
    this._freeNumber,
    this._point,
    this._sku,
    this._price,
    this._weight,
    this._currentSaleNum,
  );

  SaleDetailModel.initSummary(
      this._id,
      this._idSale,
      this._saleNumber,
      this._freeNumber,
      this._profitBruto,
      this._profitNetto,
      this._omzet,
      this._productName,
      this._cost);

  get status => _status;

  set status(value) {
    _status = value;
  }

  get currentSaleNum => _currentSaleNum;

  set currentSaleNum(value) {
    _currentSaleNum = value;
  }

  get weight => _weight;

  set weight(value) {
    _weight = value;
  }

  get price => _price;

  set price(value) {
    _price = value;
  }

  get sku => _sku;

  set sku(value) {
    _sku = value;
  }

  get point => _point;

  set point(value) {
    _point = value;
  }

  get saleNumber => _saleNumber;

  set saleNumber(value) {
    _saleNumber = value;
  }

  get productName => _productName;

  set productName(value) {
    _productName = value;
  }

  get idProduct => _idProduct;

  set idProduct(value) {
    _idProduct = value;
  }

  get idSale => _idSale;

  set idSale(value) {
    _idSale = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  get freeNumber => _freeNumber;

  set freeNumber(value) {
    _freeNumber = value;
  }

  get profitBruto => _profitBruto;

  set profitBruto(value) {
    _profitBruto = value;
  }

  get profitNetto => _profitNetto;

  set profitNetto(value) {
    _profitNetto = value;
  }

  get omzet => _omzet;

  set omzet(value) {
    _omzet = value;
  }

  get cost => _cost;

  set cost(value) {
    _cost = value;
  }

  toJson() {
    Map model = {
      "id": _id,
      "id_sale": _idSale,
      "id_product": _idProduct,
      "product_name": _productName,
      "sale_number": _saleNumber,
      "free_number": _freeNumber,
      "point": _point,
      "sku": _sku,
      "price": _price,
      "weight": _weight,
      "status": _status,
      "current_sale_num": _currentSaleNum,
      "profit_bruto": _profitBruto,
      "profit_netto": _profitNetto,
      "omzet": _omzet,
      "cost": _cost
    };

    return json.encode(model);
  }

  fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.idSale = json['id_sale'];
    this.idProduct = json['id_product'];
    this.productName = json['product_name'];
    this.saleNumber = json['sale_number'];
    this.freeNumber = json['free_number'];
    this.point = json['point'];
    this.sku = json['sku'];
    this.price = json['price'];
    this.weight = json['weight'];
    this.status = json['status'];
    this.currentSaleNum = json['current_sale_num'] != null
        ? int.parse(json['current_sale_num'].toString())
        : null;
    this.profitBruto = int.parse(json['profit_bruto'].toString());
    this.profitNetto = int.parse(json['profit_netto'].toString());
    this.omzet = int.parse(json['omzet'].toString());
    this.cost = int.parse(json['cost'].toString());
  }

  @override
  String toString() {
    return 'SaleDetailModel{_id: $_id, _idSale: $_idSale, _idProduct: $_idProduct, _productName: $_productName, _saleNumber: $_saleNumber, _point: $_point, _sku: $_sku, _price: $_price, _weight: $_weight, _currentSaleNum: $_currentSaleNum}, _status: $_status}';
  }
}
