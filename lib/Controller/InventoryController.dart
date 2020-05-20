import 'package:syana/models/ProductModel.dart';
import 'package:syana/models/UserModel.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/utils/GlobalVars.dart';

class InventoryController {
  UserModel _userModel;

  InventoryController() {
    _getPersistence();
  }

  _getPersistence() async {
    _userModel = await GlobalFunctions.getPersistence();
  }

  getStock(context, loadingStateCallback, setDataCallback, sortOrder) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params = GlobalFunctions.generateMapParam(
        ['id_employee', 'sort_order', 'id_team'],
        [_userModel.id.toString(), sortOrder, _userModel.idTeam.toString()]);

  print(params);
    loadingStateCallback();
    final data = await GlobalFunctions.dioGetCall(
        path: GlobalVars.apiUrl + "get-stock",
        params: params,
        context: context);

    if (data != null) {
      print(data);
      if (data['status'] == 1) {
        List stockFromApi = data['product'];
        List<ProductModel> stocks = new List();

        if (stockFromApi.isNotEmpty) {
          stockFromApi.forEach((element) {
            stocks.add(new ProductModel.productStock(
                element['id'].toString(),
                element['status'].toString(),
                element['name'].toString(),
                element['image'].toString(),
                element['point'].toString(),
                element['stock'].toString(),
                element['critical_stock'].toString(),
                element['weight'].toString(),
                element['sku'].toString(),
                element['harga'].toString()));
          });
        }

        if(stocks.isNotEmpty){
          setDataCallback(stocks);
        }
      }
    }
    loadingStateCallback();
  }
}
