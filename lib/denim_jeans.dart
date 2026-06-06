import 'dart:io'; // Required for Image.file
import 'package:clothing_app/collectionitem.dart';
import 'package:clothing_app/main.dart';
import 'package:flutter/material.dart';
import 'package:isar_community/isar.dart';

class DenimJeans extends StatefulWidget {
  const DenimJeans({super.key});

  @override
  State<DenimJeans> createState() => _DenimJeansState();
}

class _DenimJeansState extends State<DenimJeans> {
  late Future<List<CollectionItem>> _jeansFuture;

  @override
  void initState() {
    super.initState();
    _loadDenimJeans();
  }

  void _loadDenimJeans() {
    setState(() {
      _jeansFuture = localDatabase.collectionItems
          .filter()
          .categoryEqualTo('Denim Jeans', caseSensitive: false)
          .findAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Denim Jeans'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadDenimJeans,
          ),
        ],
      ),
      body: FutureBuilder<List<CollectionItem>>(
        future: _jeansFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error loading jeans: ${snapshot.error}'),
            );
          }

          final jeans = snapshot.data ?? [];

          if (jeans.isEmpty) {
            return const Center(
              child: Text(
                'No denim jeans found.\nAdd some in your collection form!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: jeans.length,
            itemBuilder: (context, index) {
              final jean = jeans[index];

              return Card(
                clipBehavior: Clip.antiAlias,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: jean.imageUrl.isNotEmpty
                          ? Image.file(
                              File(jean.imageUrl),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.broken_image,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                            )
                          : const Icon(
                              Icons.checkroom,
                              size: 50,
                              color: Colors.grey,
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            jean.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            jean.color.isNotEmpty ? jean.color : 'No color set',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
