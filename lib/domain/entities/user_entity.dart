import 'package:equatable/equatable.dart';

/// User entity representing the domain model for user authentication
class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    this.avatarUrl,
    this.isEmailVerified = false,
    this.createdAt,
  });

  final String id;
  final String email;
  final String name;
  final String? avatarUrl;
  final bool isEmailVerified;
  final DateTime? createdAt;

  /// Creates a copy of this entity with updated values
  UserEntity copyWith({
    String? id,
    String? email,
    String? name,
    String? avatarUrl,
    bool? isEmailVerified,
    DateTime? createdAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    email,
    name,
    avatarUrl,
    isEmailVerified,
    createdAt,
  ];

  @override
  String toString() =>
      'UserEntity(id: $id, email: $email, name: $name, isEmailVerified: $isEmailVerified)';
}
