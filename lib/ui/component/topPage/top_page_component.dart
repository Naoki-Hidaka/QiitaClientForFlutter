import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_client/bloc/ArticleBloc.dart';
import 'package:qiita_client/domain/entity/Article.dart';
import 'package:qiita_client/util/MyColor.dart';

class ListWidget extends StatelessWidget {
  final ArticleBloc bloc;

  const ListWidget(this.bloc);

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
    final colorGreen = primaryGreen;
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
