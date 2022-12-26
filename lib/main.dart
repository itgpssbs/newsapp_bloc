import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:thirdproject/presentation/bloc/pages/load_image.dart';
import 'presentation/bloc/news_search/news_search_bloc.dart';
import 'presentation/bloc/pages/news_screen.dart';
import 'presentation/bloc/pages/detail_news.dart';
import '../common/styles.dart';
import '../data/model/article.dart';
import 'presentation/bloc/pages/more_news.dart';
import 'injection.dart' as di;
import 'presentation/bloc/pages/news_search_screen.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_)=>di.locator<NewsSearchBloc>())
      ],
      child: MaterialApp(
        title: 'News App',
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: primaryColor,
            onPrimary: Colors.black,
            secondary:secondaryColor,
          ),
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          // primarySwatch: Colors.purple,
          // dp : density pixel menyesuaikan
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: myTextTheme,
          appBarTheme: const AppBarTheme(elevation: 8),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: secondaryColor,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0))
              )
            )
          )
        ),
        // initialRoute: NewsScreen.routeName,
          // initialRoute: NewsScreenSearch.routeName,
          initialRoute: LoadImageScreen.routeName,
        routes: {
          LoadImageScreen.routeName: (context)=>const LoadImageScreen(),
          NewsScreen.routeName: (context)=>const NewsScreen(),
          NewsScreenSearch.routeName: (context)=>const NewsScreenSearch(),
          DetailNewsScreen.routeName : (context) => DetailNewsScreen(
            article: ModalRoute.of(context)?.settings.arguments as Article,
          ),
          MoreNewsScreen.routeName : (context) => MoreNewsScreen(
            url : ModalRoute.of(context)?.settings.arguments as String
          ),
        }
      ),
    );
  }
}
