import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../utils/helpers.dart';

class MealCard extends StatelessWidget {
  final Meal meal;

  const MealCard({
    super.key,
    required this.meal,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.restaurant),
        title: Text(meal.type),
        subtitle: Text(Helpers.formatDateTime(meal.dateTime)),
        trailing: meal.notes != null ? const Icon(Icons.note) : null,
      ),
    );
  }
}

