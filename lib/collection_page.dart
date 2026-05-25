import 'package:clothing_app/app_routes.dart';
import 'package:clothing_app/navigationtopmenu.dart';
import 'package:clothing_app/wardrobe_items.dart';
import 'package:flutter/material.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collection'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.addcollectionitem);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NavigationMenu(),
          Expanded(child: WardrobeItems()),
        ],
      ),
    );
  }
}
