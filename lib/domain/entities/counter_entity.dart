import 'package:equatable/equatable.dart';

/// Counter entity representing the domain model for counter functionality
class CounterEntity extends Equatable {
  const CounterEntity({required this.value, this.lastUpdated});

  final int value;
  final DateTime? lastUpdated;

  /// Creates a copy of this entity with updated values
  CounterEntity copyWith({int? value, DateTime? lastUpdated}) {
    return CounterEntity(
      value: value ?? this.value,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  List<Object?> get props => [value, lastUpdated];

  @override
  String toString() =>
      'CounterEntity(value: $value, lastUpdated: $lastUpdated)';
}
