import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/movies.dart';
import 'cache_repository.dart';


class TopRatedRepository{
  static const _topRatedUrl = 'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apiKey}';

  final CacheRepository cacheRepository;

  TopRatedRepository({required this.cacheRepository});


  Future<List<Movies>> FetchTopRatedMovies() async {

    List<Movies> cachedMovies = await cacheRepository.getCachedMovies();

    if (cachedMovies.isNotEmpty) {
      return cachedMovies;
    }

    final response = await http.get(
      Uri.parse(_topRatedUrl),
    );

    if (response.statusCode == 200) { // everything is okay
      final decodedData = json.decode(response.body)['results'] as List;
      //print(decodedData);
      List<Movies> movies = decodedData.map((movie) => Movies.fromJson(movie)).toList();

      // Cache the fetched movies
      await cacheRepository.cacheMovies(movies);

      return movies;


    } else {
      throw Exception('Failed to load toprated movies');
    }
  }

}
