import 'package:flutter/material.dart';

class OutfitPage extends StatelessWidget {
  const OutfitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> outfits = [
      {'name': 'Casual Denim Pack', 'type': 'Shirt + Jeans'},
      {'name': 'Summer Classic', 'type': 'Linen Shirt'},
      {'name': 'Streetwear V1', 'type': 'Oversized Tee'},
      {'name': 'Formal Attire', 'type': 'Blazer Pack'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Select Outfit'), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: outfits.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            final item = outfits[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.checkroom,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name']!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['type']!,
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
        ),
      ),
    );
  }
}
