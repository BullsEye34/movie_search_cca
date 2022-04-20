import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_search/core/network/network_info.dart';
import 'package:movie_search/features/movie_search/data/datasources/movie_search_local_datasource.dart';
import 'package:movie_search/features/movie_search/data/datasources/movie_search_remote_datasource.dart';
import 'package:movie_search/features/movie_search/data/repositories/movie_search_repo_impl.dart';
import 'package:movie_search/features/movie_search/domain/repositories/movie_search_repository.dart';
import 'package:movie_search/features/movie_search/domain/usecases/get_movie_search.dart';
import 'package:movie_search/features/movie_search/domain/usecases/get_trending_movies.dart';
import 'package:movie_search/features/movie_search/presentation/bloc/moviesearch_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

GetIt sl = GetIt.instance;

Future<void> init() async {
  //! Features MovieSearch
  // Register BLOC
  sl.registerFactory<MoviesearchBloc>(
      () => MoviesearchBloc(getMovieSearch: sl(), getTrendingMovies: sl()));

  // Register UseCases
  sl.registerLazySingleton(() => GetMovieSearch(repository: sl()));
  sl.registerLazySingleton(() => GetTrendingMovies(repository: sl()));

  // Register Repository
  sl.registerLazySingleton<MovieSearchRepository>(() => MovieSearchRepoImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  // Register DataSource
  sl.registerLazySingleton<MovieSearchRemoteDataSource>(
      () => MovieSearchRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<MovieSearchLocalDataSource>(
      () => MovieSearchLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInformation>(
      () => NetworkInformationImpl(sl()));
  //! External
  SharedPreferences sharedPreferencess = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferencess);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
