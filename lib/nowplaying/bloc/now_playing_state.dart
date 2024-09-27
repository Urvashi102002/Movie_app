part of 'now_playing_bloc.dart';

@immutable
abstract class NowPlayingState {}

 class NowPlayingLoading extends NowPlayingState {

 }

class NowPlayingLoaded extends NowPlayingState{
  final List<Movies> nowplayingMovies;
  NowPlayingLoaded(this.nowplayingMovies);

}

class NowPlayingError extends NowPlayingState{
  final String message;
  NowPlayingError(this.message);
}
