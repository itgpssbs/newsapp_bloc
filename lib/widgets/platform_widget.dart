import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

//biar poni tidak tertutup component kita
class PlatformWidget extends StatelessWidget{
  final WidgetBuilder androidBuilder;
  final WidgetBuilder iosBuilder;
  const PlatformWidget({Key ? key, required this.androidBuilder, required this.iosBuilder}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO : implemend build
    switch (defaultTargetPlatform){
      case TargetPlatform.android:
        return androidBuilder(context);
      case TargetPlatform.iOS:
        return iosBuilder(context);
      default:
        return androidBuilder(context);
    }
  }
}

