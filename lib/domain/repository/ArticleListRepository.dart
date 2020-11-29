import 'package:qiita_client/domain/dataStore/ArticleListDataStore.dart';
import 'package:qiita_client/domain/entity/Article.dart';

class ArticleListRepository {
  final ArticleListDataStore articleListDataStore = ArticleListDataStore();

  Future<List<Article>> fetchArticleList() async {
    final response =
        await articleListDataStore.fetchArticleList("tags/Android/items");

    if (response.statusCode == 200) {
      return ArticleListFactory.create(response.body);
    } else {
      throw Exception("failed to load Article");
    }
  }
}
