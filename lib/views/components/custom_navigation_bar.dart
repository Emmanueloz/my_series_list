import 'package:flutter/material.dart';
import 'package:my_series_list/views/provider/navigator.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = Provider.of<NavigatorProvider>(context);

    return BottomNavigationBar(
      currentIndex: navigator.index,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.movie_outlined),
          activeIcon: Icon(Icons.movie),
          label: "Series",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          activeIcon: Icon(Icons.search),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          activeIcon: Icon(Icons.category),
          label: "Tags",
        ),
      ],
      onTap: navigator.setIndex,
    );
  }
}
