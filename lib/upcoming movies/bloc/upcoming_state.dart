part of 'upcoming_bloc.dart';

@immutable
abstract class UpcomingState {}


final class UpcomingLoading extends UpcomingState{}

final class UpcomingLoaded extends UpcomingState{
  final List<Movies> upcomingmovies;
  UpcomingLoaded(this.upcomingmovies);



}

final class UpcomingError extends UpcomingState{
  final String message;

  UpcomingError(this.message);
}

