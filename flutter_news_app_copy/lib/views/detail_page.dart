import 'package:flutter/material.dart';
import 'package:flutter_news_app_copy/data/models/api_model.dart';

class DetailPage extends StatelessWidget {
  final Articles article;
  final int index;

  DetailPage({required this.article, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Detail Page'),
      ),
      body: Column(
        children: [
          Container(
              child: Hero(
                  tag: article.urlToImage ??
                      'https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg$index',
                  child: Image.network(article.urlToImage ??
                      'https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg'))),
          Expanded(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    article.title ?? 'Undefined',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    article.publishedAt ?? 'Undefined',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    article.content ?? 'Undefined',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 17.0,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
