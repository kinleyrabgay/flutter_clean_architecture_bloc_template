/// Base exception class
class AppException implements Exception {
  const AppException([this.message = 'An unexpected error occurred']);

  final String message;

  @override
  String toString() => 'AppException: $message';
}

/// Server exception (API errors)
class ServerException extends AppException {
  const ServerException([super.message = 'Server error occurred']);

  @override
  String toString() => 'ServerException: $message';
}

/// Cache exception (Local storage errors)
class CacheException extends AppException {
  const CacheException([super.message = 'Cache error occurred']);

  @override
  String toString() => 'CacheException: $message';
}

/// Network exception (Connectivity issues)
class NetworkException extends AppException {
  const NetworkException([super.message = 'Network error occurred']);

  @override
  String toString() => 'NetworkException: $message';
}

/// Authentication exception
class AuthException extends AppException {
  const AuthException([super.message = 'Authentication failed']);

  @override
  String toString() => 'AuthException: $message';
}

/// Validation exception
class ValidationException extends AppException {
  const ValidationException([super.message = 'Validation failed']);

  @override
  String toString() => 'ValidationException: $message';
}
