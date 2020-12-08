import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@optionalTypeArgs
abstract class DefaultView<T extends StatefulWidget> extends State {
  bool isLoading = false;

  setLoadingState() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  setData(data);

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    } else {
      return;
    }
  }

  T getWidget() {
    return widget;
  }
}
