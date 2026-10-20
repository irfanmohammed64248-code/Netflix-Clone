import 'package:api_netflix/features/home/data/models/movie_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DownloadNotifier extends Notifier<List<MovieModel>> {
  @override
  List<MovieModel> build() {
    return [];
  }

  void addMovie(MovieModel movie) {
    final alreadyExits = state.any((item) => item.id == movie.id);

    if (alreadyExits) return;
    state = [...state, movie];
  }

  void removeMovie(int movieId) {
    state = state.where((movie) => movie.id != movieId).toList();
  }
}

final downloadProvider = NotifierProvider<DownloadNotifier, List<MovieModel>>(
  () => DownloadNotifier(),
);
