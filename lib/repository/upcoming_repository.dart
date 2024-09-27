import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/movies.dart';
import 'cache_repository.dart';

class UpcomingRepository{
  final String cacheKey ='upcomingMovies';
  static const _upcomingUrl = 'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.apiKey}';
final CacheRepository cacheRepository;

UpcomingRepository(this.cacheRepository);


  // fetching movies with caching
  Future<List<Movies>> fetchUpcomingMovies() async {
    //  i am trying to get cached movies first
    final cachedMovies = await cacheRepository.getCachedMovies();
    if(cachedMovies.isNotEmpty){
     // print('Fetching from cache');
      return cachedMovies;
    }


    //print('Fetching from API');
    final response = await http.get(Uri.parse(_upcomingUrl));


    if (response.statusCode == 200) { // everything is okay
      final decodedData = json.decode(response.body)['results'] as List;
      List<Movies> upcomingMovies = decodedData.map((movie) => Movies.fromJson(movie)).toList();



      await cacheRepository.cacheMovies(upcomingMovies);
      return upcomingMovies;

    } else {
      throw Exception('Failed to load upcoming movies');
    }
  }


}
