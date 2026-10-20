import 'package:api_netflix/features/home/data/models/movie_model.dart';
import 'package:api_netflix/features/home/data/services/movie_api_service.dart';
import 'package:api_netflix/features/home/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository{
   final MovieApiService apiService;

   MovieRepositoryImpl(this.apiService);

    @override
    Future<List<MovieModel>> getTrendingMovies(){
      return apiService.getTrendingMovies();
    }
    @override
    Future<List<MovieModel>> getNowPlayingMovies(){
      return apiService.getNowPlayingMovies();
    }
    @override
    Future<List<MovieModel>> getPopularMovies(){
      return apiService.getPopularMovies();
    }
    @override
    Future<List<MovieModel>> searchMovies(String query){
      return apiService.searchMovies(query);
    }
}