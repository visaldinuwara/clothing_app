import 'dart:io';
import 'package:clothing_app/collectionitem.dart';
import 'package:clothing_app/main.dart';
import 'package:flutter/material.dart';
import 'package:isar_community/isar.dart';

class Coats extends StatefulWidget {
  const Coats({super.key});

  @override
  State<Coats> createState() => _CoatsState();
}

class _CoatsState extends State<Coats> {
  late Future<List<CollectionItem>> _coatsFuture;

  @override
  void initState() {
    super.initState();
    _loadCoats();
  }

  void _loadCoats() {
    setState(() {
      _coatsFuture = localDatabase.collectionItems
          .filter()
          .categoryEqualTo('Coats', caseSensitive: false)
          .findAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coats'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadCoats),
        ],
      ),
      body: FutureBuilder<List<CollectionItem>>(
        future: _coatsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error loading coats: ${snapshot.error}'),
            );
          }

          final coats = snapshot.data ?? [];

          if (coats.isEmpty) {
            return const Center(
              child: Text(
                'No coats found.\nAdd some in your collection form!',
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
            itemCount: coats.length,
            itemBuilder: (context, index) {
              final coat = coats[index];

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
                      child: coat.imageUrl.isNotEmpty
                          ? Image.file(
                              File(coat.imageUrl),
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
                            coat.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            coat.color.isNotEmpty ? coat.color : 'No color set',
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
