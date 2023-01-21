import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../db/db_helper.dart';
import '../logics/news_logic.dart';
import '../models/top_head_line.dart';
import '../widgets/widget_item_news.dart';

class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  final controllerKeyword = TextEditingController();
  final focusNodeIconSearch = FocusNode();
  List<Map<String, dynamic>> _bookmarkList = [];
  bool _isLoading = false;

  @override
  void initState() {
    controllerKeyword.addListener(_onSearching);
    super.initState();
    _refreshBookmark();
  }

  @override
  void dispose() {
    focusNodeIconSearch.dispose();
    controllerKeyword.removeListener(_onSearching);
    controllerKeyword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var isDarkTheme = theme.brightness == Brightness.dark;

    TopHeadlineNews? data = context.watch<NewsLogic>().topHeadlineNews;
    print(data!.articles!.length);

    return Scaffold(
        body: Container(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                color: isDarkTheme ? null : Color(0xFFEFF5F5),
              ),
              SafeArea(
                child: Container(
                  color: isDarkTheme ? null : Color(0xFFEFF5F5),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  child: Column(
                    children: <Widget>[
                      _header(),
                      SizedBox(height: 16,),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(99.0),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextField(
                                      controller: controllerKeyword,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: 'Searching bookmarks?',
                                        hintStyle: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey,
                                        ),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Hero(
                                    tag: 'iconSearch',
                                    child: Focus(
                                      focusNode: focusNodeIconSearch,
                                      child: Icon(
                                        Icons.search,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Expanded(
                          child: newsBookmarks()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
  Widget _header(){
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              'Bookmakrs',
              style: TextStyle(
                fontSize: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSearching() {
    var keyword = controllerKeyword.text.trim();
    print(keyword);
    if (keyword.isNotEmpty) {
       print("check $keyword");
      _isLoading = true;
      _refreshBookmark(query: keyword);
    }
  }
  Widget newsBookmarks() {
    return _isLoading
        ? const Center(
      child: CircularProgressIndicator(),
    )
        :
    RefreshIndicator(
      onRefresh: _refreshBookmark,
      backgroundColor: Colors.blue.shade400,
      color: Colors.white,
      displacement: 200,
      strokeWidth: 5,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          var itemArticle = Articles(source: Source(id: "",
              name: _bookmarkList[index]['source']),
              author: _bookmarkList[index]['source'],
              title: _bookmarkList[index]['title'],
              description: _bookmarkList[index]['description'],
              url: _bookmarkList[index]['url'],
              urlToImage: _bookmarkList[index]['urlToImage'],
              publishedAt: _bookmarkList[index]['publishedAt'],
              content: _bookmarkList[index]['content'],
          );
          var dateTimePublishedAt =
          DateFormat('yyy-MM-ddTHH:mm:ssZ').parse(
              itemArticle.publishedAt ?? "", true);
          var strPublishedAt =
          DateFormat('MMM dd, yyyy HH:mm')
              .format(dateTimePublishedAt);
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: WidgetItemNews(
              itemArticle: itemArticle,
              strPublishedAt: strPublishedAt,
            ),
          );
        },
        itemCount: _bookmarkList.length,
      ),
    );
  }


  Future _refreshBookmark({String query = ""}) async {
    var data = await SQLHelper.getItems();
    if(query.isNotEmpty) {
       data =  await SQLHelper.searchItems(query: query);
    }
    setState(() {
      _bookmarkList = data;
      _isLoading = false;
    });
  }
}


