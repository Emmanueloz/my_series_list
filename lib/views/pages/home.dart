import 'package:flutter/material.dart';
import 'package:my_series_list/views/pages/series.dart';
import 'package:my_series_list/views/pages/tags.dart';
import 'package:my_series_list/views/sections/modal_form_series.dart';
import 'package:my_series_list/views/sections/modal_form_tags.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [const SeriesPage(), const TagsPage()];

  void _onBottomNavigationTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'My series' : "My tags"),
      ),
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            scrollControlDisabledMaxHeightRatio: 0.9,
            builder: (context) {
              if (_selectedIndex == 0) {
                return const ModalFormSeries();
              } else {
                return const ModalFormTags();
              }
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_outlined),
            activeIcon: Icon(Icons.movie),
            label: "Series",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            activeIcon: Icon(Icons.category),
            label: "Tags",
          ),
        ],
        onTap: _onBottomNavigationTap,
      ),
    );
  }
}
