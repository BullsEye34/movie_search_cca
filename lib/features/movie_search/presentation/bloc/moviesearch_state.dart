part of 'moviesearch_bloc.dart';

abstract class MoviesearchState extends Equatable {
  const MoviesearchState();

  @override
  List<Object> get props => [];
}

class Empty extends MoviesearchState {}

class Loading extends MoviesearchState {}

class Loaded extends MoviesearchState {
  MovieSearch movieSearch;
  Loaded({required this.movieSearch});
  @override
  List<Object> get props => [movieSearch];
}

class Error extends MoviesearchState {
  late final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
