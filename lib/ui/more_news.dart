import 'package:flutter/material.dart';
import '../widgets/custom_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MoreNewsScreen extends StatelessWidget{
  static const routeName = '/more_detail';
  final String url;
  const MoreNewsScreen({Key ? key, required this.url}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO : implemend build
    return CustomScaffold(
      body: WebView(
        initialUrl:url,
      )
    );
  }
}
