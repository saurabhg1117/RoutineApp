import 'package:hive/hive.dart';

part 'routine_item.g.dart';

@HiveType(typeId: 0)
class RoutineItem extends HiveObject {
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
  int priority;

  @HiveField(6)
  bool isCustom;

  @HiveField(7)
  DateTime? reminderTime;

  @HiveField(8)
  bool isCompleted;

  @HiveField(9)
  DateTime? completedAt;

  @HiveField(10)
  int streak;

  @HiveField(11)
  DateTime createdAt;

  @HiveField(12)
  DateTime updatedAt;

  RoutineItem({
    required this.id,
    required this.name,
    required this.category,
    this.icon,
    required this.color,
    this.priority = 0,
    this.isCustom = false,
    this.reminderTime,
    this.isCompleted = false,
    this.completedAt,
    this.streak = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  RoutineItem copyWith({
    String? id,
    String? name,
    String? category,
    String? icon,
    int? color,
    int? priority,
    bool? isCustom,
    DateTime? reminderTime,
    bool? isCompleted,
    DateTime? completedAt,
    int? streak,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RoutineItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      priority: priority ?? this.priority,
      isCustom: isCustom ?? this.isCustom,
      reminderTime: reminderTime ?? this.reminderTime,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      streak: streak ?? this.streak,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'icon': icon,
      'color': color,
      'priority': priority,
      'isCustom': isCustom,
      'reminderTime': reminderTime?.toIso8601String(),
      'isCompleted': isCompleted,
      'completedAt': completedAt?.toIso8601String(),
      'streak': streak,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory RoutineItem.fromJson(Map<String, dynamic> json) {
    return RoutineItem(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      icon: json['icon'],
      color: json['color'],
      priority: json['priority'] ?? 0,
      isCustom: json['isCustom'] ?? false,
      reminderTime: json['reminderTime'] != null
          ? DateTime.parse(json['reminderTime'])
          : null,
      isCompleted: json['isCompleted'] ?? false,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : null,
      streak: json['streak'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

