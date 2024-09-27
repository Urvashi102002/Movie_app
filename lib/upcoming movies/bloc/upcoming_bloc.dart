import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:movie_app/models/movies.dart';
import 'package:movie_app/repository/upcoming_repository.dart';
part 'upcoming_event.dart';
part 'upcoming_state.dart';

class UpcomingBloc extends Bloc<UpcomingEvent, UpcomingState> {

  final UpcomingRepository upcomingRepository;

  UpcomingBloc(this.upcomingRepository) : super(UpcomingLoading()) {
    on<fetchUpcomingMovies>((event, emit) async{
      emit (UpcomingLoading());


    try{
      final upcomingMovies = await upcomingRepository.fetchUpcomingMovies();
      emit(UpcomingLoaded(upcomingMovies));
    }
    catch (error){
      emit(UpcomingError(error.toString()));
    }
  });
  }
}
