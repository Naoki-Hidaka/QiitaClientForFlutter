import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_client/bloc/ArticleListProvider.dart';
import 'package:qiita_client/ui/component/search_component.dart';
import 'package:qiita_client/ui/component/topPage/top_page_component.dart';

class MyPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = ArticleListProvider.of(context).bloc;
    bloc.fetchArticle();
    return Scaffold(
      appBar: AppBar(title: Text("QiitaClient")),
      body: ListWidget(bloc),
      floatingActionButton: searchButton(() => searchModal(context)),
    );
  }
}
