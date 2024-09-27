import 'dart:convert';
import '../constants.dart';
import '../models/movies.dart';
import 'package:http/http.dart' as http;

import 'cache_repository.dart';
class NowplayingRepository{
  static const _nowPlayingUrl = 'https://api.themoviedb.org/3/movie/now_playing?api_key=${Constants.apiKey}';
  final CacheRepository cacheRepository;

  NowplayingRepository({required this.cacheRepository});

  Future<List<Movies>> fetchNowPlayingMovies() async {

    List<Movies> cachedMovies = await cacheRepository.getCachedMovies();
    if (cachedMovies.isNotEmpty) {
      return cachedMovies;
    }

    // If there is no cached movies present, then we can fetch from API
    final response = await http.get(
      Uri.parse(_nowPlayingUrl),
    );

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      List<Movies> movies = decodedData.map((movie) => Movies.fromJson(movie)).toList();

      // Cache the fetched movies
      await cacheRepository.cacheMovies(movies);

      return movies;
    } else {
      throw Exception('Failed to load now playing movies');
    }
  }
}