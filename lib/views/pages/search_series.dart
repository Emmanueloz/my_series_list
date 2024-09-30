import 'package:flutter/material.dart';
import 'package:my_series_list/views/components/grid_tags.dart';
import 'package:my_series_list/views/pages/layout.dart';

class SearchSeries extends StatefulWidget {
  const SearchSeries({super.key});

  @override
  State<SearchSeries> createState() => _SearchSeriesState();
}

class _SearchSeriesState extends State<SearchSeries> {
  final TextEditingController _controller = TextEditingController();
  bool _showResult = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void setShowResult(bool value) {
    setState(() {
      _showResult = value;
    });
  }

  Widget searchSeries(BuildContext context) {
    return TextField(
      style: const TextStyle(
        color: Colors.white,
      ),
      controller: _controller,
      decoration: const InputDecoration(
        icon: Icon(Icons.search),
        hintText: "Search series",
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      onChanged: (value) {
        _controller.text = value;
      },
      onSubmitted: (value) {
        print(value);
        setShowResult(true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutPage(
      appBar: AppBar(
        title: searchSeries(context),
      ),
      body:
          _showResult ? const Center(child: Text("Result")) : const GridTags(),
      showNavigationBar: true,
    );
  }
}
