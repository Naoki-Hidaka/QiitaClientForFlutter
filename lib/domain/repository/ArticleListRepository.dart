import 'package:qiita_client/domain/dataStore/ArticleListDataStore.dart';
import 'package:qiita_client/domain/entity/Article.dart';

class ArticleListRepository {
  final ArticleListDataStore articleListDataStore = ArticleListDataStore();

  void fetchArticleList(
      Function(List<Article>) callback, Function fallback) async {
    final response =
        await articleListDataStore.fetchArticleList("tags/Android/items");
    if (response.statusCode == 200) {
      callback(ArticleListFactory.create(response.body));
    } else {
      fallback();
    }
  }
}
