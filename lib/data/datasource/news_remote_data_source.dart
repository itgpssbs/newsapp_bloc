
import 'dart:convert';

import 'package:thirdproject/data/model/articleresults.dart';
import 'package:http/http.dart' as http;

import '../../common/constants.dart';

abstract class NewsRemoteDatasource{
  Future<ArticleResults> searchNews(String date, String query);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDatasource{
  final http.Client client = http.Client();

  // NewsRemoteDataSourceImpl({required this.client});
  NewsRemoteDataSourceImpl();

  @override
  Future<ArticleResults> searchNews(String date, String query) async{
    final response = await http.get(Uri.parse("${BASE_URL}everything?q=${query}&from=${date}&sortBy=publishedAt&apiKey=${API_KEY}"));
    if (response.statusCode==200)
    {
      return ArticleResults.fromJson(json.decode(response.body));
    }
    else{
      throw Exception("Failed to Load data from Newsapi");
    }
  }
}
