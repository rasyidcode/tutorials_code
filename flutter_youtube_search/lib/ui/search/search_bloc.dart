import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_searcch/data/models/search/youtube_search_error.dart';
import 'package:github_user_searcch/data/repository/youtube_search_repository.dart';
import 'package:github_user_searcch/ui/search/search.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final YoutubeSearchRepository _youtubeSearchRepository;
  SearchBloc(this._youtubeSearchRepository) : super(SearchState.initial());

  void onSearchInitiated(String query) {
    add(SearchInitiated((b) => b..query = query));
  }

  void fetchNextResultPage() {
    add(FetchNextResultPage());
  }

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchInitiated) {
      yield* mapSearchInitiatedState(event);
    } else if (event is FetchNextResultPage) {
      yield* mapNextPageState(event);
    }
  }

  Stream<SearchState> mapSearchInitiatedState(SearchInitiated event) async* {
    if (event.query.isEmpty) {
      yield SearchState.initial();
    } else {
      yield SearchState.loading();

      try {
        final searchResult =
            await _youtubeSearchRepository.searchVideos(event.query);
        yield SearchState.success(searchResult);
      } on YoutubeSearchError catch (e) {
        yield SearchState.failure(e.message);
      } on NoSearchResultsException catch (e) {
        yield SearchState.failure(e.message);
      }
    }
  }

  Stream<SearchState> mapNextPageState(FetchNextResultPage event) async* {
    try {
      final nextPageResult = await _youtubeSearchRepository.fetchNextVideos();
      yield SearchState.success(state.searchResults! + nextPageResult);
    } on NoNextPageTokenException catch (_) {
      yield state.rebuild((b) => b.hasReachedEndOfResults = true);
    } on SearchNotInitException catch (e) {
      yield SearchState.failure(e.message);
    } on YoutubeSearchError catch (e) {
      yield SearchState.failure(e.message);
    }
  }
}
