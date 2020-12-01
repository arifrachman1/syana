class ProductModel {
  String _id,
      _status,
      _name,
      _image,
      _point,
      _stock,
      _criticalStock,
      _weight,
      _idCategory,
      _idCreator,
      _sku,
      _price,
      _type,
      _categoryName,
      _saleNumber,
      _freeNumber,
      _rankValue,
      _createAt,
      _totalItem;

  ProductModel() {
    _freeNumber = "0";
    _saleNumber = "0";
  }

  ProductModel.productList(
      this._id,
      this._name,
      this._image,
      this._idCategory,
      this._sku,
      this._price,
      this._categoryName,
      this._saleNumber,
      this._freeNumber,
      this._createAt,
      this._totalItem);

  ProductModel.productStock(
      this._id,
      this._status,
      this._name,
      this._image,
      this._point,
      this._stock,
      this._criticalStock,
      this._weight,
      this._sku,
      this._price);

  ProductModel.productRank(
      this._id, this._name, this._image, this._sku, this._rankValue);

  ProductModel.rankTopData(this._name, this._rankValue);

  ProductModel.productsDropdown(this._id, this._name);

  ProductModel.productSuggestions(this._id, this._name, this._sku);

  ProductModel.materialRank(this._name, this._createAt, this._sku, this._totalItem, this._type);

  ProductModel.init(
      this._id,
      this._status,
      this._name,
      this._image,
      this._point,
      this._stock,
      this._criticalStock,
      this._weight,
      this._idCategory,
      this._idCreator,
      this._sku,
      this._price,
      this._type);

  get rankValue => _rankValue;

  set rankValue(value) {
    _rankValue = value;
  }

  get freeNumber => _freeNumber;

  set freeNumber(int value) {
    _freeNumber = value.toString();
  }

  get saleNumber => _saleNumber;

  set saleNumber(int value) {
    _saleNumber = value.toString();
  }

  get categoryName => _categoryName;

  set categoryName(value) {
    _categoryName = value;
  }

  get type => _type;

  set type(value) {
    _type = value;
  }

  get price => _price;

  set price(value) {
    _price = value;
  }

  get sku => _sku;

  set sku(value) {
    _sku = value;
  }

  get idCreator => _idCreator;

  set idCreator(value) {
    _idCreator = value;
  }

  get idCategory => _idCategory;

  set idCategory(value) {
    _idCategory = value;
  }

  get weight => _weight;

  set weight(value) {
    _weight = value;
  }

  get criticalStock => _criticalStock;

  set criticalStock(value) {
    _criticalStock = value;
  }

  get stock => _stock;

  set stock(value) {
    _stock = value;
  }

  get point => _point;

  set point(value) {
    _point = value;
  }

  get image => _image;

  set image(value) {
    _image = value;
  }

  get name => _name;

  set name(value) {
    _name = value;
  }

  get status => _status;

  set status(value) {
    _status = value;
  }

  get id => _id;

  set id(value) {
    _id = value;
  }

  get createAt => _createAt;

  set createAt(value) {
    _createAt = value;
  }

  get totalItem => _totalItem;

  set totalItem(value) {
    _totalItem = value;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this._id,
      "name": this._name,
      "image": this._image,
      "point": this._point,
      "stock": this._stock,
      "critical_stock": this._criticalStock,
      "weight": this._weight,
      "id_category": this._idCategory,
      "id_creator": this._idCreator,
      "sku": this._sku,
      "price": this._price,
      "type": this._type,
      "category_name": this._categoryName,
      "sale_number": this._saleNumber,
      "free_number": this._freeNumber,
      "rank_value": this._rankValue,
      "create_at": this._createAt,
      "total_item": this._totalItem,
    };
  }

  @override
  String toString() {
    return 'ProductModel{_id: $_id, _name: $_name, _sku: $_sku, _saleNumber: $_saleNumber, _freeNumber: $_freeNumber, _createAt: $_createAt, _totalItem: $_totalItem}';
  }

/*static List encondeToJson(List<ProductModel>list){
    List jsonList = List();
    list.map((item)=>
        jsonList.add(item.toJson())
    ).toList();
    return jsonList;
  }*/

}
