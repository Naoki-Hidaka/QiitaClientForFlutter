import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:qiita_client/bloc/ArticleBloc.dart';
import 'package:qiita_client/bloc/ArticleListProvider.dart';
import 'package:qiita_client/util/HexColor.dart';

import 'domain/entity/Article.dart';

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
      ),
      home: ArticleListProvider(
        widget: _MyPageWidget(),
      ),
    );
  }
}

class _MyPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = ArticleListProvider.of(context).bloc;
    bloc.fetchArticle();
    return Scaffold(
      appBar: AppBar(title: Text("QiitaClient")),
      body: _ListWidget(bloc),
    );
  }
}

class _ListWidget extends StatelessWidget {
  final ArticleBloc bloc;

  const _ListWidget(this.bloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.articleListController.stream,
        builder: (context, AsyncSnapshot<List<Article>> snapShot) {
          if (snapShot.hasData) {
            return ListView.separated(
              itemBuilder: (context, position) => _ListItemWidget(
                  snapShot.data[position].title,
                  snapShot.data[position].tags,
                  snapShot.data[position].formatDate),
              itemCount: snapShot.data.length,
              separatorBuilder: (context, position) => Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

class _ListItemWidget extends StatelessWidget {
  final String title;
  final String dateText;
  final List<Tags> tags;

  const _ListItemWidget(this.title, this.tags, this.dateText);

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Center(
          child: SingleChildScrollView(
              child: Column(
        children: [_title(), _tagList(), _date()],
      ))),
      padding: EdgeInsets.only(top: 16, bottom: 8),
    );
  }

  Widget _title() {
    return Padding(
      child: Text(title,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      padding: EdgeInsets.only(right: 16, left: 16, bottom: 16),
    );
  }

  Widget _tagList() {
    return SizedBox(
        height: 44,
        child: ListView.builder(
          itemBuilder: (context, position) => _tagWidget(tags[position]),
          itemCount: tags.length,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: 16, right: 16),
        ));
  }

  Widget _date() {
    return Padding(
      child: Align(
        alignment: Alignment.bottomRight,
        child: Text(
          dateText,
          style: TextStyle(fontSize: 14),
        ),
      ),
      padding: EdgeInsets.only(right: 16, top: 8),
    );
  }

  Widget _tagWidget(Tags tag) {
    final colorGreen = HexColor("55c500");
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.only(top: 8, bottom: 8, right: 16, left: 16),
      child: Center(
        child: Text(
          tag.name,
          style: TextStyle(color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: colorGreen),
          color: colorGreen),
    );
  }
}
