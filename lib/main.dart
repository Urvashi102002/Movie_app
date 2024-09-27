import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/Presentation/screens/home_screen.dart';
import 'package:movie_app/repository/cache_repository.dart';
import 'package:movie_app/repository/upcoming_repository.dart';
import 'package:movie_app/upcoming%20movies/bloc/upcoming_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter binding is initialized
  SharedPreferences prefs = await SharedPreferences.getInstance(); // Initialize SharedPreferences

  final cacheRepository = CacheRepository(cacheKey: 'upcomingMovies');
  runApp( MyApp( cacheRepository : cacheRepository));
}

class MyApp extends StatelessWidget {
  final CacheRepository cacheRepository;

  const MyApp({super.key, required this.cacheRepository});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MOVIE APP',
    theme: ThemeData.dark().copyWith(
      //scaffoldBackgroundColor: Colors.grey,


    ),
        home: RepositoryProvider(
        create: (context) => UpcomingRepository(cacheRepository),
    child: BlocProvider(
    create: (context) => UpcomingBloc(RepositoryProvider.of<UpcomingRepository>(context))..add(fetchUpcomingMovies()),
    child: const HomeScreen(),


    //  home: const MyHomePage(title: 'Flutter Demo Home Page'),
    ),
        ),
    );
  }
}

