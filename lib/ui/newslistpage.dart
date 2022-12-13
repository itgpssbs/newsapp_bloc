import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../data/model/articleresults.dart';
import '../provider/newsprovider.dart';
import '../ui/detail_news.dart';

import '../data/model/article.dart';

class NewsListPage extends StatelessWidget{
  static const routeName='news_list';
  const NewsListPage({Key? key}): super(key:key);

  // @override
  Widget _buildList(){
    return Consumer<NewsProvider>(
      builder: (context, state,_) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        else if (state.state == ResultState.hasData) {
          return ListView.builder(
              itemCount: state.result.articles.length,
              itemBuilder: (context,index){
                return _buildArticleItem(context, state.result.articles[index]);
              }
          );
        }
        else if (state.state == ResultState.noData) {
          return Center(
              child: Material(
                child: Text(state.message),
              )
          );
        }
        else {
          return const Center(
              child: Material(
                child: Text(''),
              )
          );
        }
      }
  );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:_buildList(),
    );
  }
}

Widget _buildArticleItem(BuildContext context, Article article){
  return Material(
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Image.network(
        article.urlToImage,
        width: 100,
      ),
      title: Text(article.title),
      subtitle: Text(article.author),
      onTap: (){
        Navigator.pushNamed(context, DetailNewsScreen.routeName,arguments: article);
      },
    )
  );
}