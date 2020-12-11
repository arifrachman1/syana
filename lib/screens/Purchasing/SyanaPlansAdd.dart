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
import 'package:syana/widgets/CustomDialog.dart';
import 'package:syana/widgets/CustomTextInput.dart';
import 'package:image/image.dart' as imgLib;

class SyanaPlansAdd extends StatefulWidget {
  @override
  _SyanaPlansAddState createState() => _SyanaPlansAddState();
}

class _SyanaPlansAddState extends State<SyanaPlansAdd> {
  int _indexProduct = 0,
      _indexMaterial = 0,
      _indexWidgetMaterial = 0,
      typeProduct = 0;
  String _selectedType;
  List<String> _selectMaterial = new List();
  List<String> _selectedFirstMaterial = new List();
  List<String> _selectedNameMaterial = new List();

  List<int> _selectedTypeMaterial = new List();
  List<TextEditingController> nameItem = new List();
  List<TextEditingController> totalItem = new List();
  List<TextEditingController> priceItem = new List();
  List<TextEditingController> totalPriceItem = new List();
  List<TextEditingController> _firstRequiredMaterial = new List();
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

  String _selectedFirstProduct = "";

  bool isCreate = true;
  bool isSelfProduct = false;
  bool isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    purchasingController = new PurchasingController();
    _dropDownType = getDropDownMenuItems(_typeProduct);
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
      _selectedFirstMaterial.add("SKU");
      _selectMaterial.add("Ingredient");
      _selectedNameMaterial.add("");

      _selectedTypeMaterial.add(1);
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

      _selectedFirstMaterial.add("SKU");
      _selectedNameMaterial.add("");

      _selectedTypeMaterial.add(1);
      _selectedMaterial
          .add(new MaterialModel.listMaterial("0", "0", "0", "0", "0"));

      _listMaterial.add(_addMaterials(_indexWidgetMaterial));
    });
  }

  void removeNewMaterials() {
    print("decrease more");
    setState(() {
      if (_indexMaterial > 0) {
        nameItem.removeAt(_indexMaterial);
        totalItem.removeAt(_indexMaterial);
        priceItem.removeAt(_indexMaterial);
        totalPriceItem.removeAt(_indexMaterial);

        _listMaterial.removeAt(_indexMaterial);
        _indexMaterial = _indexMaterial - 1;
      }
    });
  }

  FutureOr<Iterable<dynamic>> _onProductChanged(pattern) async {
    if (pattern.toString().length >= 3) {
      return await purchasingController.getProductData(context, pattern);
    }
  }

  _onFirstRequiredProductSelected(suggestion) {
    print(suggestion);
    if (suggestion is ProductModel) {
      setState(() {
        _firstRequiredProduct.text =
            suggestion.name + " (" + suggestion.sku + ") ";
        _selectedFirstProduct = suggestion.id;
      });
    }
  }

  Widget _productItemBuilder(context, item) {
    return ListTile(
      title: Text(item.name),
      subtitle: Text(item.sku),
    );
  }

  void clearPurchasing() {
    setState(() {
      nameItem.clear();
      totalItem.clear();
      priceItem.clear();
      totalPriceItem.clear();
      _listMaterial.clear();
      _selectedFirstMaterial.clear();
      _firstRequiredMaterial.clear();
      _selectedTypeMaterial.clear();
      _selectedMaterial.clear();
      _firstRequiredProduct.clear();
      _indexWidgetMaterial = 0;
    });
  }

  _sendPurchasing() async {
    String listPurchasing;
    listPurchasing = json.encode(purchasing);
    print(listPurchasing);
    await _supplyFiles();
    _filesToSend.forEach((element) {
      print(element.filename);
    });
    if (purchasing.isNotEmpty && _filesToSend.isNotEmpty) {
      await purchasingController.sendData(
          context, listPurchasing, _filesToSend);
      setState(() {
        _filesToSend.clear();
      });
    } else {
      CustomDialog.getDialog(
          title: "Peringatan",
          message:
              "Harap isi minimal satu plan purchasing dan satu bukti lampiran.",
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
    }
  }

  _supplyFiles() async {
    for (int i = 0; i < _filesFromDevice.length; i++) {
      _filesToSend.add(await MultipartFile.fromFile(_filesFromDevice[i].path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tambah Plan"),
          backgroundColor: Colors.lightGreen[300],
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed: () {
                _sendPurchasing();
              },
            )
          ],
        ),
        body: Container(
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
                      child: ListTile(
                        title: Text((position + 1).toString() +
                            " " +
                            _listProductModel[position].type),
                        onTap: () {
                          // buildListRencana(position);
                        },
                      ),
                    );
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
                            isSelfProduct = true;
                            isLoaded = true;
                          });
                          await purchasingController.getMaterialData(
                              context, setData, 1);
                        } else {
                          setState(() {
                            isSelfProduct = false;
                            isLoaded = true;
                          });
                        }
                      },
                    ),
                  )),
              Padding(padding: EdgeInsets.only(top: 15.0)),
              isLoaded
                  ? Visibility(
                      visible: !isSelfProduct,
                      child: Container(
                          child: Text(
                        "Cari Produk",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                    )
                  : Container(),
              isLoaded
                  ? Visibility(
                      visible: !isSelfProduct,
                      child: Container(
                        child: CustomTextInput.getCustomAutoCompleteField(
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
              isSelfProduct
                  ? Container(
                      child: Row(
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                addNewMaterials();
                              }),
                          IconButton(
                              icon: Icon(
                                Icons.remove,
                                color: AppTheme.red,
                              ),
                              onPressed: () {
                                removeNewMaterials();
                              }),
                        ],
                      ),
                    )
                  : Container(),
              Visibility(
                visible: isLoaded,
                child: RaisedButton.icon(
                  onPressed: () {
                    print(totalItem.length);
                    for (int i = 0; i < totalItem.length; i++) {
                      if (_selectedType == "Produk Jadi") {
                        purchasing.add(new PurchasingModel.listDetailPurchasing(
                            _selectedFirstProduct,
                            null,
                            null,
                            nameItem[i].text,
                            totalItem[i].text,
                            priceItem[i].text,
                            totalItem[i].text,
                            "0"));
                      } else {
                        if (_selectedTypeMaterial[i] == 1) {
                          purchasing.add(
                              new PurchasingModel.listDetailPurchasing(
                                  null,
                                  _selectedFirstMaterial[i],
                                  null,
                                  nameItem[i].text,
                                  totalItem[i].text,
                                  priceItem[i].text,
                                  totalItem[i].text,
                                  "0"));
                        } else {
                          purchasing.add(
                              new PurchasingModel.listDetailPurchasing(
                                  null,
                                  null,
                                  _selectedFirstMaterial[i],
                                  nameItem[i].text,
                                  totalItem[i].text,
                                  priceItem[i].text,
                                  totalItem[i].text,
                                  "0"));
                        }
                      }
                    }
                    setState(() {
                      _listProductModel.add(new ProductModel.productPurchasing(
                          _selectedFirstProduct,
                          _firstRequiredProduct.text,
                          _selectedType,
                          purchasing));
                    });
                    print(purchasing.length.toString());
                    clearPurchasing();
                    addMaterials();
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
              Padding(padding: EdgeInsets.only(top: 15.0)),
            ],
          ),
        ));
  }

  Widget _addMaterials(int indexChild) {
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
              visible: isSelfProduct,
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
                        width: 320,
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
                                  _selectedTypeMaterial[indexChild] = 1;
                                } else {
                                  _selectedTypeMaterial[indexChild] = 2;
                                }
                              });
                              await purchasingController.getMaterialData(
                                  context,
                                  setData,
                                  _selectedTypeMaterial[indexChild]);
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
                    _selectedNameMaterial[indexChild] != ""
                        ? Text(_selectedNameMaterial[indexChild])
                        : SearchableDropdown.single(
                            items: materialList.map((MaterialModel materials) {
                              return DropdownMenuItem<MaterialModel>(
                                value: materials,
                                child: Text(
                                  '(' +
                                      materials.sku +
                                      ')' +
                                      " " +
                                      materials.name,
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                            value: _selectedMaterial[indexChild],
                            hint: "Pilih Bahan",
                            searchHint: "Cari SKU Bahan",
                            onClear: () {
                              setState(() {
                                _selectedMaterial[indexChild] = null;
                              });
                            },
                            onChanged: (MaterialModel value) async {
                              if (value != null) {
                                print(value.id);
                                setState(() {
                                  _selectedMaterial[indexChild] = value;
                                  _selectedNameMaterial[indexChild] =
                                      value.name;
                                  _selectedFirstMaterial[indexChild] =
                                      value.id.toString();
                                });
                              }
                            },
                            isExpanded: true,
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
            'Berkas Bukti',
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
    clearPurchasing();
    setState(() {
      _listDetail = _listProductModel[position].lisPurchasingDetail;
      // print("list aktifasi: " + list_aktifitas_rencana.length.toString());
      _indexWidgetMaterial = _listDetail.length;
      print(_indexWidgetMaterial.toString());
      for (int i = 0; i < _indexWidgetMaterial; i++) {
        nameItem.add(new TextEditingController());
        totalItem.add(new TextEditingController());
        priceItem.add(new TextEditingController());
        totalPriceItem.add(new TextEditingController());
        _listMaterial.add(_addMaterials(i));

        nameItem[i].text = _listDetail[i].name;
        totalItem[i].text = _listDetail[i].totalItem;
        priceItem[i].text = _listDetail[i].priceItem;
        totalPriceItem[i].text = _listDetail[i].priceTotalItem;
      }
      _indexMaterial -= 1;
    });
  }
}
