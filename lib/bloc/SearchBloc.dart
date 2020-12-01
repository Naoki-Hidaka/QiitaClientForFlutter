import 'dart:async';

import 'package:flutter/cupertino.dart';

class SearchBloc {
  SearchBloc() {
    focus.addListener(onFocusChange);
  }

  final focus = FocusNode();
  bool isFocus = false;
  var viewHeight = 400;

  final viewHeightStream = StreamController<double>();

  void onFocusChange() {
    isFocus = focus.hasFocus;
    if (isFocus) {
      viewHeightStream.sink.add(600);
    } else {
      viewHeightStream.sink.add(400);
    }
  }

  void dispose() {
    viewHeightStream.close();
  }
}
