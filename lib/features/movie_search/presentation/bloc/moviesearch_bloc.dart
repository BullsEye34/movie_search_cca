import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_search/core/error/failures.dart';
import 'package:movie_search/core/usecases/usecase.dart';
import 'package:movie_search/features/movie_search/domain/entities/movie_search.dart';
import 'package:movie_search/features/movie_search/domain/usecases/get_movie_search.dart';

import 'package:movie_search/features/movie_search/domain/usecases/get_trending_movies.dart';

part 'moviesearch_event.dart';
part 'moviesearch_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class MoviesearchBloc extends Bloc<MoviesearchEvent, MoviesearchState> {
  final GetMovieSearch getMovieSearch;
  final GetTrendingMovies getTrendingMovies;

  MoviesearchBloc({
    required this.getMovieSearch,
    required this.getTrendingMovies,
  }) : super(Empty()) {
    on<GetMovieForSearchEvent>((event, emit) async {
      emit(Loading());
      Either<Failure, MovieSearch>? failureOrMovieSearch =
          await getMovieSearch(Params(title: event.title));
      print("MovieSearch: " + failureOrMovieSearch.toString());

      failureOrMovieSearch!.fold((failure) {
        emit(Error(message: _mapFailureToMessage(failure)));
      }, (movieSearch) {
        emit(Loaded(movieSearch: movieSearch));
      });
    });
    on<GetTrendingMoviesEvent>((event, emit) async {
      emit(Loading());
      Either<Failure, MovieSearch>? failureOrMovieSearch =
          await getTrendingMovies(NoParams());
      print("Trending: " + failureOrMovieSearch.toString());

      failureOrMovieSearch!.fold((failure) {
        emit(Error(message: _mapFailureToMessage(failure)));
      }, (movieSearch) {
        emit(Loaded(movieSearch: movieSearch));
      });
    });
  }

  @override
  MoviesearchState get initialState => Empty();

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
