import 'package:flutter/material.dart';
import '../services/reminder_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TimeOfDay? reminderTime;
  bool notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    ReminderService.initialize();
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: reminderTime ?? TimeOfDay.now(),
    );
    if (!mounted) return;
    if (time != null) {
      setState(() => reminderTime = time);
    }
  }

  Future<void> _scheduleReminder() async {
    if (reminderTime == null) return;

    final now = DateTime.now();
    final scheduled = DateTime(
      now.year,
      now.month,
      now.day,
      reminderTime!.hour,
      reminderTime!.minute,
    );

    await ReminderService.scheduleReminder(
      title: 'Daily Reminder',
      body: 'Hey! Don’t forget to check your tasks today 💪',
      scheduledTime: scheduled,
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reminder scheduled successfully!')),
    );
  }

  Future<void> _cancelReminders() async {
    await ReminderService.cancelAll();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All reminders cancelled')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            SwitchListTile(
              title: const Text('Enable Notifications'),
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() => notificationsEnabled = value);
                if (!value) _cancelReminders();
              },
            ),
            ListTile(
              title: const Text('Select Reminder Time'),
              subtitle: Text(
                reminderTime != null
                    ? reminderTime!.format(context)
                    : 'No time selected',
              ),
              trailing: const Icon(Icons.access_time),
              onTap: _pickTime,
            ),
            ElevatedButton.icon(
              onPressed: _scheduleReminder,
              icon: const Icon(Icons.notifications_active),
              label: const Text('Set Reminder'),
            ),
            const Divider(),
            ElevatedButton.icon(
              onPressed: _cancelReminders,
              icon: const Icon(Icons.cancel),
              label: const Text('Cancel All Reminders'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
