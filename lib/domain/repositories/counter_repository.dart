import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/counter_entity.dart';

/// Abstract repository for counter operations
/// This defines the contract that must be implemented by the data layer
abstract class CounterRepository {
  /// Get the current counter value
  Future<Either<Failure, CounterEntity>> getCounter();

  /// Increment the counter by 1
  Future<Either<Failure, CounterEntity>> incrementCounter();

  /// Decrement the counter by 1
  Future<Either<Failure, CounterEntity>> decrementCounter();

  /// Reset the counter to 0
  Future<Either<Failure, CounterEntity>> resetCounter();

  /// Set the counter to a specific value
  Future<Either<Failure, CounterEntity>> setCounter(int value);
}
