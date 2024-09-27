import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Presentation/screens/movie_details_screen.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/repository/cache_repository.dart';
import 'package:movie_app/upcoming%20movies/bloc/upcoming_bloc.dart';


class UpcomingMovies extends StatelessWidget {

  final CacheRepository cacheRepository = CacheRepository(cacheKey: 'upcomingMovies');

  UpcomingMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpcomingBloc, UpcomingState>(
        builder: (context, state) {
      if (state is UpcomingLoading) {
        return const Center(
          child: CircularProgressIndicator(),);
      }
      else if(state is UpcomingLoaded){
        return SizedBox(
           height: 200, width: double.infinity,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: state.upcomingmovies.length,
              itemBuilder: ( context,index) {
                final movie = state.upcomingmovies[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to movie details page on image tap
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
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          )
                      )
                  ),
                );
              },
          ),

        );
      }
      else if(state is UpcomingError){
        return const Center(child: Text('Error: &{state.message}'));
      }
      else{
        return const Center(child: Text('Something went wrong!'));
      }
        },
    );

  }
  }
