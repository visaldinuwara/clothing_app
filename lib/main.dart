import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const NavigationBarTop(),
    );
  }
}

/// Menu labels only (no [Scaffold] — the screen owns one scaffold).
class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text('My Wardrobe'),
        Text('Collection'),
        Text('Outfit'),
        Text('Calendar'),
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: const InputDecoration(
          hintText: 'Search…',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

/// One [MaterialApp] → one root screen → one [Scaffold]. Body stacks menu row, then search.
class NavigationBarTop extends StatelessWidget {
  const NavigationBarTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My app'),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NavigationMenu(),
          SearchBar(),
          WardrobeItems(),
        ],
      ),
    );
  }
}

class WardrobeItems extends StatelessWidget {
  const WardrobeItems({super.key});

  static const List<String> _labels = [
    'Casual Shirts',
    'Denim Jeans',
    'Coats',
    'Sweaters',
    'Shoes',
    'Accessories',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: _labels
          .map((item) => Card(child: Center(child: Text(item))))
          .toList(),
    );
  }
}