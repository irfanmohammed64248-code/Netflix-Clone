import 'package:api_netflix/features/home/presentation/pages/widgets/banner_shimmer.dart';
import 'package:api_netflix/features/home/presentation/pages/widgets/featured_movie_banner.dart';
import 'package:api_netflix/features/home/presentation/pages/widgets/home_top_bar.dart';
import 'package:api_netflix/features/home/presentation/pages/widgets/movie_section.dart';
import 'package:api_netflix/features/home/presentation/pages/widgets/movie_shimmer.dart';
import 'package:api_netflix/features/home/presentation/providers/movie_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsync = ref.watch(trendingMoviesProvider);
    final popularMoviesAsync = ref.watch(popularMoviesProvider);
    final nowPlayingAsync = ref.watch(nowPlayingMoviesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(16), child: HomeTopBar()),

            Expanded(
              child: moviesAsync.when(
                loading: () => ListView(
                  padding: const EdgeInsets.only(bottom: 24),
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 12),
                      child: Text(
                        'Trending Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    BannerShimmer(),
                  ],
                ),

                error: (error, stackTrace) => Center(
                  child: Text(
                    'Error: $error',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),

                data: (movies) {
                  if (movies.isEmpty) {
                    return const Center(
                      child: Text(
                        'No trending movies found',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  return ListView(
                    padding: const EdgeInsets.only(bottom: 0),
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16, 8, 16, 12),
                        child: Text(
                          'Trending Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      FeaturedMovieBanner(movies: movies),

                      const SizedBox(height: 16),

                      popularMoviesAsync.when(
                        loading: () => const MovieShimmer(),
                        error: (error, stackTrace) => Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'Failed to load popular movies: $error',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        data: (popularMovies) {
                          if (popularMovies.isEmpty) {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'No popular movies found',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }

                          return MovieSection(
                            title: 'Popular Movies',
                            movies: popularMovies,
                          );
                        },
                      ),

                      const SizedBox(height: 16),

                      nowPlayingAsync.when(
                        loading: () => const MovieShimmer(),
                        error: (error, stackTrace) => Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'Failed to load Now Playing movies: $error',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        data: (nowPlayingMovies) {
                          if (nowPlayingMovies.isEmpty) {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'No Now Playing movies found',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }

                          return MovieSection(
                            title: 'Now Playing',
                            movies: nowPlayingMovies,
                          );
                        },
                      ),

                      
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
