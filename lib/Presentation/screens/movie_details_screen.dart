import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models/movies.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movies movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            CachedNetworkImage(
                imageUrl: '${Constants.imagePath}${movie.posterPath}',
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()), // Show loader while the image is loading
                 errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(height: 16),
            Text('Title: ${movie.title}', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            Text('Release Date: ${movie.releaseDate}',style: const TextStyle(fontSize: 16),),
            const SizedBox(height: 16),
            Text('Overview: ${movie.overview}',style: const TextStyle(fontSize: 16),),
            const SizedBox(height: 16),
            // Text('Rating: ${movie.voteAverage.round()}'),
            // const Icon(Icons.star , color: Colors.red,),
            Row(
              children: [
                Text('Rating: ${movie.voteAverage.round()}',style: const TextStyle(fontSize: 16),),
                const SizedBox(width: 4), // Adjust the width for desired spacing
                const Icon(Icons.star, color: Colors.red),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
