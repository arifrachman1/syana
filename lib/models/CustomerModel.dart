class CustomerModel {
  String _id,
      _fullName,
      _nickName,
      _phoneNumber,
      _address,
      _city,
      _province,
      _zipCode,
      _ecommerceId,
      _dateTimeCreated,
      _dateTimeModified,
      _idEmployee,
      _idEmployeeTeam,
      _nameEcommerce;

  CustomerModel.full(
      this._id,
      this._fullName,
      this._nickName,
      this._phoneNumber,
      this._address,
      this._city,
      this._province,
      this._zipCode,
      this._ecommerceId,
      this._dateTimeCreated,
      this._dateTimeModified,
      this._idEmployee,
      this._idEmployeeTeam,
      this._nameEcommerce);

  CustomerModel.customerSuggestions(
      this._id, this._fullName, this._phoneNumber, this._zipCode);

  CustomerModel.zipCode(this._city, this._province, this._zipCode);

  get idEmployeeTeam => _idEmployeeTeam;

  set idEmployeeTeam(value) {
    _idEmployeeTeam = value;
  }

  get idEmployee => _idEmployee;

  set idEmployee(value) {
    _idEmployee = value;
  }

  get nameEcommerce => _nameEcommerce;

  set nameEcommerce(value) {
    _nameEcommerce = value;
  }

  get dateTimeModified => _dateTimeModified;

  set dateTimeModified(value) {
    _dateTimeModified = value;
  }

  get dateTimeCreated => _dateTimeCreated;

  set dateTimeCreated(value) {
    _dateTimeCreated = value;
  }

  get ecommerceId => _ecommerceId;

  set ecommerceId(value) {
    _ecommerceId = value;
  }

  get zipCode => _zipCode;

  set zipCode(value) {
    _zipCode = value;
  }

  get province => _province;

  set province(value) {
    _province = value;
  }

  get city => _city;

  set city(value) {
    _city = value;
  }

  get address => _address;

  set address(value) {
    _address = value;
  }

  get phoneNumber => _phoneNumber;

  set phoneNumber(value) {
    _phoneNumber = value;
  }

  get nickName => _nickName;

  set nickName(value) {
    _nickName = value;
  }

  get fullName => _fullName;

  set fullName(value) {
    _fullName = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  @override
  String toString() {
    return 'CustomerModel{_id: $_id, _fullName: $_fullName, _nickName: $_nickName, _phoneNumber: $_phoneNumber, _address: $_address, _city: $_city, _province: $_province, _zipCode: $_zipCode, _ecommerceId: $_ecommerceId, _dateTimeCreated: $_dateTimeCreated, _dateTimeModified: $_dateTimeModified, _idEmployee: $_idEmployee, _idEmployeeTeam: $_idEmployeeTeam}';
  }
}
