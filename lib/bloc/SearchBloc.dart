import 'package:flutter/cupertino.dart';

class SearchBloc {
  final focus = FocusNode();
  bool isFocus = false;
  var viewHeight = 400;

  void onFocusChange() {
    isFocus = focus.hasFocus;
  }
}
