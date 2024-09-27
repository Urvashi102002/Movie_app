import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/popular%20movies/bloc/popular_bloc.dart';
import 'package:movie_app/repository/cache_repository.dart';
import '../../Presentation/screens/movie_details_screen.dart';


class PopularMoviesWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final CacheRepository cacheRepository = CacheRepository(cacheKey: 'popular-movies');

    return BlocBuilder<PopularBloc, PopularState>(
      builder: (context, state) {
        if (state is PopularMoviesLoading) {
          return Center(
            child: CircularProgressIndicator(),);
        }
        else if (state is PopularMoviesLoaded) {
          return SizedBox(
            height: 200,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemCount: state.popularMovies.length,
              itemBuilder: (context, index) {
                final movie = state.popularMovies[index];
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
                          imageUrl: '${Constants.imagePath}${movie.backdropPath}',
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                          height: 200,
                          width: 200,
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()), // it will show loader while the image is loading
                          errorWidget: (context, url, error) => const Icon(Icons.error), // it will  show an error icon if loading fails
                        )
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is PopularMoviesError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return Center(child: Text('Something went wrong!'));
        }
      },
    );
  }
}























