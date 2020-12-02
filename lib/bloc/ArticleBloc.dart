import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_client/domain/entity/Article.dart';
import 'package:qiita_client/domain/repository/ArticleListRepository.dart';
import 'package:rxdart/rxdart.dart';

class ArticleBloc {
  final ArticleListRepository _articleListRepository = ArticleListRepository();
  final articleListController = PublishSubject<List<Article>>();

  final textFieldController = BehaviorSubject<String>();

  var pageCount = 1;

  final List<Article> _articleList = [];

  void fetchArticle(BuildContext context) async {
    bool loading = false;
    if (loading) {
      return;
    }
    loading = true;
    if (textFieldController.value == null) {
      textFieldController.value = "Android";
    }
    _articleListRepository.fetchArticleList(
      textFieldController.value,
      pageCount,
      (response) {
        if (response != null) {
          _articleList.addAll(response);
        }
        articleListController.sink.add(_articleList);
        loading = false;
      },
      () => showErrorDialog(context),
    );
    textFieldController.value = null;
    pageCount++;
  }

  void dispose() {
    articleListController.close();
    textFieldController.close();
  }

  void showErrorDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("エラー"),
            content: Text("通信エラーが起きました"),
            actions: [
              FlatButton(
                child: Text("リトライ "),
                onPressed: () {
                  fetchArticle(context);
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
