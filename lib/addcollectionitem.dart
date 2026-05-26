import 'package:clothing_app/collectionitem.dart';
import 'package:flutter/material.dart';
import 'package:clothing_app/main.dart';

class AddCollectionItem extends StatefulWidget {
  const AddCollectionItem({super.key});

  @override
  State<AddCollectionItem> createState() => _AddCollectionItemState();
}

class _AddCollectionItemState extends State<AddCollectionItem> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _imageUrlController.dispose();
    _colorController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _saveItem() async {
    final String name = _nameController.text.trim();
    final String imageUrl = _imageUrlController.text.trim();
    final String color = _colorController.text.trim();
    final String category = _categoryController.text.trim();

    // Simple validation check
    if (name.isEmpty || imageUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out Name and Image URL')),
      );
      return;
    }

    // 1. Create a new instance of your CollectionItem object and map the values
    final newItem = CollectionItem()
      ..name = name
      ..imageUrl = imageUrl
      ..color = color
      ..category = category;

    try {
      // 2. Open a secure write transaction thread to push data safely to phone disk
      // 2. Open a secure write transaction thread to push data safely to phone disk
      await localDatabase.writeTxn(() async {
        // FIXED: Change localDatabase.CollectionItemSchema.put(newItem);
        // TO THIS:
        await localDatabase.collectionItems.put(newItem);
      });

      // 3. Show a success notification alert to the user

      // 3. Show a success notification alert to the user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Saved to your collection box successfully!'),
          ),
        );
        // 4. Automatically close the "Add" page and go back to the wardrobe page
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Database Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Collection Item')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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

            ElevatedButton(
              onPressed: _saveItem,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color(0xFFFFFDD0),
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
