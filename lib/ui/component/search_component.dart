import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_client/util/HexColor.dart';

Widget searchButton(Function clickAction) {
  return FloatingActionButton(
    child: Icon(
      Icons.search,
    ),
    onPressed: () {
      clickAction();
    },
    backgroundColor: HexColor("55c500"),
  );
}

void searchModal(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 600,
          child: Center(child: Text("modal")),
        );
      });
}
