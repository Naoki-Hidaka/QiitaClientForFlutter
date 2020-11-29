import 'package:flutter/cupertino.dart';
import 'package:qiita_client/bloc/ArticleBloc.dart';

class ArticleListProvider extends InheritedWidget {
  const ArticleListProvider({Key key, Widget widget})
      : super(key: key, child: widget);

  ArticleBloc get bloc => ArticleBloc();

  @override
  bool updateShouldNotify(_) => true;

  static ArticleListProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ArticleListProvider>() ??
        context.getElementForInheritedWidgetOfExactType<ArticleListProvider>();
  }
}
