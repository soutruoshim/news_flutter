import 'package:flutter/cupertino.dart';
import 'package:news_flutter/models/top_head_line.dart';
import 'package:news_flutter/services/NewsService.dart';

class NewsLogic extends ChangeNotifier{
  TopHeadlineNews? _topHeadlineNews;
  TopHeadlineNews? get topHeadlineNews => _topHeadlineNews;

  String? _error;
  String? get error => _error;

  Future read() async{
    NewsService newsService = NewsService();
    _topHeadlineNews  = await newsService.getData(onError: (value){
      _error = value;
    });
    print("Ready");
    notifyListeners();
  }
}
