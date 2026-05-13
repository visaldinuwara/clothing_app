import 'package:flutter/material.dart';

class OutfitPage extends StatelessWidget {
  const OutfitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Outfit')),
      body: const Center(
        child: Text('Your outfit UI goes here.'),
      ),
    );
  }
}
