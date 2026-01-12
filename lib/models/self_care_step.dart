import 'package:hive/hive.dart';

part 'self_care_step.g.dart';

@HiveType(typeId: 5)
class SelfCareStep extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String? description;

  @HiveField(3)
  int order;

  @HiveField(4)
  bool isCompleted;

  @HiveField(5)
  DateTime? completedAt;

  SelfCareStep({
    required this.id,
    required this.name,
    this.description,
    required this.order,
    this.isCompleted = false,
    this.completedAt,
  });

  SelfCareStep copyWith({
    String? id,
    String? name,
    String? description,
    int? order,
    bool? isCompleted,
    DateTime? completedAt,
  }) {
    return SelfCareStep(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      order: order ?? this.order,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'order': order,
      'isCompleted': isCompleted,
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  factory SelfCareStep.fromJson(Map<String, dynamic> json) {
    return SelfCareStep(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      order: json['order'],
      isCompleted: json['isCompleted'] ?? false,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : null,
    );
  }
}

