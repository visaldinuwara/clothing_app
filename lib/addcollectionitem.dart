import 'package:flutter/material.dart';

class AddCollectionItem extends StatefulWidget {
  const AddCollectionItem({super.key});

  @override
  State<AddCollectionItem> createState() => _AddCollectionItemState();
}

class _AddCollectionItemState extends State<AddCollectionItem> {
  // 1. Create controllers to capture the data from each text field
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  @override
  void dispose() {
    // 2. Clean up controllers when the widget is closed to save phone memory
    _nameController.dispose();
    _imageUrlController.dispose();
    _colorController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _saveItem() {
    // 3. This is where you grab the final string values to send to your backend/database
    final String name = _nameController.text;
    final String imageUrl = _imageUrlController.text;
    final String color = _colorController.text;
    final String category = _categoryController.text;

    if (name.isEmpty || imageUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out Name and Image URL')),
      );
      return;
    }

    print('Saving Item: $name, $imageUrl, $color, $category');
    // Your save/POST request logic goes here!
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Collection Item')),
      // SingleChildScrollView protects your layout from keyboard overflow crashes
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Name Field
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Item Name',
                hintText: 'e.g., Vintage Denim Jacket',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.label),
              ),
            ),
            const SizedBox(height: 16),

            // Image URL Field
            TextField(
              controller: _imageUrlController,
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                labelText: 'Image URL',
                hintText: 'https://example.com/image.png',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.link),
              ),
            ),
            const SizedBox(height: 16),

            // Color Field
            TextField(
              controller: _colorController,
              decoration: const InputDecoration(
                labelText: 'Color',
                hintText: 'e.g., Indigo Blue',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.palette),
              ),
            ),
            const SizedBox(height: 16),

            // Category Field
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                labelText: 'Category',
                hintText: "e.g., Jackets, Men's Clothing",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
            ),
            const SizedBox(height: 32),

            // Save Outfit Button
            ElevatedButton(
              onPressed: _saveItem,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color(
                  0xFFFFFDD0,
                ), // Matching your premium cream color
                foregroundColor: Colors.black,
                side: const BorderSide(color: Colors.black, width: 1),
              ),
              child: const Text(
                'Save to Collection',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
