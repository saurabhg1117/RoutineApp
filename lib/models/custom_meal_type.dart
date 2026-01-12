import 'package:hive/hive.dart';

part 'custom_meal_type.g.dart';

@HiveType(typeId: 3)
class CustomMealType extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  DateTime? defaultTime;

  @HiveField(3)
  bool hasReminder;

  @HiveField(4)
  DateTime createdAt;

  @HiveField(5)
  DateTime updatedAt;

  CustomMealType({
    required this.id,
    required this.name,
    this.defaultTime,
    this.hasReminder = false,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'defaultTime': defaultTime?.toIso8601String(),
      'hasReminder': hasReminder,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory CustomMealType.fromJson(Map<String, dynamic> json) {
    return CustomMealType(
      id: json['id'],
      name: json['name'],
      defaultTime: json['defaultTime'] != null
          ? DateTime.parse(json['defaultTime'])
          : null,
      hasReminder: json['hasReminder'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

