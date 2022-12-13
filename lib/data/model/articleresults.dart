// To parse this JSON data, do
//
//     final articleResult = articleResultFromJson(jsonString);

import 'dart:convert';

import 'article.dart';

ArticleResults articleResultsFromJson(String str) => ArticleResults.fromJson(json.decode(str));

String articleResultsToJson(ArticleResults data) => json.encode(data.toJson());

class ArticleResults {
  ArticleResults({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  String status;
  int totalResults;
  List<Article> articles;

  factory ArticleResults.fromJson(Map<String, dynamic> json) => ArticleResults(
    status: json["status"],
    totalResults: json["totalResults"],
    articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x)).where(
        (article)=>
          article.author!=null
              &&article.urlToImage!=null
              &&article.publishedAt!=null
              &&article.content!=null

    )),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "totalResults": totalResults,
    "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
  };
}
//
// class Article {
//   Article({
//     this.source,
//     this.author,
//     this.title,
//     this.description,
//     this.url,
//     this.urlToImage,
//     this.publishedAt,
//     this.content,
//   });
//
//   Source source;
//   String author;
//   String title;
//   String description;
//   String url;
//   String urlToImage;
//   DateTime publishedAt;
//   String content;
//
//   factory Article.fromJson(Map<String, dynamic> json) => Article(
//     source: Source.fromJson(json["source"]),
//     author: json["author"],
//     title: json["title"],
//     description: json["description"],
//     url: json["url"],
//     urlToImage: json["urlToImage"],
//     publishedAt: DateTime.parse(json["publishedAt"]),
//     content: json["content"] == null ? null : json["content"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "source": source.toJson(),
//     "author": author,
//     "title": title,
//     "description": description,
//     "url": url,
//     "urlToImage": urlToImage,
//     "publishedAt": publishedAt.toIso8601String(),
//     "content": content == null ? null : content,
//   };
// }
//
