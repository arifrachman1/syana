import 'dart:convert';

import 'package:syana/models/SaleDetailModel.dart';

class SummaryModel {
	int _id, _status, _omzet, _profitBruto, _profitNetto, _costTotal, _numbering;
  String _transactionNumber, _cashierName, _packerName;

  List<SaleDetailModel> _transDetails;


    SummaryModel();

    SummaryModel.init(this._id, this._status, this._omzet, this._profitBruto, this._profitNetto, this._transactionNumber, this._cashierName,
                    this._packerName, this._transDetails, this._costTotal, this._numbering);


	get numbering => _numbering;

	set numbering(value) {
		_numbering = value;
	}

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

  toJson() {
    Map model = {
      "id": _id,
      "status": _status,
      "profit_bruto": _profitBruto,
      "profit_netto": _profitNetto,
      "cost_total": _costTotal,
      "transaction_number": _transactionNumber,
      "cashier_name": _cashierName,
      "packer_name": _packerName,
      "details": _transDetails
    };

    return json.encode(model);
  }

    fromJson(Map<String, dynamic> jsonParam) {
      List _details = jsonParam['details'];

      this.transDetails = new List();

      _details.forEach((element) {
        Map _decodedJson = json.decode(element);

        SaleDetailModel _model = new SaleDetailModel();
        _model.fromJson(_decodedJson);
        this.transDetails.add(_model);
      });

      this.id = jsonParam['id'];
      this.status = jsonParam['status'];
      this.profitBruto = jsonParam['profit_bruto'];
      this.profitNetto = jsonParam['profit_netto'];
      this.costTotal = jsonParam['cost_total'];
      this.transactionNumber = jsonParam['transaction_number'];
      this.cashierName = jsonParam['cashier_name'];
      this.packerName = jsonParam['packer_name'];
    }

  @override
  String toString() {
    return 'SummaryModel{_id: $_id, _status: $_status, _omzet: $_omzet, _profitBruto: $_profitBruto, _profitNetto: $_profitNetto, _transactionNumber: $_transactionNumber, _cashierName: $_cashierName, _packerName: $_packerName, _transDetails: $_transDetails}';
  }
}
