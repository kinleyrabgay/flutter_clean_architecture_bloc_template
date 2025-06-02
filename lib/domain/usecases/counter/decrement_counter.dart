import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../core/error/failures.dart';
import '../../entities/counter_entity.dart';
import '../../repositories/counter_repository.dart';
import '../usecase.dart';

/// Use case for decrementing the counter value
@injectable
class DecrementCounter implements UseCaseWithoutParams<CounterEntity> {
  final CounterRepository repository;

  DecrementCounter(this.repository);

  @override
  Future<Either<Failure, CounterEntity>> call() async {
    return await repository.decrementCounter();
  }
}
