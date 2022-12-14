
import 'package:dartz/dartz.dart';
import 'package:thirdproject/data/model/articleresults.dart';
import '../../common/failure.dart';

abstract class NewsRepository{
  Future<Either<Failure, ArticleResults>> searchNews(String date, String query);
}
