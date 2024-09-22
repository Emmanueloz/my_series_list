import 'package:flutter/material.dart';
import 'package:my_series_list/domain/tag.dart';
import 'package:my_series_list/views/sections/modal_form_tags.dart';

class TagsDetailsPage extends StatelessWidget {
  const TagsDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, Tag> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, Tag>;

    Widget showError(String error) {
      return Center(
        child: Text(error),
      );
    }

    Widget showInfo(Tag tag) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Color(int.parse(tag.colorARGB)),
          ),
          title: Text(
            tag.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: arguments["tag"] == null
          ? showError("Tag not found")
          : showInfo(arguments["tag"]!),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            scrollControlDisabledMaxHeightRatio: 0.9,
            builder: (context) {
              return ModalFormTags(tag: arguments["tag"]);
            },
          );
        },
      ),
    );
  }
}
