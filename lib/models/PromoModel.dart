import 'package:syana/models/PromoDetailInModel.dart';
import 'package:syana/models/PromoDetailModel.dart';
import 'package:syana/utils/GlobalFunctions.dart';

class PromoModel {
  String _idPromo,
      _title,
      _startDate,
      _endDate,
      _status,
      _length,
      _type,
      _teamId;
  List<PromoDetailModel> _promoDetails;

  bool _isPromoGet;

  PromoModel() {
    _isPromoGet = false;
  }

  PromoModel.init(this._idPromo, this._title, this._startDate, this._endDate,
      this._status, this._length, this._type, this._teamId, this._promoDetails, this._isPromoGet);

  PromoModel.createPromo(this._title, this._startDate, this._endDate,
      this._status, this._length, this._type, this._teamId, this._promoDetails);

  String get idPromo => _idPromo;

  set idPromo(String value) {
    _idPromo = value;
  }

  get title => _title;

  set title(value) {
    _title = value;
  }

  List<PromoDetailModel> get promoDetails => _promoDetails;

  set promoDetails(List<PromoDetailModel> value) {
    _promoDetails = value;
  }

  get teamId => _teamId;

  set teamId(value) {
    _teamId = value;
  }

  get tipe => _type;

  set tipe(value) {
    _type = value;
  }

  get length => _length;

  set length(value) {
    _length = value;
  }

  get status => _status;

  set status(value) {
    _status = value;
  }

  get endDate => _endDate;

  set endDate(value) {
    _endDate = value;
  }

  get startDate => _startDate;

  set startDate(value) {
    _startDate = value;
  }

  get type => _type;

  set type(value) {
    _type = value;
  }

  bool get isPromoGet => _isPromoGet;

  set isPromoGet(bool value) {
    _isPromoGet = value;
  }

  check(productId, productSaleNumber, {total}) {}

  checkFulfillment(promoDetailIns) {
    if (promoDetailIns is List<PromoDetailInModel>) {
      GlobalFunctions.log(
          message: "running requirement check...", name: "check_fulfillment");
      promoDetailIns.forEach((element) {
        if (element.requiredType.toString().compareTo("3") == 0) {
          if (!element.fulfilled) {
            GlobalFunctions.log(
                message: "requirements were not fulfilled",
                name: "check_fulfillment");
            return false;
          }
        }
      });
    }
    GlobalFunctions.log(
        message: "requirements were fulfilled", name: "check_fulfillment");
    return true;
  }

  Map<String, dynamic> toJson() {
    return {
      "id_promo": _idPromo,
      "judul_promo": _title,
      "jangka_waktu_promo": _length,
      "tanggal_mulai_promo": _startDate,
      "tanggal_selesai_promo": _endDate,
      "status_promo": _status,
      "promo_details": _promoDetails,
      "tipe_promo": _type,
      "id_team": _teamId
    };
  }

  @override
  String toString() {
    return 'PromoModel{_idPromo: $_idPromo, _title: $_title, _startDate: $_startDate, _endDate: $_endDate, _status: $_status, _length: $_length, _tipe: $_type, _teamId: $_teamId, _promoDetails: $_promoDetails}';
  }
}
