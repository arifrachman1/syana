class SaleDetailModel {
	String _id, _idSale, _idProduct, _productName, _saleNumber, _freeNumber, _point, _sku, _price, _weight, _status;

	int _currentSaleNum, _profitBruto, _profitNetto, _omzet, _cost;

  SaleDetailModel.init(this._id,
                       this._idSale,
                       this._idProduct,
                       this._productName,
                       this._saleNumber,
                       this._point,
                       this._sku,
                       this._price,
                       this._weight,
                       this._currentSaleNum,);


	SaleDetailModel.initSummary(this._id, this._idSale, this._saleNumber, this._freeNumber, this._profitBruto, this._profitNetto, this._omzet, this._productName, this._cost);

  get status => _status;

  set status(value) {
    _status = value;
  }

  get currentSaleNum => _currentSaleNum;

  set currentSaleNum(value) {
    _currentSaleNum = value;
  }

  get weight => _weight;

  set weight(value) {
    _weight = value;
  }

  get price => _price;

  set price(value) {
    _price = value;
  }

  get sku => _sku;

  set sku(value) {
    _sku = value;
  }

  get point => _point;

  set point(value) {
    _point = value;
  }

  get saleNumber => _saleNumber;

  set saleNumber(value) {
    _saleNumber = value;
  }

  get productName => _productName;

  set productName(value) {
    _productName = value;
  }

  get idProduct => _idProduct;

  set idProduct(value) {
    _idProduct = value;
  }

  get idSale => _idSale;

  set idSale(value) {
    _idSale = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }


	get freeNumber => _freeNumber;

	set freeNumber(value) {
		_freeNumber = value;
	}

	get profitBruto => _profitBruto;

	set profitBruto(value) {
		_profitBruto = value;
	}

	get profitNetto => _profitNetto;

	set profitNetto(value) {
		_profitNetto = value;
	}

	get omzet => _omzet;

	set omzet(value) {
		_omzet = value;
	}

  @override
  String toString() {
    return 'SaleDetailModel{_id: $_id, _idSale: $_idSale, _idProduct: $_idProduct, _productName: $_productName, _saleNumber: $_saleNumber, _point: $_point, _sku: $_sku, _price: $_price, _weight: $_weight, _currentSaleNum: $_currentSaleNum}, _status: $_status}';
  }


}
