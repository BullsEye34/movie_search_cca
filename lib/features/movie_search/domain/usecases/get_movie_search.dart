import 'package:equatable/equatable.dart';
import 'package:movie_search/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_search/core/usecases/usecase.dart';
import 'package:movie_search/features/movie_search/domain/entities/movie_search.dart';
import 'package:movie_search/features/movie_search/domain/repositories/movie_search_repository.dart';

class GetMovieSearch extends UseCase<MovieSearch, Params> {
  MovieSearchRepository repository;
  GetMovieSearch({required this.repository});
  @override
  Future<Either<Failure, MovieSearch>?>? call(params) async {
    // TODO: implement call
    return await repository.getMovieSearch(params.title);
  }
}

class Params extends Equatable {
  String title;
  Params({required this.title}) : super();

  @override
  // TODO: implement props
  List<Object?> get props => [title];
}
