import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
abstract class Failure extends Equatable {
  const Failure([this.message = 'An unexpected error occurred']);

  final String message;

  @override
  List<Object> get props => [message];
}

/// Server failure (API errors)
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error occurred']);
}

/// Cache failure (Local storage errors)
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error occurred']);
}

/// Network failure (Connectivity issues)
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network error occurred']);
}

/// Authentication failure
class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication failed']);
}

/// Validation failure
class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Validation failed']);
}

/// Unknown failure
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Unknown error occurred']);
}
