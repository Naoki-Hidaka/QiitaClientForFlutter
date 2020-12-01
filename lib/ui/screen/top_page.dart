import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_client/bloc/ArticleListProvider.dart';
import 'package:qiita_client/ui/component/search_component.dart';
import 'package:qiita_client/ui/component/topPage/top_page_component.dart';

class MyPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = ArticleListProvider.of(context).bloc;
    bloc.fetchArticle(() => showErrorDialog(context, bloc.fetchArticle));
    return Scaffold(
      appBar: AppBar(title: Text("QiitaClient")),
      body: ListWidget(bloc),
      floatingActionButton: searchButton(() => showSearchModal(context)),
      resizeToAvoidBottomInset: false,
    );
  }
}

void showErrorDialog(BuildContext context, Function fetchFunction) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("エラー"),
          content: Text("通信エラーが起きました"),
          actions: [
            FlatButton(
              child: Text("リトライ "),
              onPressed: () => fetchFunction,
            )
          ],
        );
      });
}
