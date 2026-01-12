import 'package:flutter/foundation.dart';
import '../models/meal.dart';
import '../models/custom_meal_type.dart';
import '../services/database_service.dart';
import '../utils/helpers.dart';
import '../utils/constants.dart';

class MealProvider with ChangeNotifier {
  final DatabaseService _db = DatabaseService.instance;
  List<Meal> _meals = [];
  List<CustomMealType> _customMealTypes = [];
  bool _isLoading = false;

  List<Meal> get meals => _meals;
  List<CustomMealType> get customMealTypes => _customMealTypes;
  List<String> get allMealTypes {
    final defaultTypes = AppConstants.defaultMealTypes;
    final customTypes = _customMealTypes.map((e) => e.name).toList();
    return [...defaultTypes, ...customTypes];
  }

  bool get isLoading => _isLoading;

  Future<void> loadMeals() async {
    _isLoading = true;
    notifyListeners();

    try {
      _meals = _db.mealsBox.values.toList();
      _meals.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      _customMealTypes = _db.customMealTypesBox.values.toList();
    } catch (e) {
      debugPrint('Error loading meals: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addMeal(Meal meal) async {
    try {
      await _db.mealsBox.put(meal.id, meal);
      _meals.add(meal);
      _meals.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding meal: $e');
    }
  }

  Future<void> updateMeal(Meal meal) async {
    try {
      await _db.mealsBox.put(meal.id, meal);
      final index = _meals.indexWhere((m) => m.id == meal.id);
      if (index != -1) {
        _meals[index] = meal;
        _meals.sort((a, b) => a.dateTime.compareTo(b.dateTime));
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating meal: $e');
    }
  }

  Future<void> deleteMeal(String id) async {
    try {
      await _db.mealsBox.delete(id);
      _meals.removeWhere((m) => m.id == id);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting meal: $e');
    }
  }

  List<Meal> getMealsForDate(DateTime date) {
    return _meals.where((m) => Helpers.isSameDay(m.dateTime, date)).toList();
  }

  Future<void> addCustomMealType(CustomMealType mealType) async {
    try {
      await _db.customMealTypesBox.put(mealType.id, mealType);
      _customMealTypes.add(mealType);
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding custom meal type: $e');
    }
  }

  Future<void> deleteCustomMealType(String id) async {
    try {
      await _db.customMealTypesBox.delete(id);
      _customMealTypes.removeWhere((m) => m.id == id);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting custom meal type: $e');
    }
  }
}

