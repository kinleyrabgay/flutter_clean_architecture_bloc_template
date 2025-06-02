import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_clean_architecture_bloc_template/core/error/failures.dart';
import 'package:flutter_clean_architecture_bloc_template/domain/entities/counter_entity.dart';
import 'package:flutter_clean_architecture_bloc_template/domain/repositories/counter_repository.dart';
import 'package:flutter_clean_architecture_bloc_template/domain/usecases/counter/get_counter.dart';

class MockCounterRepository extends Mock implements CounterRepository {}

void main() {
  late GetCounter usecase;
  late MockCounterRepository mockCounterRepository;

  setUp(() {
    mockCounterRepository = MockCounterRepository();
    usecase = GetCounter(mockCounterRepository);
  });

  const tCounterEntity = CounterEntity(value: 42);

  test('should get counter from the repository', () async {
    // arrange
    when(
      () => mockCounterRepository.getCounter(),
    ).thenAnswer((_) async => const Right(tCounterEntity));

    // act
    final result = await usecase();

    // assert
    expect(result, const Right(tCounterEntity));
    verify(() => mockCounterRepository.getCounter());
    verifyNoMoreInteractions(mockCounterRepository);
  });

  test('should return failure when repository fails', () async {
    // arrange
    const tFailure = CacheFailure('Cache error');
    when(
      () => mockCounterRepository.getCounter(),
    ).thenAnswer((_) async => const Left(tFailure));

    // act
    final result = await usecase();

    // assert
    expect(result, const Left(tFailure));
    verify(() => mockCounterRepository.getCounter());
    verifyNoMoreInteractions(mockCounterRepository);
  });
}
