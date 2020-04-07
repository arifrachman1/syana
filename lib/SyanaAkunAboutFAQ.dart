import 'package:flutter/material.dart';
import 'package:syana/utils/AppTheme.dart';
import 'main.dart';

class SyanaAkunAboutFAQ extends StatefulWidget {
  @override
  SyanaAkunAboutFAQState createState() => SyanaAkunAboutFAQState();
}

class SyanaAkunAboutFAQState extends State<SyanaAkunAboutFAQ> {
  List<List> question = [
    
  ];

  getQuestion(index, index2) {
    var selectedQuestion = question[index];
    return selectedQuestion[index2];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
        backgroundColor: AppTheme.teal,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: appBackground(),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              padding: EdgeInsets.only(left: 10),
              decoration: inputDecorationShadow(),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Cari Produk',
                  icon: Icon(
                    Icons.search,
                    color: AppTheme.teal,
                  ),
                ),
              ),
            ),
            Expanded(
              child: showData(),
            ),
          ],
        ),
      ),
    );
  }

  showData() {
    return question.isEmpty
        ? Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
            ),
            child: Text(
              'Tidak ada Data',
              style: TextStyle(
                color: AppTheme.text_light,
              ),
            ),
          )
        : Container(
            margin: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
            ),
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: question.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: listBackground(),
                  height: listHeightSmall(context),
                  margin: EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 17,
                        child: Container(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.image,
                            size: 60,
                            color: AppTheme.teal_light,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 66,
                        fit: FlexFit.tight,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                getQuestion(index, 0),
                                style: TextStyle(
                                  color: AppTheme.text_light,
                                  fontSize: 15,
                                ),
                                softWrap: true,
                              ),
                              Text(
                                getQuestion(index, 1),
                                style: TextStyle(
                                  color: AppTheme.text_light,
                                  fontSize: 13,
                                  fontStyle: FontStyle.italic,
                                ),
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 17,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            getQuestion(index, 2).toString(),
                            style: TextStyle(
                              color: AppTheme.text_light,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }
}
