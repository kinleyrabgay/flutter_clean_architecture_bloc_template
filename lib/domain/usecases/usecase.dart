import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../core/error/failures.dart';

/// Base class for all use cases
/// Type [Type] - The return type
/// Type [Params] - The parameters type
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Use case that doesn't require parameters
abstract class UseCaseWithoutParams<Type> {
  Future<Either<Failure, Type>> call();
}

/// Use case that returns a stream
abstract class StreamUseCase<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}

/// No parameters class for use cases that don't need parameters
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
