import 'package:flutter/material.dart';
import '../ui/more_news.dart';

import '../data/model/article.dart';

class DetailNewsScreen extends StatelessWidget{
  static const routeName = '/articles_detail';
  final Article article;
  const DetailNewsScreen({Key ? key, required this.article}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO : implemend build
    return Scaffold(
        appBar: AppBar(
          title: const Text('News'),
        ),
        body: SingleChildScrollView(
            child: Column(
              children: [
                Image.network(article.urlToImage),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(article.description),
                      const Divider(color: Colors.grey,),
                      Text(
                        article.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w100,
                          fontSize: 24
                        ),
                      ),
                      const Divider(color: Colors.grey,),
                      Text(article.content),
                      Text('Date: ${article.publishedAt}', ),
                      const SizedBox(height: 10),
                      ElevatedButton(onPressed: (){
                        Navigator.pushNamed(context, MoreNewsScreen.routeName, arguments: article.url);
                      }, child: const Text('More ...')),
                    ],
                  )
                )
              ],
            ),
          )
    );
  }
}

Widget _buildArticleItem(BuildContext context, Article article){
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    leading: Image.network(article.urlToImage, width: 100,),
    title: Text(article.title),
    subtitle: Text(article.author),
  );
}