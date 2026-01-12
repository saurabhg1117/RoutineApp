import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = prefs.getBool('dark_mode') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Toggle dark theme'),
            value: _darkMode,
            onChanged: (value) async {
              setState(() {
                _darkMode = value;
              });
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('dark_mode', value);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Notifications'),
            subtitle: const Text('Manage notification settings'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to notification settings
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Backup & Restore'),
            subtitle: const Text('Backup or restore your data'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigate to backup settings
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Export Data'),
            subtitle: const Text('Export your data as JSON or CSV'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Export data
            },
          ),
        ],
      ),
    );
  }
}

