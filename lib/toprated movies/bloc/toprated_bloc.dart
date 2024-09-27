import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/models/movies.dart';


import '../../repository/toprated_repository.dart';

part 'toprated_event.dart';
part 'toprated_state.dart';

class TopratedBloc extends Bloc<TopratedEvent, TopratedState> {
  final TopRatedRepository topRatedRepository;

  TopratedBloc(this.topRatedRepository) : super(TopratedLoading()) {
    on<fetchTopratedMovies>((event, emit) async{
      try{
        final List<Movies> topRatedMovies = await topRatedRepository.FetchTopRatedMovies();
        emit(TopratedLoaded(topRatedMovies));
      } catch (e) {
        emit(TopratedError(e.toString()));
      }
    });

  }
}
