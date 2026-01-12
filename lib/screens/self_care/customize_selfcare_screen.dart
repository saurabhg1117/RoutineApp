import 'package:flutter/material.dart';
import '../../models/self_care.dart';
import '../../models/self_care_step.dart';
import '../../utils/helpers.dart';

class CustomizeSelfCareScreen extends StatelessWidget {
  final SelfCare selfCare;

  const CustomizeSelfCareScreen({super.key, required this.selfCare});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customize ${selfCare.name}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Add step
            },
          ),
        ],
      ),
      body: ReorderableListView(
        padding: const EdgeInsets.all(16),
        onReorder: (oldIndex, newIndex) {
          // Reorder steps
        },
        children: selfCare.steps.map((step) {
          return ListTile(
            key: ValueKey(step.id),
            leading: const Icon(Icons.drag_handle),
            title: Text(step.name),
            subtitle: step.description != null ? Text(step.description!) : null,
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                // Delete step
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

