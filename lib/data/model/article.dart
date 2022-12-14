
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'source.dart';

List<Article> parseArticles(String? json){
  if (json==null){
    return [];
  }
  final List parsed=jsonDecode(json);
  return parsed.map((json)=>Article.fromJson(json)).toList();
}

class Article extends Equatable{
  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String content;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    source: json["source"] != null ? Source.fromJson(json["source"]) : Source(id: "", name: ""),
    author: json["author"] ?? "null",
    title: json["title"] ?? "null",
    description: json["description"] ?? "null",
    url: json["url"] ?? "null",
    urlToImage: json["urlToImage"] ?? "null",
    publishedAt: json["publishedAt"] != null ? DateTime.parse(json["publishedAt"])  : DateTime.parse('1900-01-01'),
    content: json["content"] ?? "null",
  );

  Map<String, dynamic> toJson() => {
    "source": source.toJson(),
    "author": author,
    "title": title,
    "description": description,
    "url": url,
    "urlToImage": urlToImage,
    "publishedAt": publishedAt.toIso8601String(),
    "content": content,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [source, author, title, description, url, urlToImage,publishedAt, content];
}
