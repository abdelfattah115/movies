import 'package:get_it/get_it.dart';
import 'package:movies/movies/data/datasource/remote_datasource.dart';
import 'package:movies/movies/data/repository/movie_repository.dart';
import 'package:movies/movies/domain/repository/base_movie_repository.dart';
import 'package:movies/movies/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:movies/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movies/movies/domain/usecases/get_top_rates_movies_usecase.dart';
import 'package:movies/movies/presentation/controller/movies_bloc.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() {
    /// BLOC
    sl.registerFactory(() => MoviesBloc(sl(),sl(),sl()));

    /// USE CASES
    sl.registerLazySingleton(
        () => GetNowPlayingMoviesUseCase(baseMoviesRepository: sl()));
    sl.registerLazySingleton(
            () => GetPopularMoviesUseCase(baseMoviesRepository: sl()));
    sl.registerLazySingleton(
            () => GetTopRatedMoviesUseCase(baseMoviesRepository: sl()));

    /// REPOSITORY
    sl.registerLazySingleton<BaseMoviesRepository>(
        () => MovieRepository(baseMoviesRemoteDataSource: sl()));

    /// REMOTE DATASOURCE
    sl.registerLazySingleton<BaseMoviesRemoteDataSource>(
        () => MoviesRemoteDataSource());
  }
}
