class PromoDetailOutModel{
  String _idPromoDetailOut, _idPromoDetail, _idProductFree, _amountFree, _productName;


  PromoDetailOutModel.init(this._idPromoDetailOut, this._idPromoDetail,
      this._idProductFree, this._amountFree);


  PromoDetailOutModel.createPromo(this._idProductFree, this._amountFree);


  PromoDetailOutModel.promoDetail(this._amountFree, this._productName);

  String get idPromoDetailOut => _idPromoDetailOut;

  set idPromoDetailOut(String value) {
    _idPromoDetailOut = value;
  }

  get idPromoDetail => _idPromoDetail;

  get amountFree => _amountFree;

  set amountFree(value) {
    _amountFree = value;
  }

  get idProductFree => _idProductFree;

  set idProductFree(value) {
    _idProductFree = value;
  }

  set idPromoDetail(value) {
    _idPromoDetail = value;
  }


  get productName => _productName;

  set productName(value) {
    _productName = value;
  }

  Map<String, dynamic> toJson () {
    return{
      "id_promo_detail_out" : _idPromoDetailOut,
      "id_promo_detail" : _idPromoDetail,
      "id_product_free" : _idProductFree,
      "amount_free" : _amountFree
    };
  }

  @override
  String toString() {
    return 'PromoDetailOutModel{_idPromoDetailOut: $_idPromoDetailOut, _idPromoDetail: $_idPromoDetail, _idProductFree: $_idProductFree, _amountFree: $_amountFree, _productName: $_productName}';
  }


}