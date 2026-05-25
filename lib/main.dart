import 'package:clothing_app/accessories.dart';
import 'package:clothing_app/addcollectionitem.dart';
import 'package:clothing_app/casual_shirts.dart';
import 'package:clothing_app/coats.dart';
import 'package:clothing_app/denim_jeans.dart';
import 'package:clothing_app/navigationbarontop.dart';
import 'package:clothing_app/outfitpage.dart';
import 'package:clothing_app/shoes.dart';
import 'package:clothing_app/sweaters.dart';
import 'package:flutter/material.dart';

import 'app_routes.dart';
import 'calendar_page.dart';
import 'collection_page.dart';

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
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (_) => const NavigationBarTop(),
        AppRoutes.collection: (_) => const CollectionPage(),
        AppRoutes.outfit: (_) => const OutfitPage(),
        AppRoutes.calendar: (_) => const CalendarPage(),
        AppRoutes.accessories: (_) => const Accessories(),
        AppRoutes.casualshirts: (_) => const CasualShirts(),
        AppRoutes.denimjeans: (_) => const DenimJeans(),
        AppRoutes.coats: (_) => const Coats(),
        AppRoutes.sweaters: (_) => const Sweaters(),
        AppRoutes.shoes: (_) => const Shoes(),
        AppRoutes.addcollectionitem: (_) => const AddCollectionItem(),
      },
    );
  }
}
