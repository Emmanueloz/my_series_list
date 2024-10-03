import 'package:flutter/material.dart';
import 'package:my_series_list/domain/tag.dart';
import 'package:my_series_list/views/components/list_series.dart';
import 'package:my_series_list/views/components/selected_chip_tag.dart';
import 'package:my_series_list/views/pages/layout.dart';

class SearchSeries extends StatefulWidget {
  const SearchSeries({super.key});

  @override
  State<SearchSeries> createState() => _SearchSeriesState();
}

class _SearchSeriesState extends State<SearchSeries> {
  final TextEditingController _controller = TextEditingController();
  List<Tag> selectTags = [];

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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutPage(
      appBar: AppBar(
        title: searchSeries(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectedChipTag(
              validator: () {
                return null;
              },
              isSelected: (tag) => selectTags.any((e) => e.id == tag.id),
              onTagChanged: (value, tag) {
                setState(() {
                  if (value) {
                    selectTags.add(tag);
                  } else {
                    selectTags.removeWhere((e) => e.id == tag.id);
                  }
                });
              },
            ),
            Expanded(
              child: ListSeries(listSeries: []),
            ),
          ],
        ),
      ),
      showNavigationBar: true,
    );
  }
}
