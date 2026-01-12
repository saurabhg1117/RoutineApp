import 'package:hive/hive.dart';

part 'calendar_event.g.dart';

@HiveType(typeId: 8)
class CalendarEvent extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String type;

  @HiveField(2)
  String title;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  DateTime? startTime;

  @HiveField(5)
  DateTime? endTime;

  @HiveField(6)
  int color;

  @HiveField(7)
  bool isCompleted;

  @HiveField(8)
  String? referenceId;

  CalendarEvent({
    required this.id,
    required this.type,
    required this.title,
    required this.date,
    this.startTime,
    this.endTime,
    required this.color,
    this.isCompleted = false,
    this.referenceId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'date': date.toIso8601String(),
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'color': color,
      'isCompleted': isCompleted,
      'referenceId': referenceId,
    };
  }

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      date: DateTime.parse(json['date']),
      startTime: json['startTime'] != null
          ? DateTime.parse(json['startTime'])
          : null,
      endTime: json['endTime'] != null
          ? DateTime.parse(json['endTime'])
          : null,
      color: json['color'],
      isCompleted: json['isCompleted'] ?? false,
      referenceId: json['referenceId'],
    );
  }
}

