import '../../domain/entities/counter_entity.dart';

/// Counter model for data layer
/// Extends CounterEntity for data layer operations
class CounterModel extends CounterEntity {
  const CounterModel({required super.value, super.lastUpdated});

  /// Creates a CounterModel from JSON
  factory CounterModel.fromJson(Map<String, dynamic> json) {
    return CounterModel(
      value: json['value'] as int,
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'] as String)
          : null,
    );
  }

  /// Converts CounterModel to JSON
  Map<String, dynamic> toJson() {
    return {'value': value, 'lastUpdated': lastUpdated?.toIso8601String()};
  }

  /// Creates a CounterModel from CounterEntity
  factory CounterModel.fromEntity(CounterEntity entity) {
    return CounterModel(value: entity.value, lastUpdated: entity.lastUpdated);
  }

  /// Creates a copy with updated values
  @override
  CounterModel copyWith({int? value, DateTime? lastUpdated}) {
    return CounterModel(
      value: value ?? this.value,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
