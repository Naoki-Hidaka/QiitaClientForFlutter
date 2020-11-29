import 'dart:convert' show json;

import 'package:intl/date_symbol_data_local.dart';
import "package:intl/intl.dart";

class Article {
  final String id;
  final String title;
  final String createdAt;
  final List<Tags> tags;
  final String url;

  Article(this.id, this.title, this.createdAt, this.tags, this.url);

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(json["id"], json["title"], json["created_at"],
        Tags.tagsFactory(json["tags"]), json["url"]);
  }

  String get formatDate {
    initializeDateFormatting("ja_JP");

    DateTime dateTime = DateTime.parse(createdAt);
    var formatter = DateFormat("yyyy/MM/dd", "ja_JP");
    var formatted = formatter.format(dateTime);
    return formatted;
  }
}

class Tags {
  final String name;

  Tags(this.name);

  static List<Tags> tagsFactory(List<dynamic> json) {
    final parsed = json.cast<Map<dynamic, dynamic>>();
    return parsed.map((e) => Tags(e["name"])).toList();
  }
}

class ArticleListFactory {
  static List<Article> create(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<Article>((json) => Article.fromJson(json)).toList();
  }
}
