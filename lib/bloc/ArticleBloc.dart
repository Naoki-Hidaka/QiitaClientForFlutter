import 'dart:async';

import 'package:qiita_client/domain/entity/Article.dart';
import 'package:qiita_client/domain/repository/ArticleListRepository.dart';

class ArticleBloc {
  final ArticleListRepository _articleListRepository = ArticleListRepository();
  final articleListController = StreamController<List<Article>>();

  void fetchArticle() async {
    final _articleListResponse =
        await _articleListRepository.fetchArticleList();
    articleListController.add(_articleListResponse);
  }

  void dispose() {
    articleListController.close();
  }
}
