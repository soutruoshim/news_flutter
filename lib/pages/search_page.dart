import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../logics/news_logic.dart';
import '../models/top_head_line.dart';
import '../widgets/widget_item_news.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controllerKeyword = TextEditingController();
  final focusNodeIconSearch = FocusNode();

  @override
  void initState() {
    controllerKeyword.addListener(_onSearching);
    super.initState();
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
    bool isLoading = context.watch<NewsLogic>().isLoading;

    // if(isLoading){
    //   return Center(child: CircularProgressIndicator(
    //     color: Colors.greenAccent, //<-- SEE HERE
    //     backgroundColor: Colors.grey, //<-- SEE HERE
    //   ),);
    // }
    //
    // String? error = context.watch<NewsLogic>().error;
    // if(error != null){
    //   debugPrint("Error: $error");
    //   return Center(child: Text("Something went wrong"),);
    // }

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
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          context.read<NewsLogic>().setLoading(false);
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Platform.isIOS
                              ? Icons.arrow_back_ios
                              : Icons.arrow_back,
                        ),
                      ),
                      SizedBox(width: 18),
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
                                    hintText: 'Searching something?',
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
                      child: isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Colors.greenAccent, //<-- SEE HERE
                              backgroundColor: Colors.grey, //<-- SEE HERE
                            ))
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                var itemArticle = data.articles![index];
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
                              itemCount: data.articles!.length,
                            )),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  void _onSearching() {
    var keyword = controllerKeyword.text.trim();
    if (!keyword.isEmpty) {
      context.read<NewsLogic>().setLoading(true);
      context.read<NewsLogic>().read(query: keyword);
    }
  }
}
