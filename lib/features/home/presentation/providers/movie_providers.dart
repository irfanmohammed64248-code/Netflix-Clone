import 'package:api_netflix/core/network/dio_client.dart';
import 'package:api_netflix/features/home/data/models/movie_model.dart';
import 'package:api_netflix/features/home/data/repositories/movie_repository_impl.dart';
import 'package:api_netflix/features/home/data/services/movie_api_service.dart';
import 'package:api_netflix/features/home/domain/repositories/movie_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
},);

final movieApiServiceProvider = Provider<MovieApiService>((ref) {
    final dioClient = ref.watch(dioClientProvider);
  return MovieApiService(dioClient);
},);

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
    final apiService = ref.watch(movieApiServiceProvider);
  return MovieRepositoryImpl(apiService);
},);

final trendingMoviesProvider = FutureProvider<List<MovieModel>>((ref)async {
  final repository = ref.watch(movieRepositoryProvider);

  return repository.getTrendingMovies();
},);

final popularMoviesProvider =
    FutureProvider<List<MovieModel>>((ref) async {
  final repository = ref.watch(movieRepositoryProvider);

  return repository.getPopularMovies();
});

final nowPlayingMoviesProvider =
    FutureProvider<List<MovieModel>>((ref,) async {
  final repository = ref.watch(movieRepositoryProvider);

  return repository.getNowPlayingMovies();
});

final searchMoviesProvider =
    FutureProvider.family<List<MovieModel>, String>((ref, query) async {
  final repository = ref.watch(movieRepositoryProvider);

  return repository.searchMovies(query);
});
