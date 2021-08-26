import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app_copy/bloc/article_bloc/article_bloc.dart';
import 'package:flutter_news_app_copy/bloc/article_bloc/article_event.dart';
import 'package:flutter_news_app_copy/bloc/article_bloc/article_state.dart';
import 'package:flutter_news_app_copy/data/models/api_model.dart';
import 'package:flutter_news_app_copy/views/detail_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ArticleBloc articleBloc;

  @override
  void initState() {
    super.initState();
    articleBloc = BlocProvider.of<ArticleBloc>(context);
    articleBloc.add(FetchArticleEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) => Material(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.pink,
            title: Text('Flutter News App'),
            actions: [
              IconButton(
                  onPressed: () {
                    articleBloc.add(
                      FetchArticleEvent(),
                    );
                  },
                  icon: Icon(Icons.refresh))
            ],
          ),
          body: Container(
            child: BlocListener<ArticleBloc, ArticleState>(
              listener: (BuildContext context, ArticleState state) {
                if (state is ArticleErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              child: BlocBuilder<ArticleBloc, ArticleState>(
                builder: (BuildContext context, ArticleState state) {
                  if (state is ArticleInitialState) {
                    return buildLoadingWidget();
                  } else if (state is ArticleLoadingState) {
                    return buildLoadingWidget();
                  } else if (state is ArticleLoadedState) {
                    return buildArticleList(state.articles);
                  } else if (state is ArticleErrorState) {
                    return buildErrorWidget(state.message);
                  } else {
                    return buildErrorWidget('Something went wrong');
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoadingWidget() {
    return Center(
      child: SpinKitDoubleBounce(
        color: Colors.redAccent,
        size: 100.0,
      ),
    );
  }

  Widget buildArticleList(List<Articles> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (BuildContext context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Hero(
                  tag: articles[index].urlToImage ??
                      'https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg$index',
                  child: Image.network(
                    articles[index].urlToImage ??
                        'https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg',
                    fit: BoxFit.cover,
                    height: 70.0,
                    width: 70.0,
                  ),
                ),
              ),
              title: Text(
                articles[index].title ?? 'Default',
                style: TextStyle(color: Colors.black),
              ),
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5.0,
                    blurRadius: 7.0,
                    offset: Offset(0.0, 3.0))
              ],
              color: Colors.pink,
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [Color(0xffEE9CA7), Color(0xffFFDDE1)],
                begin: Alignment.centerRight,
                end: Alignment(-1.0, -1.0),
              ),
            ),
          ),
          onTap: () {
            navigateToArticleDetailPage(context, articles[index], index);
          },
        ),
      ),
    );
  }

  Widget buildErrorWidget(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  void navigateToArticleDetailPage(
      BuildContext context, Articles article, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DetailPage(
          article: article,
          index: index,
        ),
      ),
    );
  }
}
