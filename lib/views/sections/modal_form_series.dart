import 'package:flutter/material.dart';
import 'package:my_series_list/application/tags_provider.dart';
import 'package:my_series_list/domain/tag.dart';
import 'package:my_series_list/views/components/input_chip_tag.dart';

import 'package:my_series_list/views/components/input_text.dart';
import 'package:provider/provider.dart';

class ModalFormSeries extends StatefulWidget {
  const ModalFormSeries({
    super.key,
  });

  @override
  State<ModalFormSeries> createState() => _ModalFormSeriesState();
}

class _ModalFormSeriesState extends State<ModalFormSeries> {
  late final TagsProvider _tagsProvider;

  String name = "";
  String description = "";
  String url = "";
  List<Tag> selectedTags = [];

  @override
  void initState() {
    super.initState();
    print("modal de tags");
    _tagsProvider = Provider.of<TagsProvider>(context, listen: false);

    _tagsProvider.getTags();
  }

  void _onNameChanged(String value) {
    setState(() {
      name = value;
    });
  }

  void _onDescriptionChanged(String value) {
    setState(() {
      description = value;
    });
  }

  void _onUrlChanged(String value) {
    setState(() {
      url = value;
    });
  }

  void _onTagChanged(bool isSelected, Tag tag) {
    setState(() {
      if (isSelected) {
        selectedTags.add(tag);
      } else {
        selectedTags.remove(tag);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "New serie",
            style: TextStyle(fontSize: 20),
          ),
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InputText(
                  labelText: "Name",
                  onChanged: _onNameChanged,
                ),
                InputText(
                  labelText: "Description",
                  keyboardType: TextInputType.multiline,
                  onChanged: _onDescriptionChanged,
                ),
                InputText(
                  labelText: "URL",
                  keyboardType: TextInputType.url,
                  onChanged: _onUrlChanged,
                ),
                Consumer<TagsProvider>(
                  builder: (context, tagsProvider, child) {
                    return Wrap(
                      spacing: 4,
                      children: tagsProvider.listTags
                          .map(
                            (tag) => InputChipTag(
                              tag: tag,
                              selected: selectedTags.contains(tag),
                              onSelected: (value) {
                                _onTagChanged(value, tag);
                              },
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    print(name);
                    print(description);
                    print(url);
                    print(selectedTags);
                    //Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child:
                      const Text("Save", style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
