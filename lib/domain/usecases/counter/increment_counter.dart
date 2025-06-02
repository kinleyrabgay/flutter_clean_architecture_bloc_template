import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../entities/counter_entity.dart';
import '../../repositories/counter_repository.dart';
import '../usecase.dart';

/// Use case for incrementing the counter value
@injectable
class IncrementCounter implements UseCaseWithoutParams<CounterEntity> {
  final CounterRepository repository;

  IncrementCounter(this.repository);

  @override
  Future<Either<Failure, CounterEntity>> call() async {
    return await repository.incrementCounter();
  }
}
