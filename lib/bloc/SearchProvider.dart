import 'package:flutter/cupertino.dart';
import 'package:qiita_client/bloc/SearchBloc.dart';

class SearchProvider extends InheritedWidget {
  const SearchProvider({Key key, Widget widget})
      : super(key: key, child: widget);

  SearchBloc get bloc => SearchBloc();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static SearchProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SearchProvider>() ??
        context.getElementForInheritedWidgetOfExactType<SearchProvider>();
  }
}
