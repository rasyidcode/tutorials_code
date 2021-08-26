import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app_copy/bloc/article_bloc/article_event.dart';
import 'package:flutter_news_app_copy/bloc/article_bloc/article_state.dart';
import 'package:flutter_news_app_copy/data/models/api_model.dart';
import 'package:flutter_news_app_copy/data/repositories/article_repo.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleRepository repository;

  ArticleBloc({required this.repository}) : super(ArticleInitialState());

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    if (event is FetchArticleEvent) {
      yield ArticleLoadingState();

      try {
        List<Articles> articles = await repository.getArticles();
        yield ArticleLoadedState(articles: articles);
      } catch (e) {
        yield ArticleErrorState(message: e.toString());
      }
    }
  }
}
