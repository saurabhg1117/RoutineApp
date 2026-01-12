import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/routine_provider.dart';
import '../../models/routine_item.dart';
import '../../utils/helpers.dart';
import '../../utils/constants.dart';

class AddEditRoutineScreen extends StatefulWidget {
  final RoutineItem? routine;

  const AddEditRoutineScreen({super.key, this.routine});

  @override
  State<AddEditRoutineScreen> createState() => _AddEditRoutineScreenState();
}

class _AddEditRoutineScreenState extends State<AddEditRoutineScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late String _category;
  late int _color;
  late int _priority;
  TimeOfDay? _reminderTime;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.routine?.name ?? '');
    _category = widget.routine?.category ?? AppConstants.routineCategories.first;
    _color = widget.routine?.color ?? 0xFF6750A4;
    _priority = widget.routine?.priority ?? 0;
    if (widget.routine?.reminderTime != null) {
      _reminderTime = TimeOfDay.fromDateTime(widget.routine!.reminderTime!);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _saveRoutine() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = Provider.of<RoutineProvider>(context, listen: false);
    final now = DateTime.now();

    final routine = RoutineItem(
      id: widget.routine?.id ?? Helpers.generateId(),
      name: _nameController.text.trim(),
      category: _category,
      color: _color,
      priority: _priority,
      isCustom: true,
      reminderTime: _reminderTime != null
          ? DateTime(
              now.year,
              now.month,
              now.day,
              _reminderTime!.hour,
              _reminderTime!.minute,
            )
          : null,
      createdAt: widget.routine?.createdAt ?? now,
      updatedAt: now,
    );

    if (widget.routine == null) {
      await provider.addRoutine(routine);
    } else {
      await provider.updateRoutine(routine);
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.routine == null ? 'Add Routine' : 'Edit Routine'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Routine Name',
                hintText: 'e.g., Wake Up, Sleep, Exercise',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a routine name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _category,
              decoration: const InputDecoration(
                labelText: 'Category',
              ),
              items: AppConstants.routineCategories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _category = value;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Reminder Time'),
              subtitle: Text(
                _reminderTime != null
                    ? _reminderTime!.format(context)
                    : 'No reminder',
              ),
              trailing: IconButton(
                icon: const Icon(Icons.access_time),
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: _reminderTime ?? TimeOfDay.now(),
                  );
                  if (time != null) {
                    setState(() {
                      _reminderTime = time;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveRoutine,
              child: Text(widget.routine == null ? 'Add Routine' : 'Update Routine'),
            ),
          ],
        ),
      ),
    );
  }
}

