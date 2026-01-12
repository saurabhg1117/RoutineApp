import 'package:flutter/material.dart';

class CalendarWeekView extends StatelessWidget {
  final DateTime selectedDate;

  const CalendarWeekView({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Text(
        'Week View for ${selectedDate.toString()}',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

