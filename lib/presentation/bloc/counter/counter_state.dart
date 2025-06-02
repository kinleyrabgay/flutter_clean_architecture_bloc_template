part of 'counter_bloc.dart';

/// Base class for all counter states
abstract class CounterState extends Equatable {
  const CounterState();

  @override
  List<Object> get props => [];
}

/// Initial state when the counter is first created
class CounterInitial extends CounterState {}

/// State when the counter is loading
class CounterLoading extends CounterState {}

/// State when the counter is successfully loaded
class CounterLoaded extends CounterState {
  final CounterEntity counter;

  const CounterLoaded(this.counter);

  @override
  List<Object> get props => [counter];
}

/// State when there's an error with the counter
class CounterError extends CounterState {
  final String message;

  const CounterError(this.message);

  @override
  List<Object> get props => [message];
}
