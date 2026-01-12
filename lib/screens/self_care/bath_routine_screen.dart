import 'package:flutter/material.dart';
import '../../models/self_care.dart';

class BathRoutineScreen extends StatelessWidget {
  final SelfCare? bathRoutine;

  const BathRoutineScreen({super.key, this.bathRoutine});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bath Routine'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (bathRoutine != null)
            ...bathRoutine!.steps.map((step) {
              return CheckboxListTile(
                title: Text(step.name),
                subtitle: step.description != null ? Text(step.description!) : null,
                value: step.isCompleted,
                onChanged: (value) {
                  // Update step completion
                },
              );
            }),
        ],
      ),
    );
  }
}

