import 'package:flutter/material.dart';

class CalendarMonthView extends StatelessWidget {
  final DateTime selectedDate;

  const CalendarMonthView({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Text(
        'Month View for ${selectedDate.toString()}',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

