import 'package:get_it/get_it.dart';
import 'data/datasource/news_remote_data_source.dart';
import 'domain/repositories/NewsRepository.dart';

import 'data/repositories/NewsRepositoryImpl.dart';
import 'domain/usecases/search_news.dart';
import 'presentation/bloc/news_search/news_search_bloc.dart';

final locator = GetIt.instance;
void init(){
  locator.registerFactory(() => NewsSearchBloc(locator()));
  //Lazy = aplikasi sudah jalan
  locator.registerLazySingleton(() => SearchNews(locator()));
  locator.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(remoteDataSource:locator()));
  locator.registerLazySingleton<NewsRemoteDatasource>(() => NewsRemoteDataSourceImpl(client:locator()));
}