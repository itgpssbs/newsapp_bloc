import 'dart:convert';

import '../model/articleresults.dart';
import 'package:http/http.dart' as http;

class ApiService{
  static const String url="https://newsapi.org/v2/";
  static const String apiKey="080ce0d7efbd4596919fd25e594fba8d";

  Future<ArticleResults> topHeadLines(String country, String category) async{
    // https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=080ce0d7efbd4596919fd25e594fba8d
    final response = await http.get(Uri.parse("${url}top-headlines?country=${country}&category=${category}&apiKey=${apiKey}"));
    if (response.statusCode==200)
    {
      return ArticleResults.fromJson(json.decode(response.body));
    }
    else{
      throw Exception("Failed to Load data from Newsapi");
    }
  }

  Future<ArticleResults> searchHeadLines(String date, String query) async{
    //https://newsapi.org/v2/everything?q=tesla&from=2022-09-19&sortBy=publishedAt&apiKey=080ce0d7efbd4596919fd25e594fba8d
    final response = await http.get(Uri.parse("${url}everything?q=${query}&from=${date}&sortBy=publishedAt&apiKey=${apiKey}"));
    if (response.statusCode==200)
    {
      return ArticleResults.fromJson(json.decode(response.body));
    }
    else{
      throw Exception("Failed to Load data from Newsapi");
    }
  }
}