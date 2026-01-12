import 'package:hive/hive.dart';
import 'self_care_step.dart';

part 'self_care.g.dart';

@HiveType(typeId: 6)
class SelfCare extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String type;

  @HiveField(2)
  String name;

  @HiveField(3)
  List<SelfCareStep> steps;

  @HiveField(4)
  DateTime date;

  @HiveField(5)
  bool isCompleted;

  @HiveField(6)
  DateTime? completedAt;

  @HiveField(7)
  bool isTemplate;

  @HiveField(8)
  DateTime createdAt;

  @HiveField(9)
  DateTime updatedAt;

  SelfCare({
    required this.id,
    required this.type,
    required this.name,
    required this.steps,
    required this.date,
    this.isCompleted = false,
    this.completedAt,
    this.isTemplate = false,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'steps': steps.map((step) => step.toJson()).toList(),
      'date': date.toIso8601String(),
      'isCompleted': isCompleted,
      'completedAt': completedAt?.toIso8601String(),
      'isTemplate': isTemplate,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory SelfCare.fromJson(Map<String, dynamic> json) {
    return SelfCare(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      steps: (json['steps'] as List)
          .map((step) => SelfCareStep.fromJson(step))
          .toList(),
      date: DateTime.parse(json['date']),
      isCompleted: json['isCompleted'] ?? false,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : null,
      isTemplate: json['isTemplate'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

