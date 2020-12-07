import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syana/DefaultView.dart';
import 'package:syana/Controller/BookmarkController.dart';
import 'package:syana/models/BookmarkModel.dart';
import 'package:syana/utils/AppTheme.dart';

class Bookmark extends StatefulWidget {
  _State createState() => _State();
}

class _State extends DefaultView<Bookmark> {
  List<BookmarkModel> _list = new List();

  BookmarkController _bookmarkController;

  @override
  void initState() {
    super.initState();
    _bookmarkController = new BookmarkController();
    _init();
  }

  _init() async {
    _list.clear();
    _bookmarkController.getBookmarks(context, setLoadingState, setData);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text("Bookmark"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        decoration: AppTheme.appBackground(),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: SizedBox(
                      child: ListView.builder(
                        itemCount: _list.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(_list[index].title),
                            subtitle: Text(_list[index].date),
                            onTap: () {
                              log("translate and navigate to");
                              _bookmarkController.translateAndNavigateTo(
                                  _list[index], context);
                            },
                            trailing: PopupMenuButton(
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: Text("Hapus Bookmark"),
                                  value: 1,
                                ),
                              ],
                              onSelected: (value) async {
                                switch (value) {
                                  case 1:
                                    var result = await _bookmarkController
                                        .removeBookmark(
                                            context,
                                            setLoadingState,
                                            _list[index].idBookmark);

                                    log(result.toString());

                                    if (result == 200) {
                                      _init();
                                    }
                                    break;
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  @override
  setData(data) {
    // TODO: implement setData
    log("data received!\n${data.toString()}");

    if (data is Map) {
      switch (data['key']) {
        case BookmarkDataKey.list:
          setState(() {
            _list = data['payload'];
          });
          break;
      }
    }
  }
}
