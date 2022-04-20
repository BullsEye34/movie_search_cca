import 'package:movie_search/core/error/exceptions.dart';
import 'package:movie_search/core/network/network_info.dart';
import 'package:movie_search/features/movie_search/data/datasources/movie_search_local_datasource.dart';
import 'package:movie_search/features/movie_search/data/datasources/movie_search_remote_datasource.dart';
import 'package:movie_search/features/movie_search/data/models/movie_search_model.dart';
import 'package:movie_search/features/movie_search/domain/entities/movie_search.dart';
import 'package:movie_search/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_search/features/movie_search/domain/repositories/movie_search_repository.dart';

typedef Future<MovieSearchModel> _TrendingOrSearchChooser();

class MovieSearchRepoImpl implements MovieSearchRepository {
  MovieSearchRemoteDataSource remoteDataSource;
  MovieSearchLocalDataSource localDataSource;
  NetworkInformation networkInfo;
  MovieSearchRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, MovieSearch>> getMovieSearch(String query) async {
    return await _getMovieSearch(() => remoteDataSource.getMovies(query));
  }

  @override
  Future<Either<Failure, MovieSearch>> getTrendingMovies() async {
    return await _getMovieSearch(() => remoteDataSource.getTrendingMovies());
  }

  Future<Either<Failure, MovieSearch>> _getMovieSearch(
      _TrendingOrSearchChooser getTrendingOrSearch) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteTrivia = await getTrendingOrSearch();
        localDataSource.cacheMovieSearch(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localtrivia = await localDataSource.getLastMovieSearch();
        return Right(localtrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
