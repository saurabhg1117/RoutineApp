import 'package:hive/hive.dart';

part 'schedule_item.g.dart';

@HiveType(typeId: 7)
class ScheduleItem extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String type;

  @HiveField(2)
  String title;

  @HiveField(3)
  DateTime startTime;

  @HiveField(4)
  DateTime endTime;

  @HiveField(5)
  DateTime date;

  @HiveField(6)
  String? notes;

  @HiveField(7)
  bool hasReminder;

  @HiveField(8)
  DateTime? reminderTime;

  @HiveField(9)
  DateTime createdAt;

  @HiveField(10)
  DateTime updatedAt;

  @HiveField(11)
  bool isOptional;

  ScheduleItem({
    required this.id,
    required this.type,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.date,
    this.notes,
    this.hasReminder = false,
    this.reminderTime,
    required this.createdAt,
    required this.updatedAt,
    this.isOptional = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'date': date.toIso8601String(),
      'notes': notes,
      'hasReminder': hasReminder,
      'reminderTime': reminderTime?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isOptional': isOptional,
    };
  }

  factory ScheduleItem.fromJson(Map<String, dynamic> json) {
    return ScheduleItem(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      date: DateTime.parse(json['date']),
      notes: json['notes'],
      hasReminder: json['hasReminder'] ?? false,
      reminderTime: json['reminderTime'] != null
          ? DateTime.parse(json['reminderTime'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      isOptional: json['isOptional'] ?? false,
    );
  }

  bool get isWeekend {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }
}

