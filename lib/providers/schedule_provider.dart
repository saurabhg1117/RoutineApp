import 'package:flutter/foundation.dart';
import '../models/schedule_item.dart';
import '../services/database_service.dart';
import '../utils/helpers.dart';

class ScheduleProvider with ChangeNotifier {
  final DatabaseService _db = DatabaseService.instance;
  List<ScheduleItem> _schedules = [];
  bool _isLoading = false;

  List<ScheduleItem> get schedules => _schedules;
  bool get isLoading => _isLoading;

  Future<void> loadSchedules() async {
    _isLoading = true;
    notifyListeners();

    try {
      _schedules = _db.scheduleBox.values.toList();
      _schedules.sort((a, b) => a.startTime.compareTo(b.startTime));
    } catch (e) {
      debugPrint('Error loading schedules: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addSchedule(ScheduleItem schedule) async {
    try {
      await _db.scheduleBox.put(schedule.id, schedule);
      _schedules.add(schedule);
      _schedules.sort((a, b) => a.startTime.compareTo(b.startTime));
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding schedule: $e');
    }
  }

  Future<void> updateSchedule(ScheduleItem schedule) async {
    try {
      await _db.scheduleBox.put(schedule.id, schedule);
      final index = _schedules.indexWhere((s) => s.id == schedule.id);
      if (index != -1) {
        _schedules[index] = schedule;
        _schedules.sort((a, b) => a.startTime.compareTo(b.startTime));
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating schedule: $e');
    }
  }

  Future<void> deleteSchedule(String id) async {
    try {
      await _db.scheduleBox.delete(id);
      _schedules.removeWhere((s) => s.id == id);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting schedule: $e');
    }
  }

  List<ScheduleItem> getSchedulesForDate(DateTime date) {
    return _schedules.where((s) => Helpers.isSameDay(s.date, date)).toList();
  }

  List<ScheduleItem> getJobSchedules() {
    return _schedules.where((s) => s.type == 'Job').toList();
  }

  List<ScheduleItem> getJobSchedulesForWeek() {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekEnd = weekStart.add(const Duration(days: 6));
    
    return _schedules.where((s) {
      if (s.type != 'Job') return false;
      return s.date.isAfter(weekStart.subtract(const Duration(days: 1))) &&
          s.date.isBefore(weekEnd.add(const Duration(days: 1)));
    }).toList();
  }

  List<ScheduleItem> getWeekendJobSchedules() {
    return _schedules.where((s) {
      return s.type == 'Job' && s.isWeekend;
    }).toList();
  }

  List<ScheduleItem> getStudySchedules() {
    return _schedules.where((s) => s.type == 'Study').toList();
  }
}

