import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_clean_architecture_bloc_template/core/error/failures.dart';
import 'package:flutter_clean_architecture_bloc_template/domain/entities/counter_entity.dart';
import 'package:flutter_clean_architecture_bloc_template/domain/usecases/counter/get_counter.dart';
import 'package:flutter_clean_architecture_bloc_template/domain/usecases/counter/increment_counter.dart';
import 'package:flutter_clean_architecture_bloc_template/domain/usecases/counter/decrement_counter.dart';
import 'package:flutter_clean_architecture_bloc_template/presentation/bloc/counter/counter_bloc.dart';

class MockGetCounter extends Mock implements GetCounter {}

class MockIncrementCounter extends Mock implements IncrementCounter {}

class MockDecrementCounter extends Mock implements DecrementCounter {}

void main() {
  late CounterBloc bloc;
  late MockGetCounter mockGetCounter;
  late MockIncrementCounter mockIncrementCounter;
  late MockDecrementCounter mockDecrementCounter;

  setUp(() {
    mockGetCounter = MockGetCounter();
    mockIncrementCounter = MockIncrementCounter();
    mockDecrementCounter = MockDecrementCounter();
    bloc = CounterBloc(
      mockGetCounter,
      mockIncrementCounter,
      mockDecrementCounter,
    );
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state should be CounterInitial', () {
    expect(bloc.state, CounterInitial());
  });

  group('CounterLoadRequested', () {
    const tCounterEntity = CounterEntity(value: 42);

    blocTest<CounterBloc, CounterState>(
      'should emit [CounterLoading, CounterLoaded] when data is gotten successfully',
      build: () {
        when(
          () => mockGetCounter(),
        ).thenAnswer((_) async => const Right(tCounterEntity));
        return bloc;
      },
      act: (bloc) => bloc.add(const CounterLoadRequested()),
      expect: () => [CounterLoading(), const CounterLoaded(tCounterEntity)],
      verify: (_) {
        verify(() => mockGetCounter());
      },
    );

    blocTest<CounterBloc, CounterState>(
      'should emit [CounterLoading, CounterError] when getting data fails',
      build: () {
        when(
          () => mockGetCounter(),
        ).thenAnswer((_) async => const Left(CacheFailure('Cache error')));
        return bloc;
      },
      act: (bloc) => bloc.add(const CounterLoadRequested()),
      expect: () => [CounterLoading(), const CounterError('Cache error')],
      verify: (_) {
        verify(() => mockGetCounter());
      },
    );
  });

  group('CounterIncrementRequested', () {
    const tCounterEntity = CounterEntity(value: 43);

    blocTest<CounterBloc, CounterState>(
      'should emit [CounterLoading, CounterLoaded] when increment is successful',
      build: () {
        when(
          () => mockIncrementCounter(),
        ).thenAnswer((_) async => const Right(tCounterEntity));
        return bloc;
      },
      act: (bloc) => bloc.add(const CounterIncrementRequested()),
      expect: () => [CounterLoading(), const CounterLoaded(tCounterEntity)],
      verify: (_) {
        verify(() => mockIncrementCounter());
      },
    );

    blocTest<CounterBloc, CounterState>(
      'should emit [CounterLoading, CounterError] when increment fails',
      build: () {
        when(
          () => mockIncrementCounter(),
        ).thenAnswer((_) async => const Left(CacheFailure('Cache error')));
        return bloc;
      },
      act: (bloc) => bloc.add(const CounterIncrementRequested()),
      expect: () => [CounterLoading(), const CounterError('Cache error')],
      verify: (_) {
        verify(() => mockIncrementCounter());
      },
    );
  });

  group('CounterDecrementRequested', () {
    const tCounterEntity = CounterEntity(value: 41);

    blocTest<CounterBloc, CounterState>(
      'should emit [CounterLoading, CounterLoaded] when decrement is successful',
      build: () {
        when(
          () => mockDecrementCounter(),
        ).thenAnswer((_) async => const Right(tCounterEntity));
        return bloc;
      },
      act: (bloc) => bloc.add(const CounterDecrementRequested()),
      expect: () => [CounterLoading(), const CounterLoaded(tCounterEntity)],
      verify: (_) {
        verify(() => mockDecrementCounter());
      },
    );

    blocTest<CounterBloc, CounterState>(
      'should emit [CounterLoading, CounterError] when decrement fails',
      build: () {
        when(
          () => mockDecrementCounter(),
        ).thenAnswer((_) async => const Left(CacheFailure('Cache error')));
        return bloc;
      },
      act: (bloc) => bloc.add(const CounterDecrementRequested()),
      expect: () => [CounterLoading(), const CounterError('Cache error')],
      verify: (_) {
        verify(() => mockDecrementCounter());
      },
    );
  });
}
