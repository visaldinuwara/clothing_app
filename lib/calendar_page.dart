import 'package:clothing_app/app_routes.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            CalendarDatePicker(
              initialDate: _selected,
              firstDate: DateTime(2020),
              lastDate: DateTime(2030, 12, 31),
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
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.collection);
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFFFFDD0), // Cream color
                side: const BorderSide(color: Colors.black, width: 1),
              ),
              child: const Text(
                'Select Outfit',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
