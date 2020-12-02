import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ArticleListDataStore {
  static ArticleListDataStore _articleListDataStore;

  factory ArticleListDataStore() =>
      _articleListDataStore ?? ArticleListDataStore._internal();

  ArticleListDataStore._internal() {
    _articleListDataStore = this;
  }

  Future<http.Response> fetchArticleList(String endPoint) async {
    final response = await http.get("$BASE_URL/$endPoint",
        headers: {"Authorization": "Bearer $ACCESS_TOKEN"});
    return response;
  }
}

final String BASE_URL = "https://qiita.com/api/v2/";
final String ACCESS_TOKEN = DotEnv().env["ACCESS_TOKEN"];
