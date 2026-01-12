import 'package:flutter/material.dart';
import '../../models/self_care.dart';

class SkinCareScreen extends StatelessWidget {
  final SelfCare? skinCare;

  const SkinCareScreen({super.key, this.skinCare});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skin Care'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (skinCare != null)
            ...skinCare!.steps.map((step) {
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

