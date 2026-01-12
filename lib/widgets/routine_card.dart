import 'package:flutter/material.dart';
import '../models/routine_item.dart';
import '../providers/routine_provider.dart';
import 'package:provider/provider.dart';

class RoutineCard extends StatelessWidget {
  final RoutineItem routine;

  const RoutineCard({
    super.key,
    required this.routine,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RoutineProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(routine.color).withOpacity(0.2),
          child: Icon(
            routine.icon != null ? IconData(int.parse(routine.icon!), fontFamily: 'MaterialIcons') : Icons.check_circle,
            color: Color(routine.color),
          ),
        ),
        title: Text(routine.name),
        subtitle: Text(routine.category),
        trailing: Checkbox(
          value: routine.isCompleted,
          onChanged: (value) {
            provider.toggleRoutineCompletion(routine.id);
          },
        ),
        onTap: () {
          // Navigate to routine detail
        },
      ),
    );
  }
}

