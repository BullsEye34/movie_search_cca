import 'dart:convert';

import 'package:movie_search/core/error/exceptions.dart';
import 'package:movie_search/features/movie_search/data/models/movie_search_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MovieSearchLocalDataSource {
  Future<MovieSearchModel> getLastMovieSearch();

  Future<void>? cacheMovieSearch(MovieSearchModel triviaToCache);
}

const CACHED_MOVIE_SEARCH = "CACHED_MOVIE_SEARCH";

class MovieSearchLocalDataSourceImpl implements MovieSearchLocalDataSource {
  final SharedPreferences sharedPreferences;
  MovieSearchLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void>? cacheMovieSearch(MovieSearchModel triviaToCache) {
    sharedPreferences.setString(
        CACHED_MOVIE_SEARCH, json.encode(triviaToCache.toJson()));
  }

  @override
  Future<MovieSearchModel> getLastMovieSearch() {
    final String? jsonString = sharedPreferences.getString(CACHED_MOVIE_SEARCH);
    if (jsonString != null) {
      return Future.value(MovieSearchModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
