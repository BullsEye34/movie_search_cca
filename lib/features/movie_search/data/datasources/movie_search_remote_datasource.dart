import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_search/core/error/exceptions.dart';
import 'package:movie_search/features/movie_search/data/models/movie_search_model.dart';

abstract class MovieSearchRemoteDataSource {
  Future<MovieSearchModel> getMovies(String query);
  Future<MovieSearchModel> getTrendingMovies();
}

class MovieSearchRemoteDataSourceImpl implements MovieSearchRemoteDataSource {
  http.Client client = http.Client();
  @override
  Future<MovieSearchModel> getMovies(String query) => _getMovieFromURL(
      "https://api.themoviedb.org/3/search/movie?api_key=43236c9b4ffaa78012ee092b4e4f74d8&language=en-US&page=1&include_adult=false&query=${query}");

  @override
  Future<MovieSearchModel> getTrendingMovies() => _getMovieFromURL(
      "https://api.themoviedb.org/3/trending/movies/week?api_key=43236c9b4ffaa78012ee092b4e4f74d8&language=en-US&page=1&include_adult=false");

  Future<MovieSearchModel> _getMovieFromURL(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return MovieSearchModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
