import 'package:clothing_app/app_routes.dart';
import 'package:flutter/material.dart';

class WardrobeItems extends StatefulWidget {
  const WardrobeItems({super.key});

  static const List<Map<String, String>> items = [
    {
      'imgUrl': 'lib/assets/images/cassualimg.png',
      'itemName': 'Casual Shirts',
      'routeName': AppRoutes.casualshirts,
    },
    {
      'imgUrl': 'lib/assets/images/denimjeans.png',
      'itemName': 'Denim Jeans',
      'routeName': AppRoutes.denimjeans,
    },
    {
      'imgUrl': 'lib/assets/images/coat.png',
      'itemName': 'Coats',
      'routeName': AppRoutes.coats,
    },
    {
      'imgUrl': 'lib/assets/images/sweaters.png',
      'itemName': 'Sweaters',
      'routeName': AppRoutes.sweaters,
    },
    {
      'imgUrl': 'lib/assets/images/shoes.png',
      'itemName': 'Shoes',
      'routeName': AppRoutes.shoes,
    },
    {
      'imgUrl': 'lib/assets/images/accessories.png',
      'itemName': 'Accessories',
      'routeName': AppRoutes.accessories,
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
          final routeName = item['routeName']!;

          return Card(
            key: ValueKey('$title|$path|$routeName'),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(routeName);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.asset(
                      path,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                            child: Icon(Icons.broken_image_outlined),
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
