import 'package:syana/models/SaleDetailModel.dart';

class SaleModel{
  String _id, _transactionNumber, _totalPoint, _date, _customer, _ecommerce, _status, _seller, _packer, _salesName;
  List<SaleDetailModel> _saleDetails;

  SaleModel.init(this._id, this._transactionNumber, this._totalPoint,
      this._date, this._customer, this._ecommerce, this._saleDetails, this._status, this._salesName);

  get seller => _seller;

  set seller(value) {
    _seller = value;
  }

  get status => _status;

  set status(value) {
    _status = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  get transactionNumber => _transactionNumber;

  get ecommerce => _ecommerce;

  set ecommerce(value) {
    _ecommerce = value;
  }

  get customer => _customer;

  set customer(value) {
    _customer = value;
  }

  get date => _date;

  set date(value) {
    _date = value;
  }

  get totalPoint => _totalPoint;

  set totalPoint(value) {
    _totalPoint = value;
  }

  set transactionNumber(value) {
    _transactionNumber = value;
  }


  List<SaleDetailModel> get saleDetails => _saleDetails;

  set saleDetails(List<SaleDetailModel> value) {
    _saleDetails = value;
  }

  @override
  String toString() {
    return 'SaleModel{_id: $_id, _transactionNumber: $_transactionNumber, _totalPoint: $_totalPoint, _date: $_date, _customer: $_customer, _ecommerce: $_ecommerce, _saleDetails: $_saleDetails}';
  }

  get packer => _packer;

  set packer(value) {
    _packer = value;
  }

  get salesName => _salesName;

  set salesName(value) {
    _salesName = value;
  }
}