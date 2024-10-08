import 'package:flutter/material.dart';
import 'package:my_series_list/application/tags_provider.dart';
import 'package:my_series_list/views/components/card_tag.dart';
import 'package:my_series_list/views/pages/layout.dart';
import 'package:my_series_list/views/sections/modal_form_tags.dart';
import 'package:provider/provider.dart';

class TagsPage extends StatefulWidget {
  const TagsPage({super.key});

  @override
  State<TagsPage> createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  late final TagsProvider _tagsProvider;

  @override
  void initState() {
    super.initState();
    _tagsProvider = Provider.of<TagsProvider>(context, listen: false);
    _tagsProvider.getTags();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutPage(
      appBar: AppBar(
        title: const Text("My Tags"),
      ),
      body: Consumer<TagsProvider>(builder: (context, tagsProvider, child) {
        if (tagsProvider.listTags.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("No tags found"),
                SizedBox(height: 10),
                Text("Add a new tag"),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: tagsProvider.listTags.length,
          itemBuilder: (context, index) {
            return CardTag(tag: tagsProvider.listTags[index]);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            scrollControlDisabledMaxHeightRatio: 0.9,
            builder: (context) => const ModalFormTags(),
          );
        },
      ),
      showNavigationBar: true,
    );
  }
}
