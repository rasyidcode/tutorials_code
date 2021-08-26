import 'package:flutter/material.dart';
import 'package:github_user_searcch/injection_container.dart';
import 'package:github_user_searcch/ui/search/search_page.dart';

void main() {
  initKiwi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.green.shade600,
          accentColor: Colors.greenAccent.shade400),
      home: SearchPage(),
    );
  }
}
