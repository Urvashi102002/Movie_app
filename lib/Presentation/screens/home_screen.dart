
import 'package:flutter/material.dart' ;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Presentation/screens/search_movies_screen.dart';
import 'package:movie_app/nowplaying/bloc/now_playing_bloc.dart';
import 'package:movie_app/nowplaying/pages/now_playing.dart';
import 'package:movie_app/popular%20movies/bloc/popular_bloc.dart';
import 'package:movie_app/popular%20movies/pages/popular_movies.dart';
import 'package:movie_app/repository/cache_repository.dart';
import 'package:movie_app/repository/nowplaying_repository.dart';
import 'package:movie_app/repository/popular_repository.dart';
import 'package:movie_app/repository/toprated_repository.dart';
import 'package:movie_app/repository/upcoming_repository.dart';
import 'package:movie_app/toprated%20movies/bloc/toprated_bloc.dart';
import 'package:movie_app/toprated%20movies/pages/top_rated_movies.dart';
import 'package:movie_app/upcoming%20movies/bloc/upcoming_bloc.dart';
import 'package:movie_app/upcoming%20movies/pages/upcoming_movies.dart';




class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

late CacheRepository nowPlayingCacheRepository;
late CacheRepository upcomingMoviesCacheRepository;
late CacheRepository topratedCacheRepository;
late CacheRepository popularCacheRepository;

@override
void initState() {
  super.initState();
  nowPlayingCacheRepository = CacheRepository(cacheKey: 'upcomingMovies');
  upcomingMoviesCacheRepository= CacheRepository(cacheKey: 'now_playing_movies');
  topratedCacheRepository= CacheRepository(cacheKey: 'top_rated_movies');
  popularCacheRepository = CacheRepository(cacheKey: 'popular_movies');


}
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        elevation: 20,
        shadowColor: Colors.black.withOpacity(0.5),
        //backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.redAccent, Colors.orangeAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Image.asset('assets/images/logo.png' , height: 60,),
            Image.asset('assets/images/imagess.png',height: 60,),
            const SizedBox(width: 50),

            Text('FILM HUB', style: GoogleFonts.aBeeZee(fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.black),),
            const SizedBox(width: 50),

            IconButton(onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SearchMoviesScreen()
                ),);
            },
              icon: Icon(Icons.search),
              color: Colors.black, iconSize: 30,
            ),
            //Icon(Icons.search, color: Colors.white, on) ,

          ],
        ),

      ),


      body: SingleChildScrollView(physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const SizedBox(height: 25,),
              Text('Now Playing Movies', style: GoogleFonts.aBeeZee(fontSize: 30)),
              // SizedBox(height: 32,),

              const SizedBox(height: 25,),
              SizedBox(
                child: BlocProvider(
                  create: (context) => NowPlayingBloc(NowplayingRepository(
                      cacheRepository: nowPlayingCacheRepository))..add(FetchNowPlayingMovies()),
                  child: const NowPlaying(),
                ),
              ),


              const SizedBox(height: 25),
              Text(
                'Upcoming Movies', style: GoogleFonts.aBeeZee(fontSize: 30,),),
              const SizedBox(height: 32,),
             SizedBox(
               child: BlocProvider(
                 create: (context) => UpcomingBloc(UpcomingRepository(
                     upcomingMoviesCacheRepository))..add(fetchUpcomingMovies()),
                 child: UpcomingMovies(),
               ),
             ),

              const SizedBox(height: 25,),
              Text(
                'Top Rated Movies', style: GoogleFonts.aBeeZee(fontSize: 30),),
               const SizedBox(height: 32,),
              SizedBox(
                child: BlocProvider(
                  create: (context) => TopratedBloc(TopRatedRepository(
                      cacheRepository: topratedCacheRepository))..add(fetchTopratedMovies()),
                  child: TopRatedMovies(),
                ),
              ),



              const SizedBox(height: 25,),
              Text('Popular Movies', style: GoogleFonts.aBeeZee(fontSize: 30),),
              const SizedBox(height: 32,),
              BlocProvider(
                create: (context) => PopularBloc(PopularRepository(
                    cacheRepository: popularCacheRepository))..add(FetchPopularMovies()),
                child: PopularMoviesWidget(),
              ),



       ], ),

      ),
    ),
    );
  }
}


