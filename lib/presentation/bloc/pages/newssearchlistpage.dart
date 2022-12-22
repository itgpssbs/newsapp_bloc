import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/article.dart';

import '../news_search/news_search_bloc.dart';
import 'detail_news.dart';

class NewsSearchListPage extends StatelessWidget{
  static const routeName='news_list';
  const NewsSearchListPage({Key? key}): super(key:key);

  // @override
  Widget _buildList(){
    return BlocBuilder<NewsSearchBloc,NewsSearchState>(
        builder: (context, state) {
          if (state is NewsSearchLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (state is NewsSearchHasData) {
            final result = state.data;
            return ListView.builder(
                shrinkWrap: true,
                itemCount: result.articles.length,
                itemBuilder: (context,index){
                  return _buildArticleItem(context, result.articles[index]);
                }
            );
          }
          else if (state is NewsSearchError) {
            return Center(
                child: state.retry==null?Material(
                  child: Text(state.message),
                )
                :Material(
                    child: Text(state.message+",retry:"+state.retry.toString()),
                ),
            );
          }
          else if (state is NewsSearchEmpty) {
            return Center(
              child: Text(state.message),
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
  Widget build(BuildContext context) {
    return _buildList();
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