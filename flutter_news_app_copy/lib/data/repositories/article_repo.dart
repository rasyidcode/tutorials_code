import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Response;

import 'package:flutter_news_app_copy/data/models/api_model.dart';
import 'package:flutter_news_app_copy/res/strings.dart';

abstract class ArticleRepository {
  Future<List<Articles>> getArticles();
}

class ArticleRepositoryImpl implements ArticleRepository {
  @override
  Future<List<Articles>> getArticles() async {
    print('getting article from internet...');
    Response response = await http.get(Uri.parse(AppStrings.url));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      List<Articles>? articles = ApiResultModel.fromJson(data).articles;
      if (articles != null) {
        return articles;
      } else {
        return [];
      }
    } else {
      throw Exception();
    }
  }
}
