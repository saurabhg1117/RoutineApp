import 'package:flutter/foundation.dart';
import '../models/water_intake.dart';
import '../services/database_service.dart';
import '../utils/helpers.dart';
import '../utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaterProvider with ChangeNotifier {
  final DatabaseService _db = DatabaseService.instance;
  List<WaterIntake> _waterIntakes = [];
  double _dailyGoal = AppConstants.defaultWaterGoal;
  bool _isLoading = false;

  List<WaterIntake> get waterIntakes => _waterIntakes;
  double get dailyGoal => _dailyGoal;
  bool get isLoading => _isLoading;

  Future<void> loadWaterData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _waterIntakes = _db.waterBox.values.toList();
      _waterIntakes.sort((a, b) => a.date.compareTo(b.date));

      final prefs = await SharedPreferences.getInstance();
      _dailyGoal = prefs.getDouble('water_goal') ?? AppConstants.defaultWaterGoal;
    } catch (e) {
      debugPrint('Error loading water data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> setDailyGoal(double goal) async {
    _dailyGoal = goal;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('water_goal', goal);
    notifyListeners();
  }

  Future<void> addWaterIntake(WaterIntake intake) async {
    try {
      await _db.waterBox.put(intake.id, intake);
      _waterIntakes.add(intake);
      _waterIntakes.sort((a, b) => a.date.compareTo(b.date));
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding water intake: $e');
    }
  }

  Future<void> deleteWaterIntake(String id) async {
    try {
      await _db.waterBox.delete(id);
      _waterIntakes.removeWhere((w) => w.id == id);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting water intake: $e');
    }
  }

  double getWaterIntakeForDate(DateTime date) {
    return _waterIntakes
        .where((w) => Helpers.isSameDay(w.date, date))
        .fold(0.0, (sum, intake) => sum + intake.amount);
  }

  double getTodayWaterIntake() {
    return getWaterIntakeForDate(DateTime.now());
  }

  double getWaterProgress() {
    if (_dailyGoal == 0) return 0.0;
    final todayIntake = getTodayWaterIntake();
    return (todayIntake / _dailyGoal).clamp(0.0, 1.0);
  }
}

