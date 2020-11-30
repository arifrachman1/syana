import 'package:syana/models/SaleDetailModel.dart';

class SummaryModel {
  int _id, _status, _omzet, _profitBruto, _profitNetto, _costTotal;
  String _transactionNumber, _cashierName, _packerName;

  List<SaleDetailModel> _transDetails;

  SummaryModel.init(this._id, this._status, this._omzet, this._profitBruto, this._profitNetto, this._transactionNumber, this._cashierName,
      this._packerName, this._transDetails, this._costTotal);

  List<SaleDetailModel> get transDetails => _transDetails;

  set transDetails(List<SaleDetailModel> value) {
    _transDetails = value;
  }

  get packerName => _packerName;

  set packerName(value) {
    _packerName = value;
  }

  get cashierName => _cashierName;

  set cashierName(value) {
    _cashierName = value;
  }

  String get transactionNumber => _transactionNumber;

  set transactionNumber(String value) {
    _transactionNumber = value;
  }

  get profitNetto => _profitNetto;

  set profitNetto(value) {
    _profitNetto = value;
  }

  get profitBruto => _profitBruto;

  set profitBruto(value) {
    _profitBruto = value;
  }

  get omzet => _omzet;

  set omzet(value) {
    _omzet = value;
  }

  get status => _status;

  set status(value) {
    _status = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  get costTotal => _costTotal;

  set costTotal(value) {
    _costTotal = value;
  }

  @override
  String toString() {
    return 'SummaryModel{_id: $_id, _status: $_status, _omzet: $_omzet, _profitBruto: $_profitBruto, _profitNetto: $_profitNetto, _transactionNumber: $_transactionNumber, _cashierName: $_cashierName, _packerName: $_packerName, _transDetails: $_transDetails}';
  }
}
