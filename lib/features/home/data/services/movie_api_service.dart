import 'package:api_netflix/core/constants/api_constants.dart';
import 'package:api_netflix/core/network/dio_client.dart';
import 'package:api_netflix/features/home/data/models/movie_model.dart';

class MovieApiService {
  final DioClient dioClient;

  MovieApiService(this.dioClient);

  Future<List<MovieModel>> getTrendingMovies() async {
    final response = await dioClient.dio.get(ApiConstants.trendingMovies);
    final List data = response.data["results"];
    return data.map((json) => MovieModel.fromJson(json)).toList();
  }

  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response = await dioClient.dio.get(ApiConstants.nowPlayingMovies);
    final List data = response.data["results"];
    return data.map((json) => MovieModel.fromJson(json)).toList();
  }

  Future<List<MovieModel>> getPopularMovies() async {
    final response = await dioClient.dio.get(ApiConstants.popularMovies);
    final List data = response.data["results"];
    return data.map((json) => MovieModel.fromJson(json)).toList();
  }

  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await dioClient.dio.get(
      ApiConstants.searchMovies,
      queryParameters: {"query": query},
    );
    final List data = response.data["results"];
    return data.map((json) => MovieModel.fromJson(json)).toList();
  }
}
