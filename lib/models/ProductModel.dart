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
      _rankValue;

  ProductModel(){
    _freeNumber = "0";
    _saleNumber = "0";
  }

  ProductModel.productList(this._id, this._name, this._image, this._idCategory,
      this._sku, this._price, this._categoryName, this._saleNumber,
      this._freeNumber);


  ProductModel.productStock(this._id, this._status, this._name, this._image,
      this._point, this._stock, this._criticalStock, this._weight, this._sku,
      this._price);

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

  Map<String,dynamic> toJson(){
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
      "rank_value": this._rankValue
    };
  }

  @override
  String toString() {
    return 'ProductModel{_id: $_id, _name: $_name, _sku: $_sku, _saleNumber: $_saleNumber, _freeNumber: $_freeNumber}';
  }

/*static List encondeToJson(List<ProductModel>list){
    List jsonList = List();
    list.map((item)=>
        jsonList.add(item.toJson())
    ).toList();
    return jsonList;
  }*/


}
