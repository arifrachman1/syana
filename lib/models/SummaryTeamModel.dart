import 'package:syana/models/TeamModel.dart';

class SummaryTeamModel extends TeamModel {
  int _saleCountAll, _saleCountProcessed, _saleCountUnprocessed;

  SummaryTeamModel.teamsDropdown(String id, String name) : super.teamsDropdown(id, name);

  get saleCountUnprocessed => _saleCountUnprocessed;

  set saleCountUnprocessed(value) {
    _saleCountUnprocessed = value;
  }

  get saleCountProcessed => _saleCountProcessed;

  set saleCountProcessed(value) {
    _saleCountProcessed = value;
  }

  int get saleCountAll => _saleCountAll;

  set saleCountAll(int value) {
    _saleCountAll = value;
  }

  @override
  String toString() {
    super.toString();
    return 'SummaryTeamModel{_saleCountAll: $_saleCountAll, _saleCountProcessed: $_saleCountProcessed, _saleCountUnprocessed: $_saleCountUnprocessed}';
  }
}
