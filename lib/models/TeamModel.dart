class TeamModel {
  String _id, _name, _email, _quote, _point;

  TeamModel.teamsDropdown(this._id, this._name);

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  get name => _name;

  get point => _point;

  set point(value) {
    _point = value;
  }

  get quote => _quote;

  set quote(value) {
    _quote = value;
  }

  get email => _email;

  set email(value) {
    _email = value;
  }

  set name(value) {
    _name = value;
  }

  @override
  String toString() {
    return 'TeamModel{_id: $_id, _name: $_name, _email: $_email, _quote: $_quote, _point: $_point}';
  }
}
