import 'package:flutter/material.dart';
import '../../models/self_care.dart';
import '../../models/self_care_step.dart';
import '../../utils/helpers.dart';

class HairCareScreen extends StatelessWidget {
  final SelfCare? hairCare;

  const HairCareScreen({super.key, this.hairCare});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hair Care'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (hairCare != null)
            ...hairCare!.steps.map((step) {
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

