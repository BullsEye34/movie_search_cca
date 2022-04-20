import 'package:dartz/dartz.dart';
import 'package:movie_search/core/error/failures.dart';
import 'package:movie_search/core/usecases/usecase.dart';
import 'package:movie_search/features/movie_search/domain/entities/movie_search.dart';
import 'package:movie_search/features/movie_search/domain/repositories/movie_search_repository.dart';

class GetTrendingMovies extends UseCase<MovieSearch, NoParams> {
  MovieSearchRepository repository;
  GetTrendingMovies({required this.repository});
  @override
  Future<Either<Failure, MovieSearch>?>? call(params) async {
    // TODO: implement call
    return await repository.getTrendingMovies();
  }
}
