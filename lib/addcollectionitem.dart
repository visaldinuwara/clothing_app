import 'dart:io';
import 'package:clothing_app/collectionitem.dart';
import 'package:clothing_app/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart'
    as p; // Helpful for extracting file names easily

class AddCollectionItem extends StatefulWidget {
  const AddCollectionItem({super.key});

  @override
  State<AddCollectionItem> createState() => _AddCollectionItemState();
}

class _AddCollectionItemState extends State<AddCollectionItem> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  File? _selectedImage; // Holds the temporary file picked by the user
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _nameController.dispose();
    _colorController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  // Function to let user pick an image from Gallery
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _saveItem() async {
    final String name = _nameController.text.trim();
    final String color = _colorController.text.trim();
    final String category = _categoryController.text.trim();

    if (name.isEmpty || _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill out Name and select an Image'),
        ),
      );
      return;
    }

    try {
      // 1. Get the app's secure directory (just like in main.dart)
      final dir = await getApplicationDocumentsDirectory();

      // 2. Extract the original filename (e.g., "photo_123.jpg")
      String fileName = p.basename(_selectedImage!.path);

      // 3. Create a permanent target path inside our app folder
      String permanentPath = p.join(dir.path, fileName);
      // 4. Physically copy the image file to our permanent directory
      final File savedImage = await _selectedImage!.copy(permanentPath);

      // 5. Package up the data model item
      final newItem = CollectionItem()
        ..name = name
        ..imageUrl = savedImage
            .path // FIXED: Storing the local file path string directly inside imageUrl
        ..color = color
        ..category = category;

      // 6. Write transaction to Isar Database
      await localDatabase.writeTxn(() async {
        await localDatabase.collectionItems.put(newItem);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Saved to your collection successfully!'),
          ),
        );
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
            // IMAGE PREVIEW AREA
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: _selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(_selectedImage!, fit: BoxFit.cover),
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                          SizedBox(height: 8),
                          Text(
                            'Tap to select item photo',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 24),

            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Item Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.label),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _colorController,
              decoration: const InputDecoration(
                labelText: 'Color',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.palette),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                labelText: 'Category',
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
