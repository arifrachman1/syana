class PurchasingModel {
  String _idPurchasingSubmission,
      _idxPurchasingSubmission,
      _submittedBy,
      _idProduct,
      _statusSubmission,
      _createdAt,
      _name,
      _id,
      _sku,
      _type,
      _status;
  String _idIngredient,
      _idPackaging,
      _totalItem,
      _priceItem,
      _priceTotalItem,
      _priceMaster;
  String _value;
  String _idPurchasingStatus, _approvedAt, _note, _idPurchasingImage, _image;

  PurchasingModel _purchasingModel;
  List<PurchasingModel> _listDetail = new List();
  List<PurchasingModel> _listImage = new List();
  List<PurchasingModel> _listStatus = new List();

  PurchasingModel.purchasing(this._idPurchasingSubmission, this._submittedBy,
      this._createdAt, this._status);

  PurchasingModel.listPurchasing(
      this._idPurchasingSubmission,
      this._submittedBy,
      this._idProduct,
      this._statusSubmission,
      this._createdAt,
      this._name);

  PurchasingModel.listDetailPurchasing(
      this._idProduct,
      this._idIngredient,
      this._idPackaging,
      this._name,
      this._totalItem,
      this._priceItem,
      this._priceTotalItem,
      this._value);

  PurchasingModel.listStatusPurchasing(
    this._idPurchasingStatus,
    this._status,
    this._approvedAt,
    this._note,
    this._idxPurchasingSubmission,
  );

  PurchasingModel.listImagePurchasing(
    this._idPurchasingImage,
    this._image,
    this._status,
    this._idxPurchasingSubmission,
  );

  PurchasingModel.detailPurchasing(
      this._idProduct,
      this._type,
      this._name,
      this._sku,
      this._totalItem,
      this._priceItem,
      this._priceTotalItem,
      this._priceMaster);

  PurchasingModel.masterDetail(this._purchasingModel, this._listDetail,
      this._listImage, this._listStatus);

  PurchasingModel get purchasingModel => _purchasingModel;

  set purchasingModel(PurchasingModel value) {
    _purchasingModel = value;
  }

  get id => _id;

  set id(value) {
    _id = value;
  }

  get status => _status;

  set status(value) {
    _status = value;
  }

  String get value => _value;

  set value(String value) {
    _value = value;
  }

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

  get approvedAt => _approvedAt;

  set approvedAt(value) {
    _approvedAt = value;
  }

  get statusSubmission => _statusSubmission;

  set statusSubmission(value) {
    _statusSubmission = value;
  }

  get idProduct => _idProduct;

  set idProduct(value) {
    _idProduct = value;
  }

  get idPurchasingStatus => _idPurchasingStatus;

  set idPurchasingStatus(value) {
    _idPurchasingStatus = value;
  }

  get idPurchasingImage => _idPurchasingImage;

  set idPurchasingImage(value) {
    _idPurchasingImage = value;
  }

  get idxPurchasingSubmission => _idxPurchasingSubmission;

  set idxPurchasingSubmission(value) {
    _idxPurchasingSubmission = value;
  }

  get note => _note;

  set note(value) {
    _note = value;
  }

  get image => _image;

  set image(value) {
    _image = value;
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

  Map<String, dynamic> toJson() {
    return {
      "id_product": this._idProduct,
      "id_ingredient": this._idIngredient,
      "id_packaging": this._idPackaging,
      "total_item": this._totalItem,
      "price_item": this._priceItem,
      "total_price_item": this._priceTotalItem,
    };
  }

  get type => _type;

  set type(value) {
    _type = value;
  }

  get priceMaster => _priceMaster;

  set priceMaster(value) {
    _priceMaster = value;
  }

  List<PurchasingModel> get listDetail => _listDetail;

  set listDetail(List<PurchasingModel> value) {
    _listDetail = value;
  }

  List<PurchasingModel> get listImage => _listImage;

  set listImage(List<PurchasingModel> value) {
    _listImage = value;
  }

  List<PurchasingModel> get listStatus => _listStatus;

  set listStatus(List<PurchasingModel> value) {
    _listStatus = value;
  }
}
