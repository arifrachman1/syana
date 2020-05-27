import 'package:syana/models/PromoDetailModel.dart';

class PromoModel{
  String _idPromo, _title, _startDate, _endDate, _status, _length, _tipe, _teamId;
  List<PromoDetailModel> _promoDetails;

  PromoModel.init(this._idPromo, this._title, this._startDate, this._endDate,
      this._status, this._length, this._tipe, this._teamId, this._promoDetails);

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

  get tipe => _tipe;

  set tipe(value) {
    _tipe = value;
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

  @override
  String toString() {
    return 'PromoModel{_idPromo: $_idPromo, _title: $_title, _startDate: $_startDate, _endDate: $_endDate, _status: $_status, _length: $_length, _tipe: $_tipe, _teamId: $_teamId, _promoDetails: $_promoDetails}';
  }
  
}