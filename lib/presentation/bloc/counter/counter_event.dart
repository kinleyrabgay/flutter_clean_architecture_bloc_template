part of 'counter_bloc.dart';

/// Base class for all counter events
abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

/// Event to load the current counter value
class CounterLoadRequested extends CounterEvent {
  const CounterLoadRequested();
}

/// Event to increment the counter
class CounterIncrementRequested extends CounterEvent {
  const CounterIncrementRequested();
}

/// Event to decrement the counter
class CounterDecrementRequested extends CounterEvent {
  const CounterDecrementRequested();
}

/// Event to reset the counter
class CounterResetRequested extends CounterEvent {
  const CounterResetRequested();
}
