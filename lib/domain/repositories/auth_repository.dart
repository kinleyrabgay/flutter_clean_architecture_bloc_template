import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/user_entity.dart';

/// Abstract repository for authentication operations
/// This defines the contract that must be implemented by the data layer
abstract class AuthRepository {
  /// Sign in with email and password
  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  });

  /// Sign up with email, password, and name
  Future<Either<Failure, UserEntity>> signUp({
    required String email,
    required String password,
    required String name,
  });

  /// Sign out the current user
  Future<Either<Failure, void>> signOut();

  /// Get the current authenticated user
  Future<Either<Failure, UserEntity?>> getCurrentUser();

  /// Check if user is currently authenticated
  Future<bool> isAuthenticated();

  /// Refresh authentication token
  Future<Either<Failure, String>> refreshToken();
}
