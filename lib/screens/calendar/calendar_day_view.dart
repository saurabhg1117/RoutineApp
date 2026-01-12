import 'package:flutter/material.dart';
import '../../utils/helpers.dart';

class CalendarDayView extends StatelessWidget {
  final DateTime selectedDay;

  const CalendarDayView({super.key, required this.selectedDay});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Helpers.formatDateForDisplay(selectedDay),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.checklist),
                    title: const Text('Routines'),
                    subtitle: const Text('View routines for this day'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.restaurant),
                    title: const Text('Meals'),
                    subtitle: const Text('View meals for this day'),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.water_drop),
                    title: const Text('Water Intake'),
                    subtitle: const Text('View water intake for this day'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

