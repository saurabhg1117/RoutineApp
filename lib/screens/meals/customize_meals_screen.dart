import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/meal_provider.dart';
import '../../models/custom_meal_type.dart';
import '../../utils/helpers.dart';

class CustomizeMealsScreen extends StatelessWidget {
  const CustomizeMealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customize Meal Types'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddMealTypeDialog(context);
            },
          ),
        ],
      ),
      body: Consumer<MealProvider>(
        builder: (context, provider, _) {
          if (provider.customMealTypes.isEmpty) {
            return Center(
              child: Text(
                'No custom meal types',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.customMealTypes.length,
            itemBuilder: (context, index) {
              final mealType = provider.customMealTypes[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  title: Text(mealType.name),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      provider.deleteCustomMealType(mealType.id);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showAddMealTypeDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Custom Meal Type'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Meal Type Name',
            hintText: 'e.g., Brunch, Afternoon Tea',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                final provider = Provider.of<MealProvider>(context, listen: false);
                final mealType = CustomMealType(
                  id: Helpers.generateId(),
                  name: controller.text.trim(),
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                );
                provider.addCustomMealType(mealType);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

