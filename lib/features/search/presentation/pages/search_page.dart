import 'package:api_netflix/features/home/presentation/providers/movie_providers.dart';
import 'package:api_netflix/features/home/presentation/providers/search_query_provider.dart';
import 'package:api_netflix/features/movie_details/presentation/pages/movie_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(searchQueryProvider);

    final searchAsync = searchQuery.isEmpty
        ? null
        : ref.watch(searchMoviesProvider(searchQuery));

    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        backgroundColor: const Color(0xFF141414),
        title: const Text(
          'Search Movies',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,

              onChanged: (value) {
                ref
                    .read(searchQueryProvider.notifier)
                    .updateQuery(value.trim());
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search movies...',
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                filled: true,
                fillColor: const Color(0xFF252525),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: searchQuery.isEmpty
                  ? const Center(
                      child: Text(
                        'Search for your favourite movies',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : searchAsync!.when(
                      loading: () => const Center(
                        child: CircularProgressIndicator(color: Colors.red),
                      ),
                      error: (error, stackTrace) => Center(
                        child: Text(
                          'Failed to search movies: $error',
                          style: const TextStyle(color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      data: (movies) {
                        if (movies.isEmpty) {
                          return const Center(
                            child: Text(
                              'No movies found',
                              style: TextStyle(color: Colors.white70),
                            ),
                          );
                        }

                        return GridView.builder(
                          padding: const EdgeInsets.only(bottom: 16),
                          itemCount: movies.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 24,
                                childAspectRatio: 0.52,
                              ),
                          itemBuilder: (context, index) {
                            final movie = movies[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MovieDetailsPage(movie: movie),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child:
                                          movie.posterPath != null &&
                                              movie.posterPath!.isNotEmpty
                                          ? Image.network(
                                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                    return Container(
                                                      color: const Color(
                                                        0xFF252525,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Icon(
                                                        Icons.movie_outlined,
                                                        color: Colors.white54,
                                                        size: 32,
                                                      ),
                                                    );
                                                  },
                                            )
                                          : Container(
                                              color: const Color(0xFF252525),
                                              alignment: Alignment.center,
                                              child: const Icon(
                                                Icons.movie_outlined,
                                                color: Colors.white54,
                                                size: 32,
                                              ),
                                            ),
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  Text(
                                    movie.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xFFFFC107),
                                        size: 18,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        movie.voteAverage.toStringAsFixed(1),
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
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
