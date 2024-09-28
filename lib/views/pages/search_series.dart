import 'package:flutter/material.dart';

class SearchSeries extends StatelessWidget {
  const SearchSeries({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search series"),
      ),
      body: const Center(
        child: Text("Search series"),
      ),
    );
  }
}
