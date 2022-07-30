import 'package:dartz/dartz.dart';
import 'package:movies/core/error/exceptions.dart';
import 'package:movies/core/error/failure.dart';
import 'package:movies/movies/data/datasource/remote_datasource.dart';
import 'package:movies/movies/domain/entity/movie.dart';
import 'package:movies/movies/domain/repository/base_movie_repository.dart';

class MovieRepository extends BaseMoviesRepository {
  final BaseMoviesRemoteDataSource baseMoviesRemoteDataSource;

  MovieRepository({required this.baseMoviesRemoteDataSource});

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    final result = await baseMoviesRemoteDataSource.getNowPlayingMovies();
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(
          ServerFailure(message: failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    final result = await baseMoviesRemoteDataSource.getPopularMovies();
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(
          ServerFailure(message: failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async{
    final result = await baseMoviesRemoteDataSource.getTopRatesMovies();
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(
          ServerFailure(message: failure.errorMessageModel.statusMessage));
    }
  }
}
