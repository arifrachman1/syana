import 'package:syana/models/EcommerceModel.dart';

class SummaryEcommerceModel extends EcommerceModel {
  int _countAll, _countProcessed, _countUnprocessed;

  SummaryEcommerceModel(String id, String name, String status) : super(id, name, status);

  get countUnprocessed => _countUnprocessed;

  set countUnprocessed(value) {
    _countUnprocessed = value;
  }

  get countProcessed => _countProcessed;

  set countProcessed(value) {
    _countProcessed = value;
  }

  int get countAll => _countAll;

  set countAll(int value) {
    _countAll = value;
  }

  @override
  String toString() {
    super.toString();
    return 'SummaryEcommerceModel{_countAll: $_countAll, _countProcessed: $_countProcessed, _countUnprocessed: $_countUnprocessed}';
  }
}
