import 'package:flutter/material.dart';
import 'package:my_series_list/application/tags_provider.dart';
import 'package:provider/provider.dart';

class GridTags extends StatelessWidget {
  const GridTags({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TagsProvider>(
      builder: (context, tagsProvider, child) {
        return GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemCount: tagsProvider.listTags.length,
          itemBuilder: (_, index) {
            var tag = tagsProvider.listTags[index];
            return InkWell(
              onTap: () {},
              child: Card(
                child: Center(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(int.parse(tag.colorARGB)),
                    ),
                    title: Text(
                      tag.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
