import 'package:hive/hive.dart';

part 'progress_data.g.dart';

@HiveType(typeId: 9)
class ProgressData extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  int routinesCompleted;

  @HiveField(3)
  int totalRoutines;

  @HiveField(4)
  int mealsLogged;

  @HiveField(5)
  double waterIntake;

  @HiveField(6)
  double waterGoal;

  @HiveField(7)
  int selfCareCompleted;

  @HiveField(8)
  int totalSelfCare;

  @HiveField(9)
  double completionPercentage;

  @HiveField(10)
  DateTime createdAt;

  ProgressData({
    required this.id,
    required this.date,
    this.routinesCompleted = 0,
    this.totalRoutines = 0,
    this.mealsLogged = 0,
    this.waterIntake = 0.0,
    this.waterGoal = 0.0,
    this.selfCareCompleted = 0,
    this.totalSelfCare = 0,
    this.completionPercentage = 0.0,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'routinesCompleted': routinesCompleted,
      'totalRoutines': totalRoutines,
      'mealsLogged': mealsLogged,
      'waterIntake': waterIntake,
      'waterGoal': waterGoal,
      'selfCareCompleted': selfCareCompleted,
      'totalSelfCare': totalSelfCare,
      'completionPercentage': completionPercentage,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ProgressData.fromJson(Map<String, dynamic> json) {
    return ProgressData(
      id: json['id'],
      date: DateTime.parse(json['date']),
      routinesCompleted: json['routinesCompleted'] ?? 0,
      totalRoutines: json['totalRoutines'] ?? 0,
      mealsLogged: json['mealsLogged'] ?? 0,
      waterIntake: json['waterIntake']?.toDouble() ?? 0.0,
      waterGoal: json['waterGoal']?.toDouble() ?? 0.0,
      selfCareCompleted: json['selfCareCompleted'] ?? 0,
      totalSelfCare: json['totalSelfCare'] ?? 0,
      completionPercentage: json['completionPercentage']?.toDouble() ?? 0.0,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

