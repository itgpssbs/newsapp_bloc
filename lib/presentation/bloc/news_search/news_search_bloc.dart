import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:../data/model/articleresults.dart';
// import '../../../data/model/articleresults.dart';
import 'package:thirdproject/data/model/articleresults.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/usecases/search_news.dart';
part 'news_search_event.dart';
part 'news_search_state.dart';

class NewsSearchBloc extends Bloc<NewsSearchEvent, NewsSearchState>{
  NewsSearchBloc(SearchNews searchNews):super(NewsSearchInitial()){
    on<NewsSearchEvent>((event,emit) async {
      if (event is OnQueryNewsChanged){
        final query = event.query;
        if (query.isEmpty){
          emit(NewsSearchInitial());
          return;
        }
        emit(NewsSearchLoading());
        final result = await searchNews.execute(query);
        result.fold((failure){
          final resultState = NewsSearchError('Server failure',retry:(){
            add(OnQueryNewsChanged(query));
          });
          emit(resultState);
        },(data) async {
          if (data.articles.isNotEmpty){
            final resultState = NewsSearchHasData(data);
            emit(resultState);
          }
          else{
            emit(NewsSearchEmpty('No news found $query'));
          }
        });
      }
    },transformer: debounce(const Duration(milliseconds : 500)));
  }
  EventTransformer<NewsSearchEvent> debounce<NewsSearchEvent> (Duration duration){
    return (events,mapper)=>events.debounceTime(duration).flatMap(mapper);
  }
}
