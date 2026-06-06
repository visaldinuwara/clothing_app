import 'dart:io';
import 'package:clothing_app/collectionitem.dart';
import 'package:clothing_app/main.dart';
import 'package:flutter/material.dart';
import 'package:isar_community/isar.dart';

class Sweaters extends StatefulWidget {
  const Sweaters({super.key});

  @override
  State<Sweaters> createState() => _SweaterState();
}

class _SweaterState extends State<Sweaters> {
  late Future<List<CollectionItem>> _sweaterFuture;

  @override
  void initState() {
    super.initState();
    _loadSweaters();
  }

  void _loadSweaters() {
    setState(() {
      _sweaterFuture = localDatabase.collectionItems
          .filter()
          .categoryEqualTo('Sweaters', caseSensitive: false)
          .findAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sweaters'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadSweaters),
        ],
      ),
      body: FutureBuilder<List<CollectionItem>>(
        future: _sweaterFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error loading sweaters: ${snapshot.error}'),
            );
          }

          final sweaters = snapshot.data ?? [];

          if (sweaters.isEmpty) {
            return const Center(
              child: Text(
                'No sweaters found.\nAdd some in your collection form!',
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
            itemCount: sweaters.length,
            itemBuilder: (context, index) {
              final sweater = sweaters[index];

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
                      child: sweater.imageUrl.isNotEmpty
                          ? Image.file(
                              File(sweater.imageUrl),
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
                            sweater.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            sweater.color.isNotEmpty
                                ? sweater.color
                                : 'No color set',
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
