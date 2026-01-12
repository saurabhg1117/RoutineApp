import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/routine_item.dart';
import 'notification_service.dart';

class AlarmService {
  static final AlarmService _instance = AlarmService._();
  static AlarmService get instance => _instance;

  AlarmService._();

  final NotificationService _notificationService = NotificationService.instance;

  Future<void> setAlarmForRoutine(RoutineItem routine) async {
    if (routine.reminderTime == null) return;

    await _notificationService.scheduleNotification(
      id: routine.id.hashCode,
      title: 'Routine Reminder',
      body: 'Time for ${routine.name}',
      scheduledDate: routine.reminderTime!,
    );
  }

  Future<void> cancelAlarmForRoutine(String routineId) async {
    await _notificationService.cancelNotification(routineId.hashCode);
  }
}

