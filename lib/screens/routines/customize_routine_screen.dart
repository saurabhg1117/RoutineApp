import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/routine_provider.dart';
import '../../models/routine_item.dart';
import '../../utils/helpers.dart';

class CustomizeRoutineScreen extends StatelessWidget {
  const CustomizeRoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customize Routines'),
      ),
      body: Consumer<RoutineProvider>(
        builder: (context, provider, _) {
          return ReorderableListView(
            padding: const EdgeInsets.all(16),
            onReorder: (oldIndex, newIndex) {
              // Reorder routines
            },
            children: provider.routines.map((routine) {
              return ListTile(
                key: ValueKey(routine.id),
                leading: Icon(Icons.drag_handle),
                title: Text(routine.name),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    provider.deleteRoutine(routine.id);
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

