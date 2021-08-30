import 'package:flutter/material.dart';
import 'package:flutter_painting_app_4/home_page.dart';

class DrawApp extends StatelessWidget {
  const DrawApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('DrawApp'),
        ),
        body: HomePage(),
      ),
    );
  }
}
