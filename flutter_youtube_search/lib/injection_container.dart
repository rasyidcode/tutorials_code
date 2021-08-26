import 'package:github_user_searcch/data/network/youtube_data_source.dart';
import 'package:github_user_searcch/data/repository/youtube_search_repository.dart';
import 'package:github_user_searcch/ui/search/search.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:http/http.dart' as http;

void initKiwi() {
  kiwi.KiwiContainer()
    ..registerInstance(http.Client())
    ..registerFactory(
      (c) => YoutubeDataSource(c.resolve()),
    )
    ..registerFactory(
      (c) => YoutubeSearchRepository(c.resolve()),
    )
    ..registerFactory(
      (c) => SearchBloc(c.resolve()),
    );
}
