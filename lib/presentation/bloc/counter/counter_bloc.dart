import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../core/utils/logger.dart';
import '../../../domain/entities/counter_entity.dart';
import '../../../domain/usecases/counter/get_counter.dart';
import '../../../domain/usecases/counter/increment_counter.dart';
import '../../../domain/usecases/counter/decrement_counter.dart';
import '../../../domain/usecases/usecase.dart';

part 'counter_event.dart';
part 'counter_state.dart';

/// BLoC for managing counter state and events
@injectable
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final GetCounter _getCounter;
  final IncrementCounter _incrementCounter;
  final DecrementCounter _decrementCounter;

  CounterBloc(this._getCounter, this._incrementCounter, this._decrementCounter)
    : super(CounterInitial()) {
    on<CounterLoadRequested>(_onCounterLoadRequested);
    on<CounterIncrementRequested>(_onCounterIncrementRequested);
    on<CounterDecrementRequested>(_onCounterDecrementRequested);
  }

  /// Load the current counter value
  Future<void> _onCounterLoadRequested(
    CounterLoadRequested event,
    Emitter<CounterState> emit,
  ) async {
    AppLogger.debug('Loading counter');
    emit(CounterLoading());

    final result = await _getCounter();

    result.fold(
      (failure) {
        AppLogger.error('Failed to load counter: ${failure.message}');
        emit(CounterError(failure.message));
      },
      (counter) {
        AppLogger.debug('Counter loaded successfully: ${counter.value}');
        emit(CounterLoaded(counter));
      },
    );
  }

  /// Increment the counter value
  Future<void> _onCounterIncrementRequested(
    CounterIncrementRequested event,
    Emitter<CounterState> emit,
  ) async {
    AppLogger.debug('Incrementing counter');
    emit(CounterLoading());

    final result = await _incrementCounter();

    result.fold(
      (failure) {
        AppLogger.error('Failed to increment counter: ${failure.message}');
        emit(CounterError(failure.message));
      },
      (counter) {
        AppLogger.debug('Counter incremented successfully: ${counter.value}');
        emit(CounterLoaded(counter));
      },
    );
  }

  /// Decrement the counter value
  Future<void> _onCounterDecrementRequested(
    CounterDecrementRequested event,
    Emitter<CounterState> emit,
  ) async {
    AppLogger.debug('Decrementing counter');
    emit(CounterLoading());

    final result = await _decrementCounter();

    result.fold(
      (failure) {
        AppLogger.error('Failed to decrement counter: ${failure.message}');
        emit(CounterError(failure.message));
      },
      (counter) {
        AppLogger.debug('Counter decremented successfully: ${counter.value}');
        emit(CounterLoaded(counter));
      },
    );
  }
}
