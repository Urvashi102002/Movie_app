part of 'toprated_bloc.dart';

@immutable
abstract class TopratedState {}


class TopratedLoading extends TopratedState{}

class TopratedLoaded extends TopratedState{
  final List<Movies> movies;

  TopratedLoaded(this.movies);
}

class TopratedError extends TopratedState{
  final String message;

  TopratedError(this.message);
}



