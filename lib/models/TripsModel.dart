class TripsModel {
  String _id,
      _title,
      _quote,
      _youtubeVideoId,
      _viewNumber,
      _thumbnail,
      _description;


  TripsModel.init(this._id, this._title, this._quote, this._youtubeVideoId,
      this._viewNumber, this._thumbnail, this._description);

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  get title => _title;

  get description => _description;

  set description(value) {
    _description = value;
  }

  get thumbnail => _thumbnail;

  set thumbnail(value) {
    _thumbnail = value;
  }

  get viewNumber => _viewNumber;

  set viewNumber(value) {
    _viewNumber = value;
  }

  get youtubeVideoId => _youtubeVideoId;

  set youtubeVideoId(value) {
    _youtubeVideoId = value;
  }

  get quote => _quote;

  set quote(value) {
    _quote = value;
  }

  set title(value) {
    _title = value;
  }

  @override
  String toString() {
    return 'TripsModel{_id: $_id, _title: $_title, _quote: $_quote, _youtubeVideoId: $_youtubeVideoId, _viewNumber: $_viewNumber, _thumbnail: $_thumbnail, _description: $_description}';
  }


}
