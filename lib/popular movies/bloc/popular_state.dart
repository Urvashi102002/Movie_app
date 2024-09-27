part of 'popular_bloc.dart';

@immutable
//The BLoC state describes the different UI states (loading, loaded, error) that the UI responds to when BLoC emits a state.
abstract class PopularState {}

final class PopularMoviesLoading extends PopularState {}
class PopularMoviesLoaded extends PopularState{
  final List<Movies> popularMovies;

  PopularMoviesLoaded(this.popularMovies);


}
class PopularMoviesError extends PopularState{
  final String message;
  PopularMoviesError(this.message);
}

