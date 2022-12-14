
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:thirdproject/data/model/articleresults.dart';
import 'package:thirdproject/domain/repositories/NewsRepository.dart';

import '../../common/failure.dart';

class SearchNews{
  final NewsRepository repository;
  SearchNews(this.repository);
  Future<Either<Failure, ArticleResults>> execute(String query){
    DateTime now = DateTime.now();
    // DateTime date = new DateTime(now.day, now.month,now.year);
    return repository.searchNews(DateFormat('yyyy-MM-dd').format(now),query);
  }
}

