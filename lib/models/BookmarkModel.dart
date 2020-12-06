import 'dart:convert';

enum BookmarkType { summary, summaryDetail, overview }

class BookmarkModel {
  int _idBookmark;
  BookmarkType _type;
  String _payloads, _title, _date;

  BookmarkModel.init(this._idBookmark, this._type, this._payloads, this._title, this._date);

  int get idBookmark => _idBookmark;

  set idBookmark(int value) {
    _idBookmark = value;
  }

  BookmarkType get type => _type;

  set type(BookmarkType value) {
    _type = value;
  }

  String get payloads => _payloads;

  set payloads(String value) {
    _payloads = value;
  }

  payloadToMap() => json.decode(this.payloads);


  get title => _title;

  set title(value) {
    _title = value;
  }

  @override
  String toString() {
    return 'BookmarkModel{_idBookmark: $_idBookmark, _type: $_type, _payloads: $_payloads}';
  }

  get date => _date;

  set date(value) {
    _date = value;
  }
}
