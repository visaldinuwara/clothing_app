import 'dart:io';
import 'package:flutter/material.dart';
import 'package:clothing_app/main.dart'; // Gives access to localDatabase
import 'package:clothing_app/collectionitem.dart'; // Gives access to CollectionItem class
import 'package:isar_community/isar.dart'; // Gives access to query builders like .filter()

class CasualShirts extends StatefulWidget {
  const CasualShirts({super.key});

  @override
  State<CasualShirts> createState() => _CasualShirtsState();
}

class _CasualShirtsState extends State<CasualShirts> {
  late Future<List<CollectionItem>> _shirtsFuture;

  @override
  void initState() {
    super.initState();
    _loadCasualShirts();
  }

  void _loadCasualShirts() {
    setState(() {
      _shirtsFuture = localDatabase.collectionItems
          .filter()
          .categoryEqualTo('Casual Shirts', caseSensitive: false)
          .findAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Casual Shirts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadCasualShirts,
          ),
        ],
      ),
      body: FutureBuilder<List<CollectionItem>>(
        future: _shirtsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error loading shirts: ${snapshot.error}'),
            );
          }

          final shirts = snapshot.data ?? [];

          if (shirts.isEmpty) {
            return const Center(
              child: Text(
                'No casual shirts found.\nAdd some in your collection form!',
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
            itemCount: shirts.length,
            itemBuilder: (context, index) {
              final shirt = shirts[index];

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
                      child: shirt.imageUrl.isNotEmpty
                          ? Image.file(
                              File(shirt.imageUrl),
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
                            shirt.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            shirt.color.isNotEmpty
                                ? shirt.color
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
