import 'package:bloc_test/bloc_test.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:thirdproject/common/failure.dart';
import 'package:thirdproject/data/model/article.dart';
import 'package:thirdproject/data/model/articleresults.dart';
import 'package:thirdproject/data/model/source.dart';
import 'package:thirdproject/domain/usecases/search_news.dart';
import 'package:thirdproject/presentation/bloc/news_search/news_search_bloc.dart';

import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchNews])
void main() {
  // tambahan Mock - gak benar2 panggil ke API
  // cuma struktur data aja
  late MockSearchNews mockSearchNews;
  late NewsSearchBloc newsSearchBloc;
  setUp((){
    mockSearchNews = MockSearchNews();
    newsSearchBloc = NewsSearchBloc(mockSearchNews);
  });


  // baca json
  // https://jsoneditoronline.org/#left=local.xubove&right=local.wixefi
  // https://newsapi.org/v2/everything?q=tesla&from=2022-12-22&sortBy=publishedAt&apiKey=080ce0d7efbd4596919fd25e594fba8d
  // hasil : {"source":{"id":null,"name":"Vnexpress.net"},"author":"Reuters","title":"Tesla to freeze hiring, lay off employees next quarter: Electrek - VnExpress International","description":"Another wave of layoffs are coming at electric-car maker Tesla Inc in the next quarter, news website Electrek reported on Wednesday, citing a source familiar with the matter.","url":"https://e.vnexpress.net/news/world/tesla-to-freeze-hiring-lay-off-employees-next-quarter-electrek-4551257.html","urlToImage":"https://vcdn-english.vnecdn.net/2022/12/22/teslr-1671674687-5178-1671674692_1200x0.jpg","publishedAt":"2022-12-22T02:53:11Z","content":"Tesla is also going to freeze hiring, according to the report. The company did not immediately respond to a Reuters request for comment.\r\nShares of Tesla rose 1% to $139.25 in trading before the bell… [+480 chars]"}
  final tArticle = <Article>[Article(
      source: Source(id: null, name:"Vnexpress.net"),
      author:"Reuters",
      title:"Tesla to freeze hiring, lay off employees next quarter: Electrek - VnExpress International",
      description:"Another wave of layoffs are coming at electric-car maker Tesla Inc in the next quarter, news website Electrek reported on Wednesday, citing a source familiar with the matter.",
      url:"https://e.vnexpress.net/news/world/tesla-to-freeze-hiring-lay-off-employees-next-quarter-electrek-4551257.html",
      urlToImage:"https://vcdn-english.vnecdn.net/2022/12/22/teslr-1671674687-5178-1671674692_1200x0.jpg",
      publishedAt:DateTime.parse("2022-12-22T02:53:11Z"),
      content:"Tesla is also going to freeze hiring, according to the report. The company did not immediately respond to a Reuters request for comment. Shares of Tesla rose 1% to \$139.25 in trading before the bell… [+480 chars]"
  )];

  // {"status":"ok", "total": }
  final tArticleResults = ArticleResults(
    status: "ok", totalResults : 30, articles:tArticle);
  test('Should be a subclass of ArticleResults entity',(){
    final result = tArticleResults.toEntity();
    // final result = tArticle;
    expect(result, tArticleResults);
  });

  test('Should be initial',(){
    expect(newsSearchBloc.state, NewsSearchInitial());
  });
  final tNewsModel = tArticleResults;
  final tQuery = "tesla";
  blocTest('Should emit [Loading , Has Data] if successful', build: (){
      when(mockSearchNews.execute(tQuery)).thenAnswer((realInvocation)async=>Right(tNewsModel));
      return newsSearchBloc;
  },
    act: (NewsSearchBloc bloc)=> bloc.add(OnQueryNewsChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
    expect: ()=> [NewsSearchLoading(), NewsSearchHasData(tNewsModel)],
    verify: (NewsSearchBloc bloc ){
      verify(mockSearchNews.execute(tQuery));
    }
  );

  blocTest('Should emit [Initial] when query is empty',
    build:()=>newsSearchBloc,
    act: (NewsSearchBloc bloc)=>bloc.add(OnQueryNewsChanged('')),
    wait:const Duration(milliseconds: 500),
    expect:()=>[NewsSearchInitial()]
  );

  blocTest('Should emit [Loading , Empty] if data unavailable', build: (){
    when(mockSearchNews.execute(tQuery)).thenAnswer((realInvocation)async=>
        Right(ArticleResults(status: "", totalResults: 0, articles: [])));
    return newsSearchBloc;
  },
      act: (NewsSearchBloc bloc)=> bloc.add(OnQueryNewsChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: ()=> [NewsSearchLoading(), NewsSearchEmpty('No news found $tQuery')],
      verify: (NewsSearchBloc bloc ){
        verify(mockSearchNews.execute(tQuery));
      }
  );
  blocTest('Should emit [Loading , Error] when error', build: (){
    when(mockSearchNews.execute(tQuery)).thenAnswer((realInvocation)async=>
        Left(ServerFailure()));
    return newsSearchBloc;
  },
      act: (NewsSearchBloc bloc)=> bloc.add(OnQueryNewsChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: ()=> [NewsSearchLoading(), NewsSearchError('Server failure', retry:(){})],
      verify: (NewsSearchBloc bloc ){
        verify(mockSearchNews.execute(tQuery));
      }
  );
}