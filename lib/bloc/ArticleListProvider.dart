import 'package:flutter/cupertino.dart';
import 'package:qiita_client/bloc/ArticleBloc.dart';

class ArticleListProvider extends InheritedWidget {
  final ArticleBloc bloc;

  ArticleListProvider({Key key, @required Widget widget, @required this.bloc})
      : super(key: key, child: widget);

  @override
  bool updateShouldNotify(ArticleListProvider oldWidget) =>
      bloc != oldWidget.bloc;

  static ArticleBloc of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ArticleListProvider>()
        .bloc;
  }
}
