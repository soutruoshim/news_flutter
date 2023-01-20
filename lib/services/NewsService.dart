import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/top_head_line.dart';

class NewsService{
  Future<TopHeadlineNews?> getData({required void Function(String) onError, String category="", String query=""}) async {
    String url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=d65daf66354a482688780bf36d80d419";
    if(category!=""){
      url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=d65daf66354a482688780bf36d80d419&category=$category";
    }
    if(query!=""){
      url = "https://newsapi.org/v2/everything?apiKey=d65daf66354a482688780bf36d80d419&q=$query";
    }
    try{
      http.Response response = await http.get(Uri.parse(url));
      print(url);
      return compute(_getData, response.body);
    }catch(e){
      onError(e.toString());
    }
    return null;
  }

  TopHeadlineNews _getData(String data){
    Map<String, dynamic> map = json.decode(data);
    return TopHeadlineNews.fromJson(map);
  }
}