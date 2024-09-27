

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/movies.dart';


class CacheRepository {
  final String cacheKey;

  CacheRepository({required this.cacheKey});

  //  this are my cache Movies
  Future<void> cacheMovies(List<Movies> movies) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> moviesJson = movies.map((movie) => jsonEncode(movie.toJson())).toList();
    await prefs.setStringList(cacheKey, moviesJson);
  }

  //  from here we are retrieving Cached Movies
  Future<List<Movies>> getCachedMovies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cachedMoviesJson = prefs.getStringList(cacheKey);

    if (cachedMoviesJson != null) {
      return cachedMoviesJson.map((movieJson) => Movies.fromJson(jsonDecode(movieJson))).toList();
    }
    return [];
  }

  // Clearing Cache
  Future<void> clearCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(cacheKey);
  }
}
