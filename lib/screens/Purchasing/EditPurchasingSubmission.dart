import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:syana/Controller/PurchasingController.dart';
import 'package:syana/models/MaterialModel.dart';
import 'package:syana/models/ProductModel.dart';
import 'package:syana/models/PurchasingModel.dart';
import 'package:syana/utils/AppTheme.dart';
import 'package:syana/utils/NumberFormatter.dart';
import 'package:syana/widgets/CustomDialog.dart';
import 'package:syana/widgets/CustomTextInput.dart';
import 'package:image/image.dart' as imgLib;

class EditPurchasingSubmission extends StatefulWidget {
  int _idPurchasing;
  EditPurchasingSubmission(this._idPurchasing);
  @override
  _EditPurchasingSubmissionState createState() =>
      _EditPurchasingSubmissionState();
}

class _EditPurchasingSubmissionState extends State<EditPurchasingSubmission> {
  int _indexProduct = 0,
      _indexMaterial = 0,
      _indexWidgetMaterial = 0,
      typeProduct = 0,
      totalPrice = 0;
  String _selectedType;
  List<String> _selectMaterial = new List();
  String _selectedFirstMaterial;
  List<String> _selectedNameMaterial = new List();

  int _selectedTypeMaterial = 1;
  List<TextEditingController> nameItem = new List();
  List<TextEditingController> totalItem = new List();
  List<TextEditingController> priceItem = new List();
  List<TextEditingController> totalPriceItem = new List();
  TextEditingController _firstRequiredMaterial = new TextEditingController();
  List _typeProduct = ["Bahan Mentah", "Produk Jadi"];
  List _materialType = ["Ingredient", "Packaging"];
  List<Widget> _listProduct = new List();
  List<Widget> _listMaterial = new List();
  List<PurchasingModel> _listDetail = new List();
  List<ProductModel> _listProductModel = new List();
  List<DropdownMenuItem<String>> _dropDownType;
  List<PurchasingModel> purchasing = new List();
  List<MaterialModel> materialList = new List();
  List<MaterialModel> _selectedMaterial = new List();

  List<MultipartFile> _filesToSend = new List();
  List<File> _filesFromDevice = new List();

  TextEditingController _firstRequiredProduct = new TextEditingController();
  PurchasingController purchasingController;

  PurchasingModel purchasingModel;

  String _selectedFirstProduct = "";

  bool isCreate = true;
  bool isRaw = false;
  bool isLoaded = false;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    purchasingController = new PurchasingController();
    _dropDownType = getDropDownMenuItems(_typeProduct);
    initData();
  }

  initData() async {
    await purchasingController.getDetailPurchasingNew(
        context, setLoadingState, setData, widget._idPurchasing);
    purchasingModel.listDetail.forEach((element) {
      if (element.type == "0") {
        purchasing.add(new PurchasingModel.listDetailPurchasing(
            element.idProduct,
            null,
            null,
            element.sku,
            element.totalItem,
            element.priceItem,
            element.priceTotalItem,
            "0"));
      } else if (element.type == "1") {
        purchasing.add(new PurchasingModel.listDetailPurchasing(
            null,
            element.idProduct,
            null,
            element.sku,
            element.totalItem,
            element.priceItem,
            element.priceTotalItem,
            "0"));
      } else {
        purchasing.add(new PurchasingModel.listDetailPurchasing(
            null,
            null,
            element.idProduct,
            element.sku,
            element.totalItem,
            element.priceItem,
            element.priceTotalItem,
            "0"));
      }
      _listProductModel.add(new ProductModel.productPurchasing(
          "0", element.name, getTipeBahan(element.type), purchasing));
      print(purchasing.toString());
    });
  }

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems(List filters) {
    List<DropdownMenuItem<String>> items = new List();
    for (String filter in filters) {
      items.add(new DropdownMenuItem(value: filter, child: new Text(filter)));
    }
    return items;
  }

  void buildProduct() {
    setState(() {
      _listProduct.add(_addProduct(_indexWidgetMaterial));
    });
    addMaterials();
  }

  void addNewProduct() {
    setState(() {
      _indexMaterial++;
      _listProduct.add(_addMaterials(_indexWidgetMaterial));
    });
  }

  void addMaterials() {
    setState(() {
      nameItem.add(new TextEditingController());
      totalItem.add(new TextEditingController());
      priceItem.add(new TextEditingController());
      totalPriceItem.add(new TextEditingController());
      _selectMaterial.add("Ingredient");
      _selectedNameMaterial.add("");

      _selectedMaterial
          .add(new MaterialModel.listMaterial("0", "0", "0", "0", "0"));

      _listMaterial.add(_addMaterials(_indexWidgetMaterial));
    });
  }

  void addNewMaterials() {
    setState(() {
      _indexMaterial++;

      _selectMaterial.add("Ingredient");
      nameItem.add(new TextEditingController());
      totalItem.add(new TextEditingController());
      priceItem.add(new TextEditingController());
      totalPriceItem.add(new TextEditingController());

      _selectedNameMaterial.add("");

      _selectedMaterial
          .add(new MaterialModel.listMaterial("0", "0", "0", "0", "0"));

      _listMaterial.add(_addMaterials(_indexWidgetMaterial));
    });
  }

  FutureOr<Iterable<dynamic>> _onProductChanged(pattern) async {
    if (pattern.toString().length >= 3) {
      return await purchasingController.getProductData(context, pattern);
    }
  }

  FutureOr<Iterable<dynamic>> _onMaterialChanged(pattern) async {
    if (pattern.toString().length >= 3) {
      return await purchasingController.getMaterialData(
          context, pattern, _selectedTypeMaterial);
    }
  }

  _onFirstRequiredProductSelected(suggestion) {
    print(suggestion);
    if (suggestion is ProductModel) {
      setState(() {
        _firstRequiredProduct.text =
            " (" + suggestion.sku + ") " + suggestion.name;
        _selectedFirstProduct = suggestion.id;
      });
    }
  }

  _onFirstRequiredMaterialSelected(suggestion) {
    print(suggestion);
    if (suggestion is MaterialModel) {
      setState(() {
        _firstRequiredMaterial.text =
            " (" + suggestion.sku + ") " + suggestion.name;
        _selectedFirstMaterial = suggestion.id;
      });
    }
  }

  Widget _productItemBuilder(context, item) {
    return ListTile(
      title: Text(item.name),
      subtitle: Text(item.sku),
    );
  }

  Widget _materialItemBuilder(context, item) {
    return ListTile(
      title: Text(item.name),
      subtitle: Text(item.sku),
    );
  }

  void clearPurchasing() {
    setState(() {
      totalItem.clear();
      priceItem.clear();
      totalPriceItem.clear();
      _listMaterial.clear();
      _firstRequiredMaterial.clear();
      _firstRequiredProduct.clear();
      _indexWidgetMaterial = 0;
    });
  }

  _sendPurchasing() async {
    String listPurchasing;
    _listProductModel.forEach((element) {
      setState(() {
        listPurchasing = json.encode(element.lisPurchasingDetail);
      });
    });
    // listPurchasing = json.encode(purchasing);
    print(listPurchasing);
    print(_listProductModel.length);
    await _supplyFiles();
    _filesToSend.forEach((element) {
      print(element.filename);
    });
    if (purchasing.isNotEmpty && _filesToSend.isNotEmpty) {
      await purchasingController.sendData(
          context, setLoadingState, listPurchasing, _filesToSend);
      setState(() {
        _filesToSend.clear();
      });
    } else {
      CustomDialog.getDialog(
          title: "Peringatan",
          message:
              "Harap isi minimal satu plan purchasing dan satu bukti planning.",
          context: context,
          popCount: 1);
    }
  }

  void _openFileExplorer() async {
    print("trying to load...");
    // trying to load
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ["jpg", "jpeg", "png"]);
    if (result != null) {
      File file = File(result.files.single.path);
      print(file.path);
      String _fileExtension = file.path.split(".").last;

      if (_fileExtension.toLowerCase() == "jpeg" ||
          _fileExtension.toLowerCase() == "jpg" ||
          _fileExtension.toLowerCase() == "png") {
        if (file.lengthSync() > 5000000) {
          imgLib.Image tempImage = imgLib.decodeImage(file.readAsBytesSync());
          imgLib.Image compressedImage =
              imgLib.copyResize(tempImage, width: 768);
          imgLib.Image rotatedImage = imgLib.copyRotate(compressedImage, 0);
          File(file.path).writeAsBytesSync(imgLib.encodeJpg(rotatedImage));
          if (file.lengthSync() > 5000000) {
            CustomDialog.getDialog(
                title: "Peringatan",
                message: "Ukuran file melebihi batas.",
                context: context,
                popCount: 1);
          } else {
            setState(() {
              _filesFromDevice.add(file);
            });
            _filesFromDevice.forEach((element) {
              print(element.path);
            });
          }
        } else {
          setState(() {
            _filesFromDevice.add(file);
          });
          _filesFromDevice.forEach((element) {
            print(element.path);
          });
        }
      }
    } else {
      print("object null");
    }
    print("finished loading...");
    if (!mounted) return;
  }

  void _removeImagesFromDevice(int position) {
    setState(() {
      _filesFromDevice.removeAt(position);
    });
  }

  setData(data) {
    // TODO: implement setData
    if (data is List<MaterialModel> && data.isNotEmpty) {
      setState(() {
        materialList = data;
      });
      print(materialList.length);
    } else if (data is PurchasingModel && data != null) {
      setState(() {
        purchasingModel = data;
      });
    }
  }

  _supplyFiles() async {
    for (int i = 0; i < _filesFromDevice.length; i++) {
      _filesToSend.add(await MultipartFile.fromFile(_filesFromDevice[i].path));
    }
  }

  getTipeSatuan(String tipe) {
    String satuan;
    if (tipe == "Ingredient") {
      satuan = "gr";
    } else {
      satuan = "pcs";
    }
    return satuan;
  }

  getTipeBahan(String tipe) {
    String _bahan;
    if (tipe == "0") {
      _bahan = "Produk Jadi";
    } else if (tipe == "1") {
      _bahan = "Ingredient";
    } else {
      _bahan = "Packaging";
    }
    return _bahan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Revisi Plan"),
          backgroundColor: Colors.lightGreen[300],
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Re-Submit',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed: () {
                _sendPurchasing();
              },
            )
          ],
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                decoration: AppTheme.appBackground(),
                padding: EdgeInsets.all(20.0),
                child: ListView(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _listProductModel.length,
                        itemBuilder: (context, position) {
                          return Card(
                              child: Container(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: ListTile(
                              title: Text((position + 1).toString() +
                                  ". " +
                                  _listProductModel[position].name),
                              subtitle: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_listProductModel[position].type),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(_listProductModel[position]
                                                .lisPurchasingDetail[position]
                                                .totalItem +
                                            getTipeSatuan(
                                                _listProductModel[position]
                                                    .type)),
                                        Text(NumberFormatter.getCurrency(
                                                double.parse(
                                                    _listProductModel[position]
                                                        .lisPurchasingDetail[
                                                            position]
                                                        .priceItem)) +
                                            "/" +
                                            getTipeSatuan(
                                                _listProductModel[position]
                                                    .type)),
                                        Text(NumberFormatter.getCurrency(double
                                            .parse(_listProductModel[position]
                                                .lisPurchasingDetail[position]
                                                .priceTotalItem))),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RaisedButton.icon(
                                          color: AppTheme.yellow,
                                          onPressed: () {
                                            if (_listProductModel[position].type == "Produk Jadi"){
                                              setState(() {
                                                isLoaded = true;
                                              });
                                            } else {
                                              setState(() {
                                                isLoaded = true;
                                                isRaw = true;
                                              });
                                            }
                                            buildProduct();
                                            buildListRencana(position);
                                          },
                                          icon: Icon(Icons.edit),
                                          label: Text("Edit"),
                                          shape: StadiumBorder(),
                                        ),
                                        RaisedButton.icon(
                                          color: AppTheme.red,
                                          onPressed: () {
                                            setState(() {
                                              _listProductModel[position]
                                                  .lisPurchasingDetail
                                                  .removeAt(position);
                                              _listProductModel
                                                  .removeAt(position);
                                            });
                                          },
                                          icon: Icon(
                                            Icons.cancel,
                                            color: Colors.white,
                                          ),
                                          label: Text(
                                            "Hapus",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          shape: StadiumBorder(),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ));
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _listProduct.length,
                        itemBuilder: (context, position) {
                          _indexProduct = position;
                          return _addProduct(position);
                        },
                      ),
                    ),
                    !isCreate
                        ? Container(
                            child: buildFileWidget(),
                          )
                        : Container(),
                    isCreate
                        ? RaisedButton(
                            shape: StadiumBorder(),
                            color: AppTheme.btn_default,
                            onPressed: () {
                              setState(() {
                                isCreate = false;
                              });
                              buildProduct();
                            },
                            child: Text("Buat Planing"),
                          )
                        : Container()
                  ],
                ),
              ));
  }

  Widget _addProduct(int index) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white70, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 15.0)),
              Container(
                  child: Row(children: [
                Text(
                  "Pilih Jenis",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )
              ])),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Container(
                  width: 320,
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      border: Border.all()),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: Text("Pilih Jenis"),
                      value: _selectedType,
                      items: _dropDownType,
                      onChanged: (value) async {
                        setState(() {
                          _selectedType = value;
                        });
                        if (_selectedType == "Bahan Mentah") {
                          setState(() {
                            isRaw = true;
                            isLoaded = true;
                          });
                        } else {
                          setState(() {
                            isRaw = false;
                            isLoaded = true;
                          });
                        }
                      },
                    ),
                  )),
              Padding(padding: EdgeInsets.only(top: 15.0)),
              isLoaded
                  ? Visibility(
                      visible: !isRaw,
                      child: Container(
                          child: Text(
                        "Cari Produk",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                    )
                  : Container(),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              isLoaded
                  ? Visibility(
                      visible: !isRaw,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                            border: Border.all()),
                        child: CustomTextInput.getAutoCompleteFieldPurchasing(
                            context: context,
                            controller: _firstRequiredProduct,
                            hint: "SKU Produk",
                            textInputType: TextInputType.text,
                            itemBuilderCallback: _productItemBuilder,
                            suggestionCallback: _onProductChanged,
                            onSuggestionSelectedCallback:
                                _onFirstRequiredProductSelected),
                      ),
                    )
                  : Container(),
              Visibility(
                visible: isLoaded,
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _listMaterial.length,
                    itemBuilder: (context, position) {
                      _indexMaterial = position;
                      return _addMaterials(position);
                    },
                  ),
                ),
              ),
              Container(),
              Padding(padding: EdgeInsets.only(top: 15.0)),
            ],
          ),
        ));
  }

  Widget _addMaterials(int indexChild) {
    // totalPriceItem[indexChild].text = totalPrice.toString();
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 5.0)),
          Visibility(
              visible: isRaw,
              child: Container(
                child: Column(
                  children: [
                    Container(
                        child: Row(children: [
                      Text(
                        "Pilih Jenis Bahan",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ])),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                            border: Border.all()),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: Text("Pilih Jenis Bahan"),
                            value: _selectMaterial[indexChild],
                            items: _materialType.map((value) {
                              return DropdownMenuItem(
                                child: Text(value),
                                value: value,
                              );
                            }).toList(),
                            onChanged: (value) async {
                              setState(() {
                                _selectMaterial[indexChild] = value;
                                if (_selectMaterial[indexChild] ==
                                    "Ingredient") {
                                  _selectedTypeMaterial = 1;
                                } else {
                                  _selectedTypeMaterial = 2;
                                }
                              });
                            },
                          ),
                        )),
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    Container(
                        child: Row(children: [
                      Text(
                        "Nama Item",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ])),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                          border: Border.all()),
                      child: CustomTextInput.getAutoCompleteFieldPurchasing(
                          context: context,
                          controller: _firstRequiredMaterial,
                          hint: "SKU Bahan",
                          textInputType: TextInputType.text,
                          itemBuilderCallback: _materialItemBuilder,
                          suggestionCallback: _onMaterialChanged,
                          onSuggestionSelectedCallback:
                              _onFirstRequiredMaterialSelected),
                    ),
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                  ],
                ),
              )),
          Container(
              child: Row(children: [
            Text(
              "Jumlah Item",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )
          ])),
          Padding(padding: EdgeInsets.only(top: 10.0)),
          Container(
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                border: Border.all()),
            child: TextField(
              controller: totalItem[indexChild],
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                hintText: "Masukkan Jumlah Item",
                fillColor: Colors.white,
              ),
              onChanged: (content) {
                int total = 0;
                int item = int.parse(totalItem[indexChild].text);
                int price = int.parse(priceItem[indexChild].text);
                total = item * price;
                // listTotal[position] = total;
                totalPriceItem[indexChild].text = total.toString();
                totalPrice = int.parse(totalPriceItem[indexChild].text);
              },
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 15.0)),
          Container(
              child: Row(children: [
            Text(
              "Harga Item",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )
          ])),
          Padding(padding: EdgeInsets.only(top: 10.0)),
          Container(
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                border: Border.all()),
            child: TextField(
              controller: priceItem[indexChild],
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                hintText: "Masukkan Harga",
                fillColor: Colors.white,
              ),
              onChanged: (content) {
                int total = 0;
                int item = int.parse(totalItem[indexChild].text);
                int price = int.parse(priceItem[indexChild].text);
                total = item * price;
                // listTotal[position] = total;
                totalPriceItem[indexChild].text = total.toString();
                totalPrice = int.parse(totalPriceItem[indexChild].text);
              },
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 15.0)),
          Container(
              child: Row(children: [
            Text(
              "Total Cost",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )
          ])),
          Padding(padding: EdgeInsets.only(top: 10.0)),
          Container(
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                border: Border.all()),
            child: TextField(
              enabled: false,
              controller: totalPriceItem[indexChild],
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                hintText: "Total Cost",
                fillColor: Colors.white,
              ),
            ),
          ),
          Visibility(
            visible: isLoaded,
            child: RaisedButton.icon(
              onPressed: () {
                print(totalItem.length);
                String _tipeBahan;
                String _nama;
                bool isValid = false;
                for (int i = 0; i < totalItem.length; i++) {
                  if (_selectedType == "Produk Jadi") {
                    print(totalPriceItem[i].text);
                    if (totalPrice > 0 && _selectedFirstProduct != "") {
                      print("OK");
                      purchasing.add(new PurchasingModel.listDetailPurchasing(
                          _selectedFirstProduct,
                          null,
                          null,
                          nameItem[i].text,
                          totalItem[i].text,
                          priceItem[i].text,
                          totalPriceItem[i].text,
                          "0"));
                      _tipeBahan = _selectedType;
                      _nama = _firstRequiredProduct.text;
                      setState(() {
                        isValid = true;
                      });
                    } else {
                      CustomDialog.getDialog(
                          title: "Peringatan",
                          message:
                              "Harap cek kembali field, pastikan data yang diisi valid.",
                          context: context,
                          popCount: 1);
                    }
                  } else {
                    if (totalPrice > 0 && _selectedFirstMaterial != "") {
                      if (_selectedTypeMaterial == 1) {
                        purchasing.add(new PurchasingModel.listDetailPurchasing(
                            null,
                            _selectedFirstMaterial,
                            null,
                            nameItem[i].text,
                            totalItem[i].text,
                            priceItem[i].text,
                            totalPriceItem[i].text,
                            "0"));
                        _tipeBahan = _selectMaterial[indexChild];
                        _nama = _firstRequiredMaterial.text;
                      } else {
                        print("Packaging");
                        purchasing.add(new PurchasingModel.listDetailPurchasing(
                            null,
                            null,
                            _selectedFirstMaterial,
                            nameItem[i].text,
                            totalItem[i].text,
                            priceItem[i].text,
                            totalPriceItem[i].text,
                            "0"));
                        _tipeBahan = _selectMaterial[indexChild];
                        _nama = _firstRequiredMaterial.text;
                      }
                      setState(() {
                        isValid = true;
                      });
                    } else {
                      CustomDialog.getDialog(
                          title: "Peringatan",
                          message:
                              "Harap cek kembali field, pastikan data yang diisi valid.",
                          context: context,
                          popCount: 1);
                    }
                  }
                }
                if (isValid) {
                  setState(() {
                    _listProductModel.add(new ProductModel.productPurchasing(
                        "0", _nama, _tipeBahan, purchasing));
                    _selectedMaterial[indexChild] = null;
                    totalPrice = 0;
                  });
                  clearPurchasing();
                  addMaterials();
                }
              },
              label: Text(
                "Add Plan",
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              shape: StadiumBorder(),
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFileWidget() {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            'Bukti Planning',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.15,
          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: _filesFromDevice.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text((index + 1).toString()),
                title: Text(_filesFromDevice[index].path.split("/").last ??
                    "File Path"),
                trailing: RaisedButton(
                    child: Text(
                      "Hapus",
                      style: TextStyle(color: AppTheme.white),
                    ),
                    color: AppTheme.red,
                    onPressed: () {
                      // remove image
                      _removeImagesFromDevice(index);
                    }),
              );
            },
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: RaisedButton(
            shape: StadiumBorder(),
            padding: EdgeInsets.only(left: 50, right: 50),
            onPressed: () {
              _openFileExplorer();
            },
            child: Text(
              "Tambah Bukti",
              style: TextStyle(color: AppTheme.white),
            ),
            color: AppTheme.teal,
          ),
        ),
      ],
    );
  }

  void buildListRencana(int position) {
    // edit_rencana = true;
    print("OIOI");
    clearPurchasing();
    setState(() {
      totalItem.add(new TextEditingController());
      priceItem.add(new TextEditingController());
      totalPriceItem.add(new TextEditingController());
      _listMaterial.add(_addMaterials(_indexWidgetMaterial));
      print(_indexWidgetMaterial);
      _selectMaterial.add("Ingredient");

      _selectMaterial[_indexWidgetMaterial] = _listProductModel[position].type;
      print(_listProductModel[position].name);
      _firstRequiredMaterial.text = " (" + _listProductModel[position].lisPurchasingDetail[position].name + ") " + _listProductModel[position].name;
      // print(_firstRequiredMaterial.text);
      totalItem[_indexWidgetMaterial].text = _listProductModel[position].lisPurchasingDetail[position].totalItem;
      priceItem[_indexWidgetMaterial].text = _listProductModel[position].lisPurchasingDetail[position].priceItem;
      totalPriceItem[_indexWidgetMaterial].text = _listProductModel[position].lisPurchasingDetail[position].priceTotalItem;
      // for (int i = 0; i < _listProductModel[position].lisPurchasingDetail.length; i++) {
      //
      // }
      _indexWidgetMaterial -= 1;
    });
  }
}
