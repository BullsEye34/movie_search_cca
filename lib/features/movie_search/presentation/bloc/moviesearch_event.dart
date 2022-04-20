part of 'moviesearch_bloc.dart';

abstract class MoviesearchEvent extends Equatable {
  const MoviesearchEvent();

  @override
  List<Object> get props => [];
}

class GetMovieForSearch extends MoviesearchEvent {
  String title;
  GetMovieForSearch({required this.title});

  @override
  List<Object> get props => [title];
}

class GetTrendingMovies extends MoviesearchEvent {}
