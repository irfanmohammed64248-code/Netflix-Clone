import 'package:api_netflix/features/home/data/models/movie_model.dart';
import 'package:api_netflix/features/home/presentation/providers/download_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieDetailsPage extends ConsumerWidget{
  final MovieModel movie;

  const MovieDetailsPage({
    super.key,
    required this.movie
  });

 
@override
Widget build(BuildContext context,WidgetRef ref) {

  return Scaffold(
    backgroundColor: const Color(0xFF141414),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie backdrop
          Stack(
            children: [
              SizedBox(
                height: 280,
                width: double.infinity,
                child: movie.backdropPath != null &&
                        movie.backdropPath!.isNotEmpty
                    ? Image.network(
                        'https://image.tmdb.org/t/p/w780${movie.backdropPath}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFF252525),
                          );
                        },
                      )
                    : Container(
                        color: const Color(0xFF252525),
                      ),
              ),

              // Dark gradient over the bottom of the image
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: 120,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Color(0xFF141414),
                      ],
                    ),
                  ),
                ),
              ),

              // Back button
              Positioned(
                top: 45,
                left: 16,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black54,
                  ),
                ),
              ),
            ],
          ),

          // Movie information
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Color(0xFFFFC107),
                      size: 20,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      movie.voteAverage.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

// Release date
if (movie.releaseDate != null &&
    movie.releaseDate!.isNotEmpty)
  Text(
    'Release Date: ${movie.releaseDate}',
    style: const TextStyle(
      color: Colors.white70,
      fontSize: 14,
    ),
  ),

const SizedBox(height: 20),

// Movie overview heading
const Text(
  'Overview',
  style: TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 8),

// Movie overview
Text(
  movie.overview.isNotEmpty
      ? movie.overview
      : 'No overview available.',
  style: const TextStyle(
    color: Colors.white70,
    fontSize: 15,
    height: 1.5,
  ),
),
const SizedBox(height: 24),

SizedBox(
  width: double.infinity,
  child: ElevatedButton.icon(
    onPressed: () {
      ref.read(downloadProvider.notifier).addMovie(movie);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added to Downloads"),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color(0xFF252525),
      ));
    },
    icon: const Icon(Icons.download),
    label: const Text('Download'),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
),

const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

}