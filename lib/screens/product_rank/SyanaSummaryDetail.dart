import 'package:flutter/material.dart';

class SyanaSummaryDetail extends StatefulWidget {
  @override
  _SyanaSummaryDetailState createState() => _SyanaSummaryDetailState();
}

class _SyanaSummaryDetailState extends State<SyanaSummaryDetail> {
  List<String> _item = new List();

  bool _isLoading = false;

  itemSummary() {
    setState(() {
      _item.add("Item A 1x");
      _item.add("Item B 2x");
      _item.add("Item C 3x");
      _item.add("Item D 4x");
      _item.add("Item E 5x");
      _item.add("Item F 6x");
      _item.add("Item G 7x");
      _item.add("Item H 8x");
      _item.add("Item I 9x");
      _item.add("Item J 10x");
      _item.add("Item K 11x");
      _item.add("Item L 12x");
      _item.add("Item M 13x");
      _item.add("Item N 14x");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    itemSummary();
  }

  void setLoadingState() {
    setState(() {
      _isLoading = _isLoading ? _isLoading = false : _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Summary Detail"), backgroundColor: Colors.lightGreen),
        backgroundColor: Colors.lightGreen[200],
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    //color: Colors.red,
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Text(
                          "Sales : ",
                          style: TextStyle(
                            fontSize: 21,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                          "Ari",
                          style: TextStyle(
                            fontSize: 21,
                          ),
                        ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Row(
                      children: [
                        Text(
                          "Packaging : ",
                          style: TextStyle(
                            fontSize: 21,
                          ),
                        ),
                        Text(
                          "Dita",
                          style: TextStyle(
                            fontSize: 21,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      //color: Colors.red,
                      child: ListView.builder(
                            itemCount: _item.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  padding: EdgeInsets.all(7.0),
                                  margin: EdgeInsets.all(7.0),
                                  child: Text(
                                    _item[index],
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ));
                            }))),
                  
                ],
              )
              )
        );
  }
}
