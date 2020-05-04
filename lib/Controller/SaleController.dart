import 'package:flutter/cupertino.dart';
import 'package:syana/models/EcommerceModel.dart';
import 'package:syana/models/UserModel.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/utils/GlobalVars.dart';

class SaleController {
  BuildContext _context;
  UserModel _userModel;

  SaleController() {
    _getPersistence();
  }

  _getPersistence() async {
    _userModel = await GlobalFunctions.getPersistence();
  }

  getEcommerce(context, loadingStateCallback, setDataCallback) async {
    print("run");

    if (_userModel == null) {
      await _getPersistence();
    }

    var params =
    GlobalFunctions.generateMapParam(["id_employee"], [_userModel.id]);

    loadingStateCallback();
    final data = await GlobalFunctions.dioGetCall(
        path: GlobalVars.apiUrl + "get-ecommerce",
        context: context,
        params: params);

    if (data != null) {
      print(data);
      if (data['status'] == 1) {
        List ecommerceFromApi = data['ecommerce'];
        List<EcommerceModel> ecommerces = new List();

        ecommerceFromApi.forEach((element) {
          ecommerces.add(new EcommerceModel(element['id'].toString(),
              element['name'].toString(), element['status'].toString()));
        });

        if (ecommerces.isNotEmpty){
          setDataCallback(ecommerces);
        }
      }
    }else{
      print("false");
    }
    loadingStateCallback();
  }
}
