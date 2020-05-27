class PromoDetailOutModel{
  String _idPromoDetailOut, _idPromoDetail, _idProductFree, _amountFree;


  PromoDetailOutModel.init(this._idPromoDetailOut, this._idPromoDetail,
      this._idProductFree, this._amountFree);

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

  @override
  String toString() {
    return 'PromoDetailOutModel{_idPromoDetailOut: $_idPromoDetailOut, _idPromoDetail: $_idPromoDetail, _idProductFree: $_idProductFree, _amountFree: $_amountFree}';
  }


}