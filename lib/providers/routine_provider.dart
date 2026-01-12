import 'package:flutter/foundation.dart';
import '../models/routine_item.dart';
import '../services/database_service.dart';
import '../utils/helpers.dart';

class RoutineProvider with ChangeNotifier {
  final DatabaseService _db = DatabaseService.instance;
  List<RoutineItem> _routines = [];
  bool _isLoading = false;

  List<RoutineItem> get routines => _routines;
  bool get isLoading => _isLoading;

  Future<void> loadRoutines() async {
    _isLoading = true;
    notifyListeners();

    try {
      _routines = _db.routinesBox.values.toList();
      _routines.sort((a, b) => a.priority.compareTo(b.priority));
    } catch (e) {
      debugPrint('Error loading routines: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addRoutine(RoutineItem routine) async {
    try {
      await _db.routinesBox.put(routine.id, routine);
      _routines.add(routine);
      _routines.sort((a, b) => a.priority.compareTo(b.priority));
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding routine: $e');
    }
  }

  Future<void> updateRoutine(RoutineItem routine) async {
    try {
      await _db.routinesBox.put(routine.id, routine);
      final index = _routines.indexWhere((r) => r.id == routine.id);
      if (index != -1) {
        _routines[index] = routine;
        _routines.sort((a, b) => a.priority.compareTo(b.priority));
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating routine: $e');
    }
  }

  Future<void> deleteRoutine(String id) async {
    try {
      await _db.routinesBox.delete(id);
      _routines.removeWhere((r) => r.id == id);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting routine: $e');
    }
  }

  Future<void> toggleRoutineCompletion(String id) async {
    try {
      final routine = _routines.firstWhere((r) => r.id == id);
      final now = DateTime.now();
      final today = Helpers.getStartOfDay(now);
      final lastCompleted = routine.completedAt != null
          ? Helpers.getStartOfDay(routine.completedAt!)
          : null;

      if (routine.isCompleted && lastCompleted == today) {
        // Uncomplete
        routine.isCompleted = false;
        routine.completedAt = null;
      } else {
        // Complete
        routine.isCompleted = true;
        routine.completedAt = now;

        // Update streak
        if (lastCompleted != null) {
          final daysDiff = today.difference(lastCompleted).inDays;
          if (daysDiff == 1) {
            routine.streak++;
          } else if (daysDiff > 1) {
            routine.streak = 1;
          }
        } else {
          routine.streak = 1;
        }
      }

      routine.updatedAt = now;
      await updateRoutine(routine);
    } catch (e) {
      debugPrint('Error toggling routine completion: $e');
    }
  }

  List<RoutineItem> getRoutinesForDate(DateTime date) {
    return _routines.where((r) {
      if (r.completedAt == null) return false;
      return Helpers.isSameDay(r.completedAt!, date);
    }).toList();
  }

  List<RoutineItem> getPendingRoutines() {
    final today = Helpers.getStartOfDay(DateTime.now());
    return _routines.where((r) {
      if (r.isCompleted && r.completedAt != null) {
        return !Helpers.isSameDay(r.completedAt!, today);
      }
      return true;
    }).toList();
  }
}

