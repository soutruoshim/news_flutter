import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:news_flutter/models/top_head_line.dart';
import 'package:news_flutter/services/NewsService.dart';

class NewsLogic extends ChangeNotifier{
  TopHeadlineNews? _topHeadlineNews;
  TopHeadlineNews? get topHeadlineNews => _topHeadlineNews;
  bool _isLoading = true;

  String? _error;
  String? get error => _error;

  bool get isLoading => _isLoading;
  void setLoading(bool isLoading){
    _isLoading = isLoading;
    notifyListeners();
  }

  Future read({String category="", String query=""}) async{
    NewsService newsService = NewsService();
    _topHeadlineNews  = await newsService.getData(onError: (value){
      _error = value;
    }, category: category, query: query);
    print("Ready");
    print( _topHeadlineNews);
    _isLoading = false;
    notifyListeners();
  }
}
