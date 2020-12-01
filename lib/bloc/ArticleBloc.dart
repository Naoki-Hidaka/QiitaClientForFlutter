import 'package:qiita_client/domain/entity/Article.dart';
import 'package:qiita_client/domain/repository/ArticleListRepository.dart';
import 'package:rxdart/rxdart.dart';

class ArticleBloc {
  final ArticleListRepository _articleListRepository = ArticleListRepository();
  final articleListController = BehaviorSubject<List<Article>>();

  final textFieldController = BehaviorSubject<String>();

  void fetchArticle(Function fallback) async {
    if (textFieldController.value == null) {
      textFieldController.value = "Android";
    }
    _articleListRepository.fetchArticleList(textFieldController.value,
        (response) => articleListController.add(response), () => fallback());
    textFieldController.value = null;
  }

  void dispose() {
    articleListController.close();
    textFieldController.close();
  }
}
