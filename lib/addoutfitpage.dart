import 'package:clothing_app/newoutfit.dart';
import 'package:flutter/material.dart';

class NewOutfitScreen extends StatefulWidget {
  const NewOutfitScreen({super.key});

  @override
  State<NewOutfitScreen> createState() => _NewOutfitScreenState();
}

class _NewOutfitScreenState extends State<NewOutfitScreen> {
  final _nameController = TextEditingController();
  DateTime? _selectedDate;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      final args = ModalRoute.of(context)!.settings.arguments;
      _selectedDate = (args as DateTime?) ?? DateTime.now();

      _isInit = false;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _pickDate();
      });
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create New Outfit")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Outfit Name'),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  _selectedDate == null
                      ? 'No Date Chosen'
                      : 'Date: ${_selectedDate.toString().split(' ')[0]}',
                ),
                TextButton(
                  onPressed: () => _pickDate(),
                  child: const Text('Select Date'),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty && _selectedDate != null) {
                  final newOutfit = NewOutFit(
                    id: DateTime.now().toString(),
                    name: _nameController.text,
                    date: _selectedDate!,
                  );
                  print("Created: ${newOutfit.name} on ${newOutfit.date}");
                }
              },
              child: const Text('Save Outfit'),
            ),
          ],
        ),
      ),
    );
  }
}
