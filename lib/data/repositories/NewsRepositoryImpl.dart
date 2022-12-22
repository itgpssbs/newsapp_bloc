import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../common/failure.dart';
import '../../data/model/articleresults.dart';
import '../../domain/repositories/NewsRepository.dart';
import '../datasource/news_remote_data_source.dart';

// remote datasource
class NewsRepositoryImpl implements NewsRepository{
  final NewsRemoteDatasource remoteDataSource;
  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ArticleResults>> searchNews(String date, String query) async {
    try{
      final result = await remoteDataSource.searchNews(date, query);
      return Right(result);
    }on ServerException{
      return Left(ServerFailure());
    }on SocketException{
      return Left(ConnectionFailure());
    }
  }
}
