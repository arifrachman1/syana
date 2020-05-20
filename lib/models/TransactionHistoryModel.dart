import 'package:syana/models/ProductModel.dart';

class TransactionHistoryModel {
  String _id,
      _idEmployee,
      _idEmployeeTeam,
      _idCustomer,
      _transactionNumber,
      _totalPoint,
      _totalWeight,
      _datetimeCreated,
      _datetimeModified,
      _idJasaPengiriman,
      _usernameCustomer,
      _nameEcommerce;

  List<ProductModel> _productList;

  TransactionHistoryModel.getHistory(
      this._transactionNumber, this._datetimeCreated, this._nameEcommerce);

  List<ProductModel> get productList => _productList;

  set productList(List<ProductModel> value) {
    _productList = value;
  }

  get nameEcommerce => _nameEcommerce;

  set nameEcommerce(value) {
    _nameEcommerce = value;
  }

  get usernameCustomer => _usernameCustomer;

  set usernameCustomer(value) {
    _usernameCustomer = value;
  }

  get idJasaPengiriman => _idJasaPengiriman;

  set idJasaPengiriman(value) {
    _idJasaPengiriman = value;
  }

  get datetimeModified => _datetimeModified;

  set datetimeModified(value) {
    _datetimeModified = value;
  }

  get datetimeCreated => _datetimeCreated;

  set datetimeCreated(value) {
    _datetimeCreated = value;
  }

  get totalWeight => _totalWeight;

  set totalWeight(value) {
    _totalWeight = value;
  }

  get totalPoint => _totalPoint;

  set totalPoint(value) {
    _totalPoint = value;
  }

  get transactionNumber => _transactionNumber;

  set transactionNumber(value) {
    _transactionNumber = value;
  }

  get idCustomer => _idCustomer;

  set idCustomer(value) {
    _idCustomer = value;
  }

  get idEmployeeTeam => _idEmployeeTeam;

  set idEmployeeTeam(value) {
    _idEmployeeTeam = value;
  }

  get idEmployee => _idEmployee;

  set idEmployee(value) {
    _idEmployee = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}
