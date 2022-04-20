import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/core/error/failures.dart';
import 'package:movie_search/features/movie_search/domain/entities/movie_search.dart';

abstract class MovieSearchRepository {
  Future<Either<Failure, MovieSearch>> getMovieSearch(String query);
  Future<Either<Failure, MovieSearch>> getTrendingMovies();
}
