import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/top_head_line.dart';

class NewsService{
  Future<TopHeadlineNews?> getData({required void Function(String) onError}) async {
    const String url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=e5eeb5ab26c44f85865f0bcf84cb374e";
    try{
      http.Response response = await http.get(Uri.parse(url));
      print(response);
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