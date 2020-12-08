class UserModel {
  int _id;
  String _name;
  String _fullName;
  String _dateTimeJoined;
  int _idRole;
  int _idTeam;
  String _accessToken;

  UserModel(this._id, this._name, this._fullName, this._dateTimeJoined,
      this._idRole, this._idTeam, this._accessToken);

  String get accessToken => _accessToken;

  set accessToken(String value) {
    _accessToken = value;
  }

  int get idTeam => _idTeam;

  set idTeam(int value) {
    _idTeam = value;
  }

  int get idRole => _idRole;

  set idRole(int value) {
    _idRole = value;
  }

  String get dateTimeJoined => _dateTimeJoined;

  set dateTimeJoined(String value) {
    _dateTimeJoined = value;
  }

  String get fullName => _fullName;

  set fullName(String value) {
    _fullName = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  @override
  String toString() {
    return 'UserModel{_id: $_id, _name: $_name, _fullName: $_fullName, _dateTimeJoined: $_dateTimeJoined, _idRole: $_idRole, _idTeam: $_idTeam, _accessToken: $_accessToken}';
  }
}
