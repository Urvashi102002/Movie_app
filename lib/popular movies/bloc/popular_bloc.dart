import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/models/movies.dart';
import 'package:movie_app/repository/popular_repository.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  final PopularRepository popularRepository;


  PopularBloc(this.popularRepository) : super(PopularMoviesLoading()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(PopularMoviesLoading());

      try{
        // fetch the popular movies from the repository
        final popularMovies = await popularRepository.fetchPopularMovies();
      // emit the loaded state with the fetched movies
      emit(PopularMoviesLoaded(popularMovies));
      }
    catch(error){
      // Emit an error state if something goes wrong
      emit(PopularMoviesError(error.toString()));
    }
    });
  }
}
