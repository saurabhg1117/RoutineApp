import 'package:hive/hive.dart';

part 'meal.g.dart';

@HiveType(typeId: 2)
class Meal extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String type;

  @HiveField(2)
  DateTime dateTime;

  @HiveField(3)
  String? notes;

  @HiveField(4)
  bool isCustomType;

  @HiveField(5)
  DateTime createdAt;

  Meal({
    required this.id,
    required this.type,
    required this.dateTime,
    this.notes,
    this.isCustomType = false,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'dateTime': dateTime.toIso8601String(),
      'notes': notes,
      'isCustomType': isCustomType,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'],
      type: json['type'],
      dateTime: DateTime.parse(json['dateTime']),
      notes: json['notes'],
      isCustomType: json['isCustomType'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

