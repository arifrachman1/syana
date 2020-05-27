class PromoDetailInModel {
  String _idPromoDetailIn,
      _idPromoDetail,
      _idProductRequired,
      _amountRequired,
      _requiredType;


  PromoDetailInModel.init(this._idPromoDetailIn, this._idPromoDetail,
      this._idProductRequired, this._amountRequired, this._requiredType);

  String get idPromoDetailIn => _idPromoDetailIn;

  set idPromoDetailIn(String value) {
    _idPromoDetailIn = value;
  }

  get idPromoDetail => _idPromoDetail;

  get requiredType => _requiredType;

  set requiredType(value) {
    _requiredType = value;
  }

  get amountRequired => _amountRequired;

  set amountRequired(value) {
    _amountRequired = value;
  }

  get idProductRequired => _idProductRequired;

  set idProductRequired(value) {
    _idProductRequired = value;
  }

  set idPromoDetail(value) {
    _idPromoDetail = value;
  }

  @override
  String toString() {
    return 'PromoDetailInModel{_idPromoDetailIn: $_idPromoDetailIn, _idPromoDetail: $_idPromoDetail, _idProductRequired: $_idProductRequired, _amountRequired: $_amountRequired, _requiredType: $_requiredType}';
  }
}
