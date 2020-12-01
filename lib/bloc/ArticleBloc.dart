import 'dart:async';

import 'package:qiita_client/domain/entity/Article.dart';
import 'package:qiita_client/domain/repository/ArticleListRepository.dart';

class ArticleBloc {
  final ArticleListRepository _articleListRepository = ArticleListRepository();
  final articleListController = StreamController<List<Article>>();

  void fetchArticle(Function fallback) async {
    _articleListRepository.fetchArticleList(
        (response) => articleListController.add(response), () => fallback());
  }

  void dispose() {
    articleListController.close();
  }
}
