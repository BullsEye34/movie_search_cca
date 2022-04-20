part of 'moviesearch_bloc.dart';

abstract class MoviesearchEvent extends Equatable {
  const MoviesearchEvent();

  @override
  List<Object> get props => [];
}

class GetMovieForSearchEvent extends MoviesearchEvent {
  String title;
  GetMovieForSearchEvent({required this.title});

  @override
  List<Object> get props => [title];
}

class GetTrendingMoviesEvent extends MoviesearchEvent {}
