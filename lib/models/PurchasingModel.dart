class PurchasingModel{
  String _idPurchasingSubmission, _submittedBy, _idProduct, _statusSubmission, _createdAt, _name, _sku;
  String _idIngredient, _idPackaging, _totalItem, _priceItem, _priceTotalItem;

  PurchasingModel.listPurchasing(this._idPurchasingSubmission, this._submittedBy,
      this._idProduct, this._statusSubmission, this._createdAt, this._name);


  PurchasingModel.listDetailPurchasing(this._idProduct, this._idIngredient, this._idPackaging,
      this._totalItem, this._priceItem, this._priceTotalItem);

  String get idIngredient => _idIngredient;

  set idIngredient(String value) {
    _idIngredient = value;
  }

  get name => _name;

  set name(value) {
    _name = value;
  }

  get createdAt => _createdAt;

  set createdAt(value) {
    _createdAt = value;
  }

  get statusSubmission => _statusSubmission;

  set statusSubmission(value) {
    _statusSubmission = value;
  }

  get idProduct => _idProduct;

  set idProduct(value) {
    _idProduct = value;
  }

  get submittedBy => _submittedBy;

  set submittedBy(value) {
    _submittedBy = value;
  }

  String get idPurchasingSubmission => _idPurchasingSubmission;

  set idPurchasingSubmission(String value) {
    _idPurchasingSubmission = value;
  }

  get sku => _sku;

  set sku(value) {
    _sku = value;
  }

  get idPackaging => _idPackaging;

  set idPackaging(value) {
    _idPackaging = value;
  }

  get totalItem => _totalItem;

  set totalItem(value) {
    _totalItem = value;
  }

  get priceItem => _priceItem;

  set priceItem(value) {
    _priceItem = value;
  }

  get priceTotalItem => _priceTotalItem;

  set priceTotalItem(value) {
    _priceTotalItem = value;
  }
}