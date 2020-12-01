import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_client/bloc/ArticleBloc.dart';
import 'package:qiita_client/bloc/ArticleListProvider.dart';
import 'package:qiita_client/ui/component/topPage/top_page_component.dart';
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
  final bloc = ArticleListProvider.of(context);
  showModalBottomSheet(
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
    context: context,
    builder: (BuildContext context) => searchModalContents(context, bloc),
  );
}

Widget searchModalContents(BuildContext context, ArticleBloc bloc) {
  return Container(
      height: 500,
      child: Padding(
        child: Column(
          children: [
            maxWidthText("タグ検索"),
            maxWidthTextField(24, bloc),
            maxWidthButton("OK", 30, Colors.white, primaryGreen,
                EdgeInsets.only(top: 20), bloc, context)
          ],
        ),
        padding: EdgeInsets.only(left: 16, right: 16, top: 40),
      ));
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

Widget maxWidthButton(
    String text,
    double fontSize,
    Color fontColor,
    Color backgroundColor,
    EdgeInsetsGeometry padding,
    ArticleBloc bloc,
    BuildContext context) {
  return Padding(
    child: RaisedButton(
      onPressed: () {
        Navigator.pop(context);
        bloc.fetchArticle(() => showErrorDialog(context, bloc.fetchArticle));
        bloc.articleListController.add(null);
      },
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

Widget maxWidthTextField(double fontSize, ArticleBloc bloc) {
  return Padding(
      child: Center(
          child: StreamBuilder(
              stream: bloc.textFieldController.stream,
              builder: (context, AsyncSnapshot<String> snapShot) => TextField(
                    style: TextStyle(fontSize: fontSize),
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryGreen))),
                    onChanged: (text) {
                      bloc.textFieldController.sink.add(text);
                    },
                  ))),
      padding: EdgeInsets.only(top: 16, bottom: 16));
}
