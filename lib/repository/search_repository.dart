import 'dart:convert';

import '../constants.dart';
import '../models/movies.dart';
import 'package:http/http.dart' as http;

class SearchRepository{
  static const _searchUrl = 'https://api.themoviedb.org/3/search/movie';
  static Future<List<Movies>> searchMovies(String query) async {
    final response = await http.get(Uri.parse('$_searchUrl?api_key=${Constants.apiKey}&query=$query'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return (data['results'] as List).map((e) => Movies.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load search results');
    }
  }
}


