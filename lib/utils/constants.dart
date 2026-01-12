class AppConstants {
  // Box names
  static const String routinesBox = 'routines';
  static const String mealsBox = 'meals';
  static const String waterBox = 'water';
  static const String selfCareBox = 'selfCare';
  static const String scheduleBox = 'schedule';
  static const String alarmsBox = 'alarms';
  static const String settingsBox = 'settings';
  static const String customMealTypesBox = 'customMealTypes';
  static const String customRoutineTemplatesBox = 'customRoutineTemplates';
  static const String calendarEventsBox = 'calendarEvents';
  static const String progressBox = 'progress';

  // Default values
  static const double defaultWaterGoal = 2000.0; // ml
  static const double defaultWaterAmount = 250.0; // ml per glass

  // Routine categories
  static const List<String> routineCategories = [
    'Morning',
    'Afternoon',
    'Evening',
    'Night',
    'Custom',
  ];

  // Meal types
  static const List<String> defaultMealTypes = [
    'Breakfast',
    'Lunch',
    'Snacks',
    'Dinner',
  ];

  // Self-care types
  static const List<String> selfCareTypes = [
    'Hair Care',
    'Skin Care',
    'Bath',
  ];

  // Schedule types
  static const List<String> scheduleTypes = [
    'Job',
    'Study',
    'Other',
  ];
}

