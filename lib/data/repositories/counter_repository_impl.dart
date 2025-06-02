import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/utils/logger.dart';
import '../../domain/entities/counter_entity.dart';
import '../../domain/repositories/counter_repository.dart';
import '../datasources/counter_local_data_source.dart';
import '../models/counter_model.dart';

/// Implementation of CounterRepository
/// Handles counter operations using local data sources
@Injectable(as: CounterRepository)
class CounterRepositoryImpl implements CounterRepository {
  final CounterLocalDataSource localDataSource;

  CounterRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, CounterEntity>> getCounter() async {
    try {
      AppLogger.debug('Getting counter from local data source');
      final counter = await localDataSource.getCachedCounter();
      return Right(counter);
    } on CacheException catch (e) {
      AppLogger.error('Cache exception while getting counter', e);
      return Left(CacheFailure(e.message));
    } catch (e) {
      AppLogger.error('Unknown exception while getting counter', e);
      return const Left(UnknownFailure('Failed to get counter'));
    }
  }

  @override
  Future<Either<Failure, CounterEntity>> incrementCounter() async {
    try {
      AppLogger.debug('Incrementing counter');
      final currentCounter = await localDataSource.getCachedCounter();
      final newCounter = currentCounter.copyWith(
        value: currentCounter.value + 1,
        lastUpdated: DateTime.now(),
      );
      await localDataSource.cacheCounter(newCounter);
      return Right(newCounter);
    } on CacheException catch (e) {
      AppLogger.error('Cache exception while incrementing counter', e);
      return Left(CacheFailure(e.message));
    } catch (e) {
      AppLogger.error('Unknown exception while incrementing counter', e);
      return const Left(UnknownFailure('Failed to increment counter'));
    }
  }

  @override
  Future<Either<Failure, CounterEntity>> decrementCounter() async {
    try {
      AppLogger.debug('Decrementing counter');
      final currentCounter = await localDataSource.getCachedCounter();
      final newCounter = currentCounter.copyWith(
        value: currentCounter.value - 1,
        lastUpdated: DateTime.now(),
      );
      await localDataSource.cacheCounter(newCounter);
      return Right(newCounter);
    } on CacheException catch (e) {
      AppLogger.error('Cache exception while decrementing counter', e);
      return Left(CacheFailure(e.message));
    } catch (e) {
      AppLogger.error('Unknown exception while decrementing counter', e);
      return const Left(UnknownFailure('Failed to decrement counter'));
    }
  }

  @override
  Future<Either<Failure, CounterEntity>> resetCounter() async {
    try {
      AppLogger.debug('Resetting counter');
      final newCounter = CounterModel(value: 0, lastUpdated: DateTime.now());
      await localDataSource.cacheCounter(newCounter);
      return Right(newCounter);
    } on CacheException catch (e) {
      AppLogger.error('Cache exception while resetting counter', e);
      return Left(CacheFailure(e.message));
    } catch (e) {
      AppLogger.error('Unknown exception while resetting counter', e);
      return const Left(UnknownFailure('Failed to reset counter'));
    }
  }

  @override
  Future<Either<Failure, CounterEntity>> setCounter(int value) async {
    try {
      AppLogger.debug('Setting counter to $value');
      final newCounter = CounterModel(
        value: value,
        lastUpdated: DateTime.now(),
      );
      await localDataSource.cacheCounter(newCounter);
      return Right(newCounter);
    } on CacheException catch (e) {
      AppLogger.error('Cache exception while setting counter', e);
      return Left(CacheFailure(e.message));
    } catch (e) {
      AppLogger.error('Unknown exception while setting counter', e);
      return const Left(UnknownFailure('Failed to set counter'));
    }
  }
}
