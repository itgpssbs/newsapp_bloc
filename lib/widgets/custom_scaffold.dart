import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

//biar poni tidak tertutup component kita
class CustomScaffold extends StatelessWidget{
  final Widget body;
  const CustomScaffold({Key ? key, required this.body}):super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO : implemend build
    return Scaffold(
        appBar: AppBar(
          title: const Text("More News Detail"),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              body,
              _buildShortAppBar(context) ,

            ],
          ),
        )
    );
  }
}

Widget _buildShortAppBar(BuildContext context){
  return Card(
    margin :const EdgeInsets.all(0),
    shape: const BeveledRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(16.0),
      )
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        Padding(
            padding: const EdgeInsets.only(right:16.0),
            child : Text(
              'N',
              style: Theme.of(context).textTheme.headline6,
            )
        )
      ],
    ),
  );
}