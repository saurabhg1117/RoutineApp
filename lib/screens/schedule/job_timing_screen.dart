import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/schedule_provider.dart';
import '../../models/schedule_item.dart';
import '../../utils/helpers.dart';

class JobTimingScreen extends StatefulWidget {
  const JobTimingScreen({super.key});

  @override
  State<JobTimingScreen> createState() => _JobTimingScreenState();
}

class _JobTimingScreenState extends State<JobTimingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ScheduleProvider>(context, listen: false).loadSchedules();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Timing'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddJobDialog(context);
            },
          ),
        ],
      ),
      body: Consumer<ScheduleProvider>(
        builder: (context, provider, _) {
          final jobSchedules = provider.getJobSchedules();
          
          if (jobSchedules.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.work,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No job schedules',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: jobSchedules.length,
            itemBuilder: (context, index) {
              final schedule = jobSchedules[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: const Icon(Icons.work),
                  title: Text(schedule.title),
                  subtitle: Text(
                    '${Helpers.formatTime(schedule.startTime)} - ${Helpers.formatTime(schedule.endTime)}',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showAddJobDialog(BuildContext context) {
    // Implementation for adding job schedule
  }
}

