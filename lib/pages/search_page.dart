import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    var listArticles = <Articles>[
      Articles(
          source: Source(id: "1", name: "CBC"),
          author: "Leslie Josephs",
          title: "FAA says contractor unintentionally deleted files before outage disrupted thousands of flights - CNBC",
          description: "Around 10,000 flights were delayed because of the outage of a pilot-alerting system.",
          url: "https://www.cnbc.com/2023/01/20/faa-outage-that-delayed-thousands-of-flights-caused-by-contractor-who-deleted-files.html",
          urlToImage: "https://image.cnbcfm.com/api/v1/image/107177181-1673449421857-gettyimages-1246152990-AFP_336V6W3.jpeg?v=1674179028&w=1920&h=1080",
          publishedAt: "2023-01-20T01:43:00Z",
          content: "The Federal Aviation Administration said Thursday that a contractor unintentionally deleted files before an outage of a pilot-alert system that delayed thousands of flights last week.\r\n\"A preliminary… [+1355 chars]"
      ),
      Articles(
          source: Source(id: "1", name: "CBC"),
          author: "Leslie Josephs",
          title: "FAA says contractor unintentionally deleted files before outage disrupted thousands of flights - CNBC",
          description: "Around 10,000 flights were delayed because of the outage of a pilot-alerting system.",
          url: "https://www.cnbc.com/2023/01/20/faa-outage-that-delayed-thousands-of-flights-caused-by-contractor-who-deleted-files.html",
          urlToImage: "https://image.cnbcfm.com/api/v1/image/107177181-1673449421857-gettyimages-1246152990-AFP_336V6W3.jpeg?v=1674179028&w=1920&h=1080",
          publishedAt: "2023-01-20T01:43:00Z",
          content: "The Federal Aviation Administration said Thursday that a contractor unintentionally deleted files before an outage of a pilot-alert system that delayed thousands of flights last week.\r\n\"A preliminary… [+1355 chars]"
      ),
      Articles(
          source: Source(id: "1", name: "CBC"),
          author: "Leslie Josephs",
          title: "FAA says contractor unintentionally deleted files before outage disrupted thousands of flights - CNBC",
          description: "Around 10,000 flights were delayed because of the outage of a pilot-alerting system.",
          url: "https://www.cnbc.com/2023/01/20/faa-outage-that-delayed-thousands-of-flights-caused-by-contractor-who-deleted-files.html",
          urlToImage: "https://image.cnbcfm.com/api/v1/image/107177181-1673449421857-gettyimages-1246152990-AFP_336V6W3.jpeg?v=1674179028&w=1920&h=1080",
          publishedAt: "2023-01-20T01:43:00Z",
          content: "The Federal Aviation Administration said Thursday that a contractor unintentionally deleted files before an outage of a pilot-alert system that delayed thousands of flights last week.\r\n\"A preliminary… [+1355 chars]"
      ),
      Articles(
          source: Source(id: "1", name: "CBC"),
          author: "Leslie Josephs",
          title: "FAA says contractor unintentionally deleted files before outage disrupted thousands of flights - CNBC",
          description: "Around 10,000 flights were delayed because of the outage of a pilot-alerting system.",
          url: "https://www.cnbc.com/2023/01/20/faa-outage-that-delayed-thousands-of-flights-caused-by-contractor-who-deleted-files.html",
          urlToImage: "https://image.cnbcfm.com/api/v1/image/107177181-1673449421857-gettyimages-1246152990-AFP_336V6W3.jpeg?v=1674179028&w=1920&h=1080",
          publishedAt: "2023-01-20T01:43:00Z",
          content: "The Federal Aviation Administration said Thursday that a contractor unintentionally deleted files before an outage of a pilot-alert system that delayed thousands of flights last week.\r\n\"A preliminary… [+1355 chars]"
      ),
      Articles(
          source: Source(id: "1", name: "CBC"),
          author: "Leslie Josephs",
          title: "FAA says contractor unintentionally deleted files before outage disrupted thousands of flights - CNBC",
          description: "Around 10,000 flights were delayed because of the outage of a pilot-alerting system.",
          url: "https://www.cnbc.com/2023/01/20/faa-outage-that-delayed-thousands-of-flights-caused-by-contractor-who-deleted-files.html",
          urlToImage: "https://image.cnbcfm.com/api/v1/image/107177181-1673449421857-gettyimages-1246152990-AFP_336V6W3.jpeg?v=1674179028&w=1920&h=1080",
          publishedAt: "2023-01-20T01:43:00Z",
          content: "The Federal Aviation Administration said Thursday that a contractor unintentionally deleted files before an outage of a pilot-alert system that delayed thousands of flights last week.\r\n\"A preliminary… [+1355 chars]"
      ),
      Articles(
          source: Source(id: "1", name: "CBC"),
          author: "Leslie Josephs",
          title: "FAA says contractor unintentionally deleted files before outage disrupted thousands of flights - CNBC",
          description: "Around 10,000 flights were delayed because of the outage of a pilot-alerting system.",
          url: "https://www.cnbc.com/2023/01/20/faa-outage-that-delayed-thousands-of-flights-caused-by-contractor-who-deleted-files.html",
          urlToImage: "https://image.cnbcfm.com/api/v1/image/107177181-1673449421857-gettyimages-1246152990-AFP_336V6W3.jpeg?v=1674179028&w=1920&h=1080",
          publishedAt: "2023-01-20T01:43:00Z",
          content: "The Federal Aviation Administration said Thursday that a contractor unintentionally deleted files before an outage of a pilot-alert system that delayed thousands of flights last week.\r\n\"A preliminary… [+1355 chars]"
      ),

    ];
    return Scaffold(
      body: Container(child: Stack(
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
            vertical: 24,
            horizontal: 48,
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                    ),
                  ),
                  SizedBox(width: 24),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(99.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 36),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: controllerKeyword,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Searching something?',
                                hintStyle: TextStyle(
                                  fontSize: 36,
                                  color: Colors.grey,
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontSize: 36,
                              ),
                            ),
                          ),
                          Hero(
                            tag: 'iconSearch',
                            child: Focus(
                              focusNode: focusNodeIconSearch,
                              child: Icon(
                                Icons.search,
                                size: 48,
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
                child:ListView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  var itemArticle = listArticles[index];
                  var dateTimePublishedAt =
                  DateFormat('yyy-MM-ddTHH:mm:ssZ').parse(itemArticle.publishedAt??"", true);
                  var strPublishedAt = DateFormat('MMM dd, yyyy HH:mm').format(dateTimePublishedAt);
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: WidgetItemNews(
                      itemArticle: itemArticle,
                      strPublishedAt: strPublishedAt,
                    ),
                  );
                },
                itemCount: listArticles.length,
                )
              ),
            ],
          ),
        ),
      ),
      ],
    ),)
    );
  }

  void _onSearching() {

  }
}
