import 'package:syana/models/SaleDetailModel.dart';

class SaleModel{
  String _id, _transactionNumber, _totalPoint, _date, _customer, _ecommerce;
  List<SaleDetailModel> _saleDetails;

  SaleModel.init(this._id, this._transactionNumber, this._totalPoint,
      this._date, this._customer, this._ecommerce, this._saleDetails);

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
}