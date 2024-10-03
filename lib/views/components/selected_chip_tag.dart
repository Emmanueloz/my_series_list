import 'package:flutter/material.dart';
import 'package:my_series_list/application/tags_provider.dart';
import 'package:my_series_list/domain/tag.dart';
import 'package:my_series_list/views/components/input_chip_tag.dart';
import 'package:provider/provider.dart';

class SelectedChipTag extends StatelessWidget {
  final String? Function() validator;
  final bool Function(Tag tag) isSelected;
  final void Function(bool, Tag) onTagChanged;
  const SelectedChipTag({
    super.key,
    required this.validator,
    required this.isSelected,
    required this.onTagChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TagsProvider>(
      builder: (context, tagsProvider, child) {
        tagsProvider.getTags();
        return FormField<List<Tag>>(
          validator: (value) {
            return validator();
          },
          builder: (field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (tagsProvider.listTags.isEmpty)
                  const Text(
                    "No tags found",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                Wrap(
                  spacing: 4,
                  children: tagsProvider.listTags
                      .map(
                        (tag) => InputChipTag(
                          tag: tag,
                          selected: isSelected(tag),
                          onSelected: (value) {
                            onTagChanged(value, tag);
                          },
                        ),
                      )
                      .toList(),
                ),
                if (field.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      field.errorText ?? '', //
                      style: const TextStyle(
                        color: Color.fromARGB(255, 221, 166, 163),
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
