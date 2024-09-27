import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:movie_app/models/movies.dart';
import 'package:movie_app/repository/nowplaying_repository.dart';


part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final NowplayingRepository nowplayingRepository;

  NowPlayingBloc(this.nowplayingRepository) : super(NowPlayingLoading()) {
    on<FetchNowPlayingMovies>((event, emit)  async{
      emit(NowPlayingLoading());

    try{
      // fetch the popular movies from the repository
      final nowPlayingMovies = await nowplayingRepository.fetchNowPlayingMovies();
      // emit the loaded state with the fetched movies
      emit(NowPlayingLoaded(nowPlayingMovies));
    }
    catch(error){
      // Emit an error state if something goes wrong
      emit(NowPlayingError(error.toString()));
    }
  });
  }
}
