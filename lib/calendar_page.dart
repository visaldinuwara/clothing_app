import 'package:flutter/material.dart';

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
      // Fixed: Spelling corrected to SingleChildScrollView
      body: SingleChildScrollView( 
        child: Column(
          children: [
            CalendarDatePicker(
              initialDate: _selected,
              firstDate: DateTime(2020),
              lastDate: DateTime(2030, 12, 31),
              // Optional: Defines the starting view (days or years)
              initialCalendarMode: DatePickerMode.day, 
              onDateChanged: (value) {
                setState(() => _selected = value);
              },
            ),
            const SizedBox(height: 16),
            Text(
              'Selected: ${_selected.toIso8601String().split('T').first}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                print("Button pressed for date: $_selected");
              },
              child: const Text('Select Outfit'),
            ),
          ],
        ),
      ),
    );
  }
}