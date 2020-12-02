import 'package:qiita_client/domain/dataStore/ArticleListDataStore.dart';
import 'package:qiita_client/domain/entity/Article.dart';

class ArticleListRepository {
  final ArticleListDataStore articleListDataStore = ArticleListDataStore();

  void fetchArticleList(String tag, int pageCount,
      Function(List<Article>) callback, Function fallback) async {
    print(pageCount);
    await articleListDataStore
        .fetchArticleList(
            "tags/$tag/items?per_page=10&page=${pageCount.toString()}")
        .then((response) => {
              if (response.statusCode == 200)
                {callback(ArticleListFactory.create(response.body))}
            })
        .catchError((error) => {print(error), fallback()});
    // if (response.statusCode == 200) {
    //   callback(ArticleListFactory.create(response.body));
    // } else {
    //   fallback();
    // }
  }
}
