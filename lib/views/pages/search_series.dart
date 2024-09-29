import 'package:flutter/material.dart';
import 'package:my_series_list/views/pages/layout.dart';

class SearchSeries extends StatelessWidget {
  const SearchSeries({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutPage(
      appBar: AppBar(
        title: const TextField(
          decoration: InputDecoration(
            hintText: "Search series",
          ),
        ),
      ),
      body: const Center(
        child: Text("Search series"),
      ),
      showNavigationBar: true,
    );
  }
}
