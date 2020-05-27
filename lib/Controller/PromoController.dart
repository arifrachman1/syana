import 'package:syana/models/PromoDetailInModel.dart';
import 'package:syana/models/PromoDetailModel.dart';
import 'package:syana/models/PromoDetailOutModel.dart';
import 'package:syana/models/PromoModel.dart';
import 'package:syana/models/UserModel.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/utils/GlobalVars.dart';

class PromoController {
  UserModel _userModel;

  PromoController() {
    _getPersistence();
  }

  _getPersistence() async {
    _userModel = await GlobalFunctions.getPersistence();
  }

  getPromo(context, loadingStateCallback, setDataCallback) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params = GlobalFunctions.generateMapParam(
        ['id_team'], [_userModel.idTeam.toString()]);

    loadingStateCallback();
    final data = await GlobalFunctions.dioGetCall(
        context: context,
        path: GlobalVars.apiUrl + "get-promo",
        params: params);

    if (data != null) {
      if (data['status'] == 1) {
        List promosFromApi = data['promo'];
        List<PromoModel> promos = new List();
        List<PromoDetailModel> promoDetails = new List();
        List<PromoDetailInModel> promoDetailIns = new List();
        List<PromoDetailOutModel> promoDetailOuts = new List();

        if (promosFromApi.isNotEmpty) {
          promosFromApi.forEach((element) {
            List promoDetailsFromApi = element['promo_details'];
            promoDetailsFromApi.forEach((elementDetail) {
              List promoDetailInFromApi = elementDetail['promo_detail_in'];
              promoDetailInFromApi.forEach((elementIn) {
                promoDetailIns.add(new PromoDetailInModel.init(
                    elementIn['id_promo_detail_in'].toString(),
                    elementIn['id_promo_detail'].toString(),
                    elementIn['id_product_required'].toString(),
                    elementIn['amount_required'].toString(),
                    elementIn['required_type'].toString()));
              });

              List promoDetailOutFromApi = elementDetail['promo_detail_out'];
              promoDetailOutFromApi.forEach((elementOut) {
                promoDetailOuts.add(new PromoDetailOutModel.init(
                    elementOut['id_promo_detail_out'].toString(),
                    elementOut['id_promo_detail'].toString(),
                    elementOut['id_product_free'].toString(),
                    elementOut['amount_free'].toString()));
              });

              promoDetails.add(new PromoDetailModel.init(
                  elementDetail['id_promo_detail'].toString(),
                  elementDetail['id_promo'].toString(),
                  promoDetailIns,
                  promoDetailOuts));
            });

            promos.add(new PromoModel.init(
                element['id_promo'].toString(),
                element['judul_promo'].toString(),
                element['tanggal_mulai_promo'].toString(),
                element['tanggal_selesai_promo'].toString(),
                element['status_promo'].toString(),
                element['jangka_waktu_promo'].toString(),
                element['tipe_promo'].toString(),
                element['id_team'].toString(),
                promoDetails));
          });
        }

        setDataCallback(promos);
      }
    }

    loadingStateCallback();
  }

  filterOutPromo(setDataCallback, loadingStateCallback, List<PromoModel> data, showDisabled){
    List<PromoModel> temp = new List();
    loadingStateCallback();
    if(showDisabled == false){
      data.forEach((element) {
        if(element.status.toString().compareTo("1") == 0){
          temp.add(element);
        }
      });
    }else{
      data.forEach((element) {
        if(element.status.toString().compareTo("1") != 0){
          temp.add(element);
        }
      });
    }
    loadingStateCallback();

    setDataCallback(temp);
  }
}
