import 'package:flutter/material.dart';
import 'package:my_series_list/application/tags_provider.dart';
import 'package:my_series_list/domain/tag.dart';
import 'package:provider/provider.dart';

class SelectTag extends StatelessWidget {
  final String labelText;
  final Tag? value;
  final void Function(Tag?)? onChanged;
  const SelectTag({
    super.key,
    required this.labelText,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Consumer<TagsProvider>(
        builder: (context, tagsProvider, child) {
          tagsProvider.getTags();
          return DropdownButton<Tag>(
            value: value ?? tagsProvider.listTags[0],
            style: const TextStyle(fontSize: 18),
            items: tagsProvider.listTags
                .map((tag) => DropdownMenuItem(
                      value: tag,
                      child: Text(tag.name),
                    ))
                .toList(),
            onChanged: onChanged,
          );
        },
      ),
    );
  }
}
