import 'package:flutter/material.dart';
import 'package:movie_app/Presentation/screens/movie_details_screen.dart';

import 'package:movie_app/models/movies.dart';
import 'package:movie_app/repository/search_repository.dart';

import '../../constants.dart';

class SearchMoviesScreen extends StatefulWidget {
  const SearchMoviesScreen({super.key});

  @override
  State<SearchMoviesScreen> createState() => _SearchMoviesScreenState();
}

class _SearchMoviesScreenState extends State<SearchMoviesScreen> {
  List<Movies> _searchResults = [];

  void _searchMovies(String query) async {
    final results = await SearchRepository.searchMovies(query); // API call
    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(hintText: 'Search for movies...'),
          onSubmitted: _searchMovies, // trigger search on submit
        ),
      ),
      body: _searchResults.isEmpty
          ? const Center(
              child: Text('No results found'),
            )
          : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final movie = _searchResults[index];
                return ListTile(
                    title: Text(movie.title),
                    leading: (movie.posterPath != null &&
                            movie.posterPath!.isNotEmpty)
                        ? Image.network(
                            '${Constants.imagePath}${movie.posterPath}',
                            errorBuilder: (context, error, stackTrace) {
                              return Image.network(
                                'https://via.placeholder.com/150', // if there will be no image then this default fallback image from a URL will show
                              );
                            },
                          )
                        : Image.network('https://via.placeholder.com/150'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailScreen(movie: movie),
                        ),
                      );
                    });
              }),
    );
  }
}
