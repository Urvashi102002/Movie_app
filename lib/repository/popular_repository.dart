import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants.dart'; // Assuming you have a Constants file where apiKey is stored.
import '../models/movies.dart';
import 'cache_repository.dart';



class PopularRepository {
  static const _popularUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=${Constants.apiKey}';

  final CacheRepository cacheRepository;

  PopularRepository({required this.cacheRepository});

  Future<List<Movies>> fetchPopularMovies() async {

    List<Movies> cachedMovies = await cacheRepository.getCachedMovies();
    if (cachedMovies.isNotEmpty) {
      return cachedMovies;
    }

    final response = await http.get(
      Uri.parse(_popularUrl),
    );

    if (response.statusCode == 200) { // everything is okay
      final decodedData = json.decode(response.body)['results'] as List;
      //print(decodedData);

      List<Movies> movies = decodedData.map((movie) => Movies.fromJson(movie)).toList();

      // Cache the fetched movies
      await cacheRepository.cacheMovies(movies);

      return movies;

    } else {
      throw Exception('Failed to load popular movies');
    }
  }
}

































// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:movie_app/constants.dart';
// import 'package:movie_app/models/movies.dart';
//
//
// class PopularRepository {
//   static const _popularUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=${Constants
//       .apiKey}';
//
//   Future<List<Movies>> getPopularMovies() async {
//     final response = await http.get(
//       Uri.parse(_popularUrl),
//     );
//     if (response.statusCode == 200) { // means everything is okay
//        final decodedData = json.decode(response.body)['results'] as List;
//       print(decodedData);
//        return decodedData.map((movies)=> Movies.fromJson(movies)).toList();
//     }
//     else {
//       throw Exception('Failed to load popular movies');
//     }
//   }
// }

  // final String apiKey = 'your_tmdb_api_key_here';
  //
  // Future<List<Movies>> fetchPopularMovies() async {
  //   final response = await http.get(
  //     Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=$apiKey'),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final List<dynamic> results = jsonDecode(response.body)['results'];
  //     return results.map((json) => Movies.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Failed to load popular movies');

