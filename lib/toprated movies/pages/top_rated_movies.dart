import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Presentation/screens/movie_details_screen.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/repository/cache_repository.dart';
import 'package:movie_app/toprated%20movies/bloc/toprated_bloc.dart';

class TopRatedMovies extends StatelessWidget {
  const TopRatedMovies({super.key});

  @override
  Widget build(BuildContext context) {
    final CacheRepository cacheRepository =
        CacheRepository(cacheKey: 'top_rated_movies');

    return BlocBuilder<TopratedBloc, TopratedState>(
      builder: (context, state) {
        if (state is TopratedLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TopratedLoaded) {
          return SizedBox(
            height: 300,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetailScreen(movie: movie),
                            ),
                          );
                        },
                        child: CachedNetworkImage(
                          imageUrl:
                              '${Constants.imagePath}${movie.backdropPath}',
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                          height: 200,
                          width: 200,
                          placeholder: (context, url) => const Center(
                              child:
                                  CircularProgressIndicator()), // Show loader while the image is loading
                          errorWidget: (context, url, error) => const Icon(Icons
                              .error),
                        )),
                  ),
                );
              },
            ),
          );
        } else if (state is TopratedError) {
          return const Center(child: Text('Error: &{state.message}'));
        } else {
          return const Center(child: Text('Something went wrong!'));
        }
      },
    );
  }
}
