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

/// Top links — opens a full-screen page (replace [DetailPage] body with your UI).
class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  void _open(BuildContext context, String title) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => DetailPage(title: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: 4,
        runSpacing: 4,
        children: [
          TextButton(
            onPressed: () => _open(context, 'Collection'),
            child: const Text('Collection'),
          ),
          TextButton(
            onPressed: () => _open(context, 'Outfit'),
            child: const Text('Outfit'),
          ),
          TextButton(
            onPressed: () => _open(context, 'Calendar'),
            child: const Text('Calendar'),
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          'Replace this with your $title screen.',
          textAlign: TextAlign.center,
        ),
      ),
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
        title: const Text('My Wardrobe'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const NavigationMenu(),
          const SearchBar(),
          Expanded(
            child: WardrobeItems(),
          ),
        ],
      ),
    );
  }
}

class WardrobeItems extends StatefulWidget {
  const WardrobeItems({super.key});

  /// Each entry is a [Map] with string keys — not [List<String>].
  static const List<Map<String, String>> items = [
    {
      'imgUrl': 'lib/assets/images/cassualimg.png',
      'itemName': 'Casual Shirts',
    },
    {
      'imgUrl': 'lib/assets/images/denimjeans.png',
      'itemName': 'Denim Jeans',
    },
    {
      'imgUrl': 'lib/assets/images/coat.png',
      'itemName': 'Coats',
    },
    {
      'imgUrl': 'lib/assets/images/sweaters.png',
      'itemName': 'Sweaters',
    },
    {
      'imgUrl': 'lib/assets/images/shoes.png',
      'itemName': 'Shoes',
    },
    {
      'imgUrl': 'lib/assets/images/accessories.png',
      'itemName': 'Accessories',
    },
  ];

  @override
  State<WardrobeItems> createState() => _WardrobeItemsState();
}

class _WardrobeItemsState extends State<WardrobeItems> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: true,
      child: GridView.count(
        controller: _scrollController,
      crossAxisCount: 2,
      padding: const EdgeInsets.all(8),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 0.82,
      children: WardrobeItems.items.map((item) {
        final path = item['imgUrl']!;
        final title = item['itemName']!;
        return Card(
          key: ValueKey('$title|$path'),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.asset(
                  path,
                  key: ValueKey(path),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(Icons.broken_image_outlined),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Center(child: Text(title)),
              ),
            ],
          ),
        );
      }).toList(),
      ),
    );
  }
}

