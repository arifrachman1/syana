import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syana/models/CourierModel.dart';
import 'package:syana/models/EcommerceModel.dart';
import 'package:syana/models/ProductModel.dart';
import 'package:syana/models/TransactionHistoryModel.dart';
import 'package:syana/models/UserModel.dart';
import 'package:syana/utils/GlobalFunctions.dart';
import 'package:syana/utils/GlobalVars.dart';
import 'package:syana/utils/Strings.dart';
import 'package:syana/widgets/CustomDialog.dart';

class SaleController {
  BuildContext _context;
  UserModel _userModel;
  List<ProductModel> _selectedProducts;

  SaleController() {
    _getPersistence();
    _initSelectedProducts();
  }

  _getPersistence() async {
    _userModel = await GlobalFunctions.getPersistence();
  }

  _initSelectedProducts() {
    _selectedProducts = new List();
  }

  /*=====*/
  /*add or remove item mechanism*/
  addSelectedProduct(ProductModel product) {
    _selectedProducts.add(product);
  }

  removeSelectedProduct(index) {
    _selectedProducts.removeAt(index);
  }

  setSaleNumber(object, number) {
    _selectedProducts[_selectedProducts.indexOf(object)].saleNumber = number;
  }

  setFreeNumber(object, number) {
    _selectedProducts[_selectedProducts.indexOf(object)].freeNumber = number;
  }

  /*to check on the selected item list, whether there is a zero value within itself or not*/
  /*then remove the zero valued object from selected product list*/
  bool checkZeroNumber() {
    bool condition = false;
    List productsToRemove = new List();

    /*before we check each products, we filter out the selected products*/
    /*from duplicate entries that gained after we change tabs*/
    _filterSelectedProducts();

    _selectedProducts.forEach((element) {
      if (element.freeNumber == "0" && element.saleNumber == "0") {
        productsToRemove.add(element);
        condition = true;
      }
    });
    productsToRemove.forEach((element) {
      _selectedProducts.remove(element);
    });

    return condition;
  }

  List getSelectedProduct() {
    /*before we return the list, we filter out the duplicate objects created when changing tabs*/
    _filterSelectedProducts();
    return _selectedProducts;
  }

  getTotal(isSale) {
    _filterSelectedProducts();
    int total = 0;
    _selectedProducts.forEach((element) {
      int value = isSale
          ? int.parse(element.saleNumber)
          : int.parse(element.freeNumber);
      total += value;
    });

    return total;
  }

  _filterSelectedProducts() {
    _selectedProducts = _selectedProducts.toSet().toList();
  }

  _printSale() {
    print("=====Selected Products From Controller=====");
    print(_selectedProducts.toString());
    print("length : " + _selectedProducts.length.toString());
  }

  /*add or remove item mechanism*/
  /*=====*/

  /*get customer's ecommerce*/
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

        if (ecommerces.isNotEmpty) {
          setDataCallback(ecommerces);
        }
      }
    } else {
      print("false");
    }
    loadingStateCallback();
  }

  /*get products*/
  getProducts(context, loadingStateCallback, setDataCallback) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params =
        GlobalFunctions.generateMapParam(["id_employee"], [_userModel.id]);

    final data = await GlobalFunctions.dioGetCall(
        path: GlobalVars.apiUrl + "get-list-product",
        context: context,
        params: params);

    if (data != null) {
      if (data['status'] == 1) {
        List productsFromApi = data['product'];
        List<ProductModel> products = new List();

        productsFromApi.forEach((element) {
          products.add(new ProductModel.productList(
              element['id'],
              element['name'],
              element['image'],
              element['id_category'],
              element['sku'],
              element['harga'],
              element['category_name'],
              "0",
              "0"));
        });

        if (products.isNotEmpty) {
          setDataCallback(products);
        }
      }
    } else {}
  }

  /*get history*/
  getHistoryProducts(context, loadingStateCallback, setDataCallback) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    var params =
    GlobalFunctions.generateMapParam(["id_employee"], [_userModel.id]);

    final data = await GlobalFunctions.dioGetCall(
        path: GlobalVars.apiUrl + "get-list-sales",
        context: context,
        params: params);

    if (data != null) {
      if (data['status'] == 1) {
        List historiesFromApi = data['sales'];
        List<TransactionHistoryModel> historiesProduct = new List();

        historiesFromApi.forEach((element) {
          historiesProduct.add(new TransactionHistoryModel.getHistory(
            element['transaction_number'],
            element['datetime_created'],
            element['name_ecommerce']
          ));
        });

        if (historiesProduct.isNotEmpty) {
          setDataCallback(historiesProduct);
        }
      }
    } else {}
  }

  /*strip categories from products*/
  getCategoriesFromProducts(List products) {
    Map<String, String> categories = new Map();
    categories["0"] = "All";
    if (products is List<ProductModel> && products.isNotEmpty) {
      List<String> ids = new List(), names = new List();
      products.forEach((element) {
        ids.add(element.idCategory);
        names.add(element.categoryName);
      });

      var distinctIds = ids.toSet().toList();
      var distinctNames = names.toSet().toList();

      print("distinct ids length : " +
          distinctIds.length.toString() +
          ", distinct names length : " +
          distinctNames.length.toString());

      if (distinctIds.length == distinctNames.length) {
        int i = 0;
        distinctIds.forEach((element) {
          categories[element] = distinctNames[i];
          i++;
        });
      }

      return categories;
    }
  }

  /*get products by supplied category*/
  getProductsByCategory(List products, idCategory) {
    List<ProductModel> categorizedProducts = new List();
    if (products is List<ProductModel> && products.isNotEmpty) {
      products.forEach((element) {
        if (element.idCategory == idCategory) {
          categorizedProducts.add(element);
        }
      });

      return categorizedProducts;
    }
  }

  setSale(context, loadingStateCallback, transNumber, courierId,
      List details) async {
    FormData formData;
    print(details);
    String paramDetail = GlobalFunctions.generateJsonParam(["detail"], [details]);
    print(paramDetail);
    Map param = GlobalFunctions.generateMapParam([
      "id_employee",
      "id_customer",
      "transaction_number",
      "detail",
      "courier"
    ], [
      _userModel.id.toString(),
      GlobalVars.customerId,
      transNumber,
      paramDetail,
      courierId
    ]);
    formData = FormData.fromMap(param);
    print(formData.fields);

    loadingStateCallback();
    final data = await GlobalFunctions.dioPostCall(
        path: GlobalVars.apiUrl + "sale-product",
        params: formData,
        context: context);
    if (data != null) {
      if (data['status'] == 1) {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        CustomDialog.getDialog(
            title: Strings.DIALOG_TITLE_SUCCESS,
            message: Strings.DIALOG_MESSAGE_TRANSACTION_SUCCESS,
            context: context,
            popCount: 1);
      }else{
        CustomDialog.getDialog(
            title: Strings.DIALOG_TITLE_ERROR,
            message: data['message'],
            context: context,
            popCount: 1);
        print(data['message']);
      }
    }else{
      CustomDialog.getDialog(
          title: Strings.DIALOG_TITLE_ERROR,
          message: Strings.DIALOG_MESSAGE_API_CALL_FAILED,
          context: context,
          popCount: 1);
    }
    loadingStateCallback();
  }

  getCourier(context, loadingStateCallback, setDataCallback) async {
    if (_userModel == null) {
      await _getPersistence();
    }

    loadingStateCallback();
    final data = await GlobalFunctions.dioGetCall(
      path: GlobalVars.apiUrl + "get-all-courier",
      context: context,
    );

    if (data != null) {
      if (data['status'] == 1) {
        List courierFromApi = data['courier'];
        List<CourierModel> temp = new List();
        courierFromApi.forEach((element) {
          temp.add(new CourierModel(
              element['id'].toString(), element['name'].toString()));
        });

        if (temp.isNotEmpty) {
          setDataCallback(_generateDropdownMenuItems(temp));
        }
      }
    }
    loadingStateCallback();
  }

  List _generateDropdownMenuItems(List<CourierModel> objects) {
    List<DropdownMenuItem> temp = new List();
    if (objects.isNotEmpty) {
      objects.forEach((element) {
        temp.add(new DropdownMenuItem(
          child: Text(element.name),
          value: int.parse(element.id),
        ));
      });
    }
    return temp;
  }
}
