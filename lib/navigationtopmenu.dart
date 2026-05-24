import 'package:clothing_app/app_routes.dart';
import 'package:flutter/material.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

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
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.collection);
            },
            child: const Text('Collection'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.outfit);
            },
            child: const Text('Outfit'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.calendar);
            },
            child: const Text('Calendar'),
          ),
        ],
      ),
    );
  }
}
