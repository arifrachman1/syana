class TraceModel{
  String _traceId,
  _productId,
  _employeeTeamId,
  _employeeId,
  _traceDate,
  _trace,
  _productName,
  _teamName,
  _employeeName;

  TraceModel.traceData(
      this._traceId,
      this._productId,
      this._employeeTeamId,
      this._employeeId,
      this._traceDate,
      this._trace,
      this._productName,
      this._teamName,
      this._employeeName);

  get employeeName => _employeeName;

  set employeeName(value) {
    _employeeName = value;
  }

  get teamName => _teamName;

  set teamName(value) {
    _teamName = value;
  }

  get productName => _productName;

  set productName(value) {
    _productName = value;
  }

  get trace => _trace;

  set trace(value) {
    _trace = value;
  }

  get traceDate => _traceDate;

  set traceDate(value) {
    _traceDate = value;
  }

  get employeeId => _employeeId;

  set employeeId(value) {
    _employeeId = value;
  }

  get employeeTeamId => _employeeTeamId;

  set employeeTeamId(value) {
    _employeeTeamId = value;
  }

  get productId => _productId;

  set productId(value) {
    _productId = value;
  }

  String get traceId => _traceId;

  set traceId(String value) {
    _traceId = value;
  }
}