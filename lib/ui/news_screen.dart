// platforms IOS
// import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/newsprovider.dart';
import '../data/api/apiservice.dart';
import 'newslistpage.dart';

class NewsScreen extends StatefulWidget {
  static const routeName = '/articles_list';
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:
        ChangeNotifierProvider<NewsProvider>(
          // parameter _  adalah parameter yang gak akan dipakai
          create: (_)=> NewsProvider(apiService: ApiService(),country:'id', category: 'sport'),
          child: const NewsListPage(),
        )
    );
  }
}