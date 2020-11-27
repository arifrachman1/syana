class OverviewModel{
  int _profitBruto, _costTerjual, _costFree, _profitNetto, _omzet;

  OverviewModel(){
      _profitBruto = 0;
      _costTerjual = 0;
      _costFree = 0;
      _profitNetto = 0;
      _omzet = 0;
  }

  OverviewModel.getOverview(
    this._profitBruto,
    this._costTerjual,
    this._costFree,
    this._profitNetto,
    this._omzet
  );

  get profitBruto => _profitBruto;

  set profitBruto(value){
    _profitBruto = value;
  }

  get costTerjual => _costTerjual;

  set costTerjual(value){
    _costTerjual = value;
  }

  get costFree => _costFree;

  set costFree(value){
    _costFree = value;
  }

  get profitNetto => _profitNetto;

  set profitNetto(value){
    _profitNetto = value;
  }

  get omzet => _omzet;

  set omzet(value){
    _omzet = value;
  }

}