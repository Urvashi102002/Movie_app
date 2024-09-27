import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Presentation/screens/movie_details_screen.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/nowplaying/bloc/now_playing_bloc.dart';
import 'package:movie_app/repository/cache_repository.dart';
import 'package:movie_app/repository/nowplaying_repository.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({super.key});

  @override
  Widget build(BuildContext context) {
    final CacheRepository cacheRepository =
        CacheRepository(cacheKey: 'now_playing_movies');
    final NowplayingRepository nowPlayingRepository =
        NowplayingRepository(cacheRepository: cacheRepository);

    return BlocBuilder<NowPlayingBloc, NowPlayingState>(
        builder: (context, state) {
      if (state is NowPlayingLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is NowPlayingLoaded) {
        return Container(
          height: 250,
          child: PageView.builder(
              itemCount: state.nowplayingMovies.length,
              // using loaded movies count
              itemBuilder: (context, index) {
                final movie =
                    state.nowplayingMovies[index]; // accessing the movie
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailScreen(movie: movie)));
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      //color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: CachedNetworkImage(
                        imageUrl: '${Constants.imagePath}${movie.backdropPath}',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // image: DecorationImage(
                    //   image: NetworkImage(
                    //       '${Constants.imagePath}${movie.backdropPath}'),
                    //   fit: BoxFit.cover,
                  ),
                );
              }),
        );
      } else if (state is NowPlayingError) {
        return Center(child: Text('Error : ${state.message}'));
      } else {
        return Center(
          child: Text('Something went wrong'),
        );
      }
    });
  }
}
