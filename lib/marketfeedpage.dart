import 'dart:convert';
import 'package:clothing_app/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MarketFeedPage extends StatefulWidget {
  const MarketFeedPage({
    super.key,
    required this.itemUrl,
    required this.searchQuery, // FIXED: Added 'this.' to assign the incoming search string
  });

  final String itemUrl;
  final String
  searchQuery; // FIXED: Declared the property so the State block can read it

  @override
  State<MarketFeedPage> createState() => _MarketFeedPageState();
}

class _MarketFeedPageState extends State<MarketFeedPage> {
  // Store the active network request in memory to prevent infinite layout re-fetch loops
  late Future<List<Product>> _marketFetchFuture;

  @override
  void initState() {
    super.initState();
    _marketFetchFuture = fetchMarketClothes();
  }

  @override
  void didUpdateWidget(covariant MarketFeedPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Automatically re-fetch the data ONLY if the category or search string changes!
    if (oldWidget.itemUrl != widget.itemUrl ||
        oldWidget.searchQuery != widget.searchQuery) {
      setState(() {
        _marketFetchFuture = fetchMarketClothes();
      });
    }
  }

  Future<List<Product>> fetchMarketClothes() async {
    // FIXED: Cleaned up the URL path construction so it creates a valid endpoint address
    final cleanUrlSegment = Uri.encodeComponent(widget.itemUrl);
    final url = Uri.parse(
      'https://fakestoreapi.com/products/category/$cleanUrlSegment',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Product> products = body
          .map((item) => Product.fromJson(item))
          .toList();

      // Client-side text filter: Checks if the user has typed anything into the search box
      if (widget.searchQuery.isNotEmpty) {
        return products
            .where(
              (product) => product.title.toLowerCase().contains(
                widget.searchQuery.toLowerCase(),
              ),
            )
            .toList();
      }

      return products;
    } else {
      throw Exception(
        'Failed to load market items (Status: ${response.statusCode})',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Pro-tip: Remove the inner Scaffold AppBar if your parent layout already has one!
      body: FutureBuilder<List<Product>>(
        future:
            _marketFetchFuture, // FIXED: Pointing to memory instead of calling the function directly
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final products = snapshot.data!;

          if (products.isEmpty) {
            return const Center(child: Text('No matching outfits found.'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.75,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final item = products[index];
              return Card(
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          item.imageUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
                      child: Text(
                        '\$${item.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
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
