import 'package:movie_search/features/movie_search/domain/entities/movie_search.dart';
import 'package:movie_search/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_search/features/movie_search/domain/repositories/movie_search_repository.dart';

class MovieSearchRepoImpl implements MovieSearchRepository {
  @override
  Future<Either<Failure, MovieSearch>> getMovieSearch(String query) {
    // TODO: implement getMovieSearch
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, MovieSearch>> getTrendingMovies() {
    // TODO: implement getTrendingMovies
    throw UnimplementedError();
  }
}
