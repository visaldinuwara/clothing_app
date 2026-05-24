import 'package:clothing_app/navigationtopmenu.dart';
import 'package:clothing_app/wardrobe_items.dart';
import 'package:flutter/material.dart';

/// One [MaterialApp] → one root screen → one [Scaffold]. Body stacks menu row, then search.
class NavigationBarTop extends StatelessWidget {
  const NavigationBarTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wardrobe')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const NavigationMenu(),
          const SearchBar(),
          Expanded(child: WardrobeItems()),
        ],
      ),
    );
  }
}
