import 'package:api_netflix/features/home/data/models/movie_model.dart';
import 'package:api_netflix/features/movie_details/presentation/pages/movie_details_page.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    Widget buildPlaceholder() {
      return Container(
        height: 190,
        width: 130,
        color: const Color(0xFF252525),
        alignment: Alignment.center,
        child: const Icon(
          Icons.movie_outlined,
          color: Colors.white54,
          size: 35,
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsPage(movie: movie),
          ),
        );
      },
      child: SizedBox(
        width: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: movie.posterPath != null && movie.posterPath!.isNotEmpty
                  ? Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      height: 190,
                      width: 130,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return buildPlaceholder();
                      },
                    )
                  : buildPlaceholder(),
            ),

            const SizedBox(height: 8),

            Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),

            Row(
              children: [
                const Icon(Icons.star, color: Color(0xFFFFC107), size: 18),
                const SizedBox(width: 5),
                Text(
                  movie.voteAverage.toStringAsFixed(1),
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
