import 'dart:async';

import 'package:qiita_client/domain/entity/Article.dart';
import 'package:qiita_client/domain/repository/ArticleListRepository.dart';
import 'package:rxdart/rxdart.dart';

class ArticleBloc {
  final ArticleListRepository _articleListRepository = ArticleListRepository();
  final articleListController = StreamController<List<Article>>();

  final textFieldController = BehaviorSubject<String>.seeded("Android");

  void fetchArticle(Function fallback) async {
    _articleListRepository.fetchArticleList(textFieldController.value,
        (response) => articleListController.add(response), () => fallback());
  }

  void dispose() {
    articleListController.close();
    textFieldController.close();
  }
}
