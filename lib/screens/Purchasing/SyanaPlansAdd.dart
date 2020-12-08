import 'package:flutter/material.dart';
import 'package:syana/models/PurchasingModel.dart';
import 'package:syana/utils/AppTheme.dart';

class SyanaPlansAdd extends StatefulWidget {
  @override
  _SyanaPlansAddState createState() => _SyanaPlansAddState();
}

class _SyanaPlansAddState extends State<SyanaPlansAdd> {
  int _count = 0, _indexProduct = 0, _indexMaterial = 0;
  String _selectedType;
  List<String> _selectMaterial, _selectedProduct = new List();
  List<TextEditingController> nameItem = new List();
  List<TextEditingController> totalItem = new List();
  List<TextEditingController> priceItem = new List();
  List<TextEditingController> totalPriceItem = new List();
  List _product = ["Product 1", "Product 2", "Product 3", "Product 4"];
  List _typeProduct = ["Produk Sendiri", "Produk Jadi"];
  List _materialType = ["Ingredient", "Packaging"];
  List<Widget> _listProduct = new List();
  List<Widget> _listMaterial = new List();
  List<PurchasingModel> _listDetail = new List();
  List<DropdownMenuItem<String>> _dropDownType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buildProduct();
    _dropDownType = getDropDownMenuItems(_typeProduct);
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems(List filters) {
    List<DropdownMenuItem<String>> items = new List();
    for (String filter in filters) {
      items.add(new DropdownMenuItem(value: filter, child: new Text(filter)));
    }
    return items;
  }

  void buildProduct(){
    setState(() {
      _selectedProduct.add("Product 1");
      _listProduct.add(_addProduct(_indexProduct));
    });
    addMaterials();
  }

  void addNewProduct(){
    setState(() {
      _indexProduct++;
      _selectedProduct.add("Product 1");
      _listProduct.add(_addProduct(_indexProduct));
    });
    // addMaterials();
  }

  void addMaterials() {
    setState(() {
      // _selectMaterial.add("Ingredient");
      nameItem.add(new TextEditingController());
      totalItem.add(new TextEditingController());
      priceItem.add(new TextEditingController());
      totalPriceItem.add(new TextEditingController());

      _listMaterial.add(_addMaterials(_indexMaterial));
    });
  }

  void addNewMaterials() {
    setState(() {
      _indexMaterial++;
      // _selectMaterial.add("Ingredient");
      nameItem.add(new TextEditingController());
      totalItem.add(new TextEditingController());
      priceItem.add(new TextEditingController());
      totalPriceItem.add(new TextEditingController());

      _listMaterial.add(_addMaterials(_indexMaterial));
    });
  }

  void removeNewMaterials() {
    print("decrease more");
    setState(() {
      if (_indexMaterial > 0) {
        _selectMaterial.removeAt(_indexMaterial);
        nameItem.removeAt(_indexMaterial);
        totalItem.removeAt(_indexMaterial);
        priceItem.removeAt(_indexMaterial);
        totalPriceItem.removeAt(_indexMaterial);

        _listMaterial.removeAt(_indexMaterial);
        _indexMaterial = _indexMaterial - 1;
      }
    });
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
              onPressed: () => debugPrint('FlatButton di tekan'),
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
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _listProduct.length,
                  itemBuilder: (context, position) {
                    _indexProduct = position;
                    return _addProduct(position);
                  },
                ),
              ),
              RaisedButton(onPressed: (){
                addNewProduct();
              }, child: Text("Tambah Produk"),)
            ],
          ),
        ));
  }

  Widget _addProduct(int indexProduct){
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 15.0)),
              Container(
                  child: Row(children: [
                    Text(
                      "Pilih Jenis Produk",
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
                      hint: Text("Tipe Produk"),
                      value: _selectedType,
                      items: _dropDownType,
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value;
                        });
                      },
                    ),
                  )),
              Padding(padding: EdgeInsets.only(top: 15.0)),
              Container(
                  child: Row(children: [
                    Text(
                      "Pilih Produk",
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
                      hint: Text("Pilih Produk"),
                      value: _selectedProduct[indexProduct],
                      items: _product.map((value) {
                        return DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedProduct[indexProduct] = value;
                        });
                      },
                    ),
                  )),
              Container(
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
              Container(
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
              ),
              Padding(padding: EdgeInsets.only(top: 15.0)),
              Container(
                  child: Row(children: [
                    Text(
                      "Upload Gambar",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ])),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              RaisedButton.icon(
                icon: Padding(
                  padding:
                  EdgeInsets.only(top: 10, bottom: 10, right: 10),
                  child: Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                  ),
                ),
                color: AppTheme.btn_success,
                onPressed: () {},
                label: Text(
                  "Gambar",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ));
  }

  Widget _addMaterials(int index) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 5.0)),
          Container(
              child: Row(children: [
            Text(
              "Pilih Jenis Bahan",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )
          ])),
          Padding(padding: EdgeInsets.only(top: 10.0)),
          // Container(
          //     width: 320,
          //     padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(10.0),
          //         color: Colors.white,
          //         border: Border.all()),
          //     child: DropdownButtonHideUnderline(
          //       child: DropdownButton(
          //         hint: Text("Pilih Jenis Bahan"),
          //         value: _selectMaterial[index],
          //         items: _materialType.map((value) {
          //           return DropdownMenuItem(
          //             child: Text(value),
          //             value: value,
          //           );
          //         }).toList(),
          //         onChanged: (value) {
          //           setState(() {
          //             _selectMaterial[index] = value;
          //           });
          //         },
          //       ),
          //     )),
          Padding(padding: EdgeInsets.only(top: 15.0)),
          Container(
              child: Row(children: [
            Text(
              "Nama Item",
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
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                hintText: "Masukkan Nama Item",
                fillColor: Colors.white,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 15.0)),
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
              controller: totalItem[index],
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                hintText: "Masukkan Jumlah Item",
                fillColor: Colors.white,
              ),
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
              controller: priceItem[index],
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                hintText: "Masukkan Harga",
                fillColor: Colors.white,
              ),
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
              controller: totalPriceItem[index],
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
}
