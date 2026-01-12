import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/database_service.dart';
import '../models/routine_item.dart';
import '../models/meal.dart';
import '../models/water_intake.dart';

class SyncService {
  static final SyncService _instance = SyncService._();
  static SyncService get instance => _instance;

  SyncService._();

  final DatabaseService _db = DatabaseService.instance;

  Future<String> exportData() async {
    final data = {
      'routines': _db.routinesBox.values.map((r) => r.toJson()).toList(),
      'meals': _db.mealsBox.values.map((m) => m.toJson()).toList(),
      'water': _db.waterBox.values.map((w) => w.toJson()).toList(),
      'exportDate': DateTime.now().toIso8601String(),
    };

    return jsonEncode(data);
  }

  Future<void> importData(String jsonData) async {
    try {
      final data = jsonDecode(jsonData) as Map<String, dynamic>;

      if (data.containsKey('routines')) {
        final routines = (data['routines'] as List)
            .map((r) => RoutineItem.fromJson(r))
            .toList();
        for (final routine in routines) {
          await _db.routinesBox.put(routine.id, routine);
        }
      }

      if (data.containsKey('meals')) {
        final meals = (data['meals'] as List)
            .map((m) => Meal.fromJson(m))
            .toList();
        for (final meal in meals) {
          await _db.mealsBox.put(meal.id, meal);
        }
      }

      if (data.containsKey('water')) {
        final water = (data['water'] as List)
            .map((w) => WaterIntake.fromJson(w))
            .toList();
        for (final intake in water) {
          await _db.waterBox.put(intake.id, intake);
        }
      }
    } catch (e) {
      throw Exception('Failed to import data: $e');
    }
  }
}

