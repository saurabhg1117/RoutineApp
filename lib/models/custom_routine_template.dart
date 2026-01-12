import 'package:hive/hive.dart';

part 'custom_routine_template.g.dart';

@HiveType(typeId: 1)
class CustomRoutineTemplate extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String category;

  @HiveField(3)
  String? icon;

  @HiveField(4)
  int color;

  @HiveField(5)
  DateTime? defaultReminderTime;

  @HiveField(6)
  DateTime createdAt;

  @HiveField(7)
  DateTime updatedAt;

  CustomRoutineTemplate({
    required this.id,
    required this.name,
    required this.category,
    this.icon,
    required this.color,
    this.defaultReminderTime,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'icon': icon,
      'color': color,
      'defaultReminderTime': defaultReminderTime?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory CustomRoutineTemplate.fromJson(Map<String, dynamic> json) {
    return CustomRoutineTemplate(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      icon: json['icon'],
      color: json['color'],
      defaultReminderTime: json['defaultReminderTime'] != null
          ? DateTime.parse(json['defaultReminderTime'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

