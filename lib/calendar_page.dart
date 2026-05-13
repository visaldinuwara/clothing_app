import 'package:flutter/material.dart';

/// Uses Material [CalendarDatePicker] — no extra packages.
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selected = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar')),
      body: Column(
        children: [
          CalendarDatePicker(
            initialDate: _selected,
            firstDate: DateTime(2020),
            lastDate: DateTime(2030, 12, 31),
            onDateChanged: (value) {
              setState(() => _selected = value);
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Selected: ${_selected.toIso8601String().split('T').first}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
