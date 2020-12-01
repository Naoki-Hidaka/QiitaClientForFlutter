import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_client/ui/component/search_component.dart';
import 'package:qiita_client/ui/component/topPage/top_page_component.dart';

class MyPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Qiita Client")),
      body: ListWidget(),
      floatingActionButton: searchButton(() => showSearchModal(context)),
      resizeToAvoidBottomInset: false,
    );
  }
}
