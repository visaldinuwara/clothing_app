import 'package:clothing_app/marketfeedpage.dart';
import 'package:clothing_app/navigationtopmenu.dart';
import 'package:flutter/material.dart';
import 'package:clothing_app/customsearchbar.dart';

class NavigationBarTop extends StatefulWidget {
  const NavigationBarTop({super.key});

  @override
  State<NavigationBarTop> createState() => _NavigationBarTopState();
}

class _NavigationBarTopState extends State<NavigationBarTop> {
  String activeSearchQuery = "";
  String activeItemCategoryUrl = "men's clothing";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wardrobe')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const NavigationMenu(),
          CustomSearchBar(
            onSearchChanged: (liveText) {
              setState(() {
                activeSearchQuery = liveText;
              });
            },
          ),

          Expanded(
            child: MarketFeedPage(
              itemUrl: activeItemCategoryUrl,
              searchQuery: activeSearchQuery,
            ),
          ),
        ],
      ),
    );
  }
}
