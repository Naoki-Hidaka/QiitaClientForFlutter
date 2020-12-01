import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qiita_client/bloc/SearchBloc.dart';
import 'package:qiita_client/bloc/SearchProvider.dart';
import 'package:qiita_client/util/MyColor.dart';

Widget searchButton(Function clickAction) {
  return FloatingActionButton(
    child: Icon(
      Icons.search,
    ),
    onPressed: () {
      clickAction();
    },
    backgroundColor: primaryGreen,
  );
}

void showSearchModal(BuildContext context) {
  final bloc = SearchBloc();
  final FocusNode _focus = FocusNode();
  showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      context: context,
      builder: (BuildContext context) {
        return SearchProvider(
            widget: Container(
          height: 400,
          child: searchModalContents(),
        ));
      });
}

Widget searchModalContents() {
  return Padding(
    child: Column(
      children: [
        maxWidthText("タグ検索"),
        Padding(
            child: Center(
                child: TextField(
              style: TextStyle(fontSize: 24),
            )),
            padding: EdgeInsets.only(top: 16, bottom: 16)),
        maxWidthButton(
            "OK", 30, Colors.white, primaryGreen, EdgeInsets.only(top: 20))
      ],
    ),
    padding: EdgeInsets.only(left: 16, right: 16, top: 40),
  );
}

Widget maxWidthText(String text) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      Text(
        text,
        style: TextStyle(fontSize: 24),
      ),
    ],
  );
}

Widget maxWidthButton(String text, double fontSize, Color fontColor,
    Color backgroundColor, EdgeInsetsGeometry padding) {
  return Padding(
    child: RaisedButton(
      onPressed: () => Fluttertoast.showToast(msg: "Button Clicked"),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            child: Text(text,
                style: TextStyle(fontSize: fontSize, color: fontColor)),
            padding: EdgeInsets.only(top: 10, bottom: 10),
          )
        ],
      ),
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
    ),
    padding: padding,
  );
}
