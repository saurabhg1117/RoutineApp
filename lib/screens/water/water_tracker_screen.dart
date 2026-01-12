import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/water_provider.dart';
import '../../models/water_intake.dart';
import '../../utils/helpers.dart';
import '../../utils/constants.dart';

class WaterTrackerScreen extends StatelessWidget {
  const WaterTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WaterProvider>(context);
    final todayIntake = provider.getTodayWaterIntake();
    final progress = provider.getWaterProgress();
    final goal = provider.dailyGoal;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Intake'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _showGoalDialog(context, provider, goal);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Progress Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text(
                      'Today\'s Progress',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 24),
                    CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 12,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '${todayIntake.toStringAsFixed(0)} / ${goal.toStringAsFixed(0)} ml',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${(progress * 100).toStringAsFixed(0)}% Complete',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Quick Add Buttons
            Text(
              'Quick Add',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                _buildQuickAddButton(
                  context,
                  '250 ml',
                  '1 Glass',
                  () => _addWater(context, provider, 250),
                ),
                _buildQuickAddButton(
                  context,
                  '500 ml',
                  '2 Glasses',
                  () => _addWater(context, provider, 500),
                ),
                _buildQuickAddButton(
                  context,
                  '750 ml',
                  '3 Glasses',
                  () => _addWater(context, provider, 750),
                ),
                _buildQuickAddButton(
                  context,
                  'Custom',
                  'Custom Amount',
                  () => _showCustomAmountDialog(context, provider),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAddButton(
    BuildContext context,
    String amount,
    String label,
    VoidCallback onTap,
  ) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              amount,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  void _addWater(BuildContext context, WaterProvider provider, double amount) {
    final intake = WaterIntake(
      id: Helpers.generateId(),
      date: DateTime.now(),
      amount: amount,
      createdAt: DateTime.now(),
    );
    provider.addWaterIntake(intake);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Added ${amount.toStringAsFixed(0)} ml')),
    );
  }

  void _showCustomAmountDialog(
    BuildContext context,
    WaterProvider provider,
  ) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Custom Amount'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Amount (ml)',
            hintText: 'Enter amount in ml',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final amount = double.tryParse(controller.text);
              if (amount != null && amount > 0) {
                _addWater(context, provider, amount);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showGoalDialog(
    BuildContext context,
    WaterProvider provider,
    double currentGoal,
  ) {
    final controller = TextEditingController(text: currentGoal.toStringAsFixed(0));
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Set Daily Goal'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Daily Goal (ml)',
            hintText: 'Enter daily water goal',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final goal = double.tryParse(controller.text);
              if (goal != null && goal > 0) {
                provider.setDailyGoal(goal);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

