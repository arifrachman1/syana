import 'package:syana/models/PromoDetailInModel.dart';
import 'package:syana/models/PromoDetailOutModel.dart';

class PromoDetailModel{
  String _idPromoDetail, _idPromo;
  List<PromoDetailInModel> _promoDetailIns;
  List<PromoDetailOutModel> _promoDetailOuts;

  PromoDetailModel.init(this._idPromoDetail, this._idPromo,
      this._promoDetailIns, this._promoDetailOuts);


  PromoDetailModel.createPromo(this._promoDetailIns, this._promoDetailOuts);

  String get idPromoDetail => _idPromoDetail;

  set idPromoDetail(String value) {
    _idPromoDetail = value;
  }

  get idPromo => _idPromo;

  set idPromo(value) {
    _idPromo = value;
  }

  List<PromoDetailInModel> get promoDetailIns => _promoDetailIns;

  set promoDetailIns(List<PromoDetailInModel> value) {
    _promoDetailIns = value;
  }

  List<PromoDetailOutModel> get promoDetailOuts => _promoDetailOuts;

  set promoDetailOuts(List<PromoDetailOutModel> value) {
    _promoDetailOuts = value;
  }

  Map<String, dynamic> toJson(){
    return{
      "id_promo_detail" : _idPromoDetail,
      "id_promo" : _idPromo,
      "promo_detail_in" : _promoDetailIns,
      "promo_detail_out" : _promoDetailOuts
    };
  }

  @override
  String toString() {
    return 'PromoDetailModel{_idPromoDetail: $_idPromoDetail, _idPromo: $_idPromo, _promoDetailIns: $_promoDetailIns, _promoDetailOuts: $_promoDetailOuts}';
  }


}