import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:qiita_client/bloc/ArticleBloc.dart';
import 'package:qiita_client/bloc/ArticleListProvider.dart';
import 'package:qiita_client/ui/screen/top_page.dart';
import 'package:qiita_client/util/MyColor.dart';

void main() async {
  await DotEnv().load(".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          hintColor: primaryGreen,
          primaryColor: primaryGreen),
      home: ArticleListProvider(
        widget: MyPageWidget(),
        bloc: ArticleBloc(),
      ),
    );
  }
}
