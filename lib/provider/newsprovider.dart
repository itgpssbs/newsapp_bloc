import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import '../data/api/apiservice.dart';
import '../data/model/articleresults.dart';

enum ResultState{loading,noData,hasData,error}
class NewsProvider extends ChangeNotifier{
  final ApiService apiService;
  final String country;
  final String category;

  NewsProvider({required this.apiService, required this.country, required this.category}){
    // _ / underscore == nama method private ==> yang digunakan hanya dalam class itu
    _fetchTopHeadLines(country,category);
  }
  late ArticleResults _articleResult;
  // variable enum yang memberikan nilai default
  late ResultState _state;
  String _message="";
  String get message => _message;
  ArticleResults get result=>_articleResult;
  ResultState get state=>_state;

  Future<dynamic> _fetchTopHeadLines(String country, String category) async{
    try {
      _state = ResultState.loading;
      notifyListeners();
      final article = await apiService.topHeadLines(country, category);
      if (article.articles.isEmpty){
        _state = ResultState.noData;
        notifyListeners();
        return _message='Empty Data';
      }
      else{
        _state = ResultState.hasData;
        notifyListeners();
        return _articleResult=article;
      }
    }catch(e){
     _state = ResultState.error;
     notifyListeners();
     return _message = 'Error --> $e';
    }
  }
}