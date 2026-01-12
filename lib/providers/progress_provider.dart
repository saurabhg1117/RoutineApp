import 'package:flutter/foundation.dart';
import '../models/progress_data.dart';
import '../services/database_service.dart';
import '../utils/helpers.dart';
import 'routine_provider.dart';
import 'meal_provider.dart';
import 'water_provider.dart';

class ProgressProvider with ChangeNotifier {
  final DatabaseService _db = DatabaseService.instance;
  List<ProgressData> _progressData = [];
  bool _isLoading = false;

  List<ProgressData> get progressData => _progressData;
  bool get isLoading => _isLoading;

  Future<void> loadProgressData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _progressData = _db.progressBox.values.toList();
      _progressData.sort((a, b) => a.date.compareTo(b.date));
    } catch (e) {
      debugPrint('Error loading progress data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> calculateProgressForDate(
    DateTime date,
    RoutineProvider routineProvider,
    MealProvider mealProvider,
    WaterProvider waterProvider,
  ) async {
    try {
      final dateStr = Helpers.formatDate(date);
      final existing = _progressData.firstWhere(
        (p) => Helpers.isSameDay(p.date, date),
        orElse: () => ProgressData(
          id: dateStr,
          date: date,
          createdAt: DateTime.now(),
        ),
      );

      final routines = routineProvider.getRoutinesForDate(date);
      final meals = mealProvider.getMealsForDate(date);
      final waterIntake = waterProvider.getWaterIntakeForDate(date);
      final waterGoal = waterProvider.dailyGoal;

      existing.routinesCompleted = routines.length;
      existing.totalRoutines = routineProvider.routines.length;
      existing.mealsLogged = meals.length;
      existing.waterIntake = waterIntake;
      existing.waterGoal = waterGoal;

      final total = existing.totalRoutines + existing.mealsLogged;
      existing.completionPercentage =
          total > 0 ? (existing.routinesCompleted / total) * 100 : 0.0;

      await _db.progressBox.put(existing.id, existing);
      final index = _progressData.indexWhere((p) => p.id == existing.id);
      if (index != -1) {
        _progressData[index] = existing;
      } else {
        _progressData.add(existing);
      }

      _progressData.sort((a, b) => a.date.compareTo(b.date));
      notifyListeners();
    } catch (e) {
      debugPrint('Error calculating progress: $e');
    }
  }

  ProgressData? getProgressForDate(DateTime date) {
    try {
      return _progressData.firstWhere(
        (p) => Helpers.isSameDay(p.date, date),
      );
    } catch (e) {
      return null;
    }
  }

  List<ProgressData> getProgressForWeek(DateTime date) {
    final weekStart = date.subtract(Duration(days: date.weekday - 1));
    final weekDays = List.generate(7, (i) => weekStart.add(Duration(days: i)));
    return weekDays
        .map((day) => getProgressForDate(day))
        .whereType<ProgressData>()
        .toList();
  }

  List<ProgressData> getProgressForMonth(DateTime date) {
    final monthStart = DateTime(date.year, date.month, 1);
    final monthEnd = DateTime(date.year, date.month + 1, 0);
    return _progressData
        .where((p) =>
            p.date.isAfter(monthStart.subtract(const Duration(days: 1))) &&
            p.date.isBefore(monthEnd.add(const Duration(days: 1))))
        .toList();
  }
}

