import 'package:flutter/material.dart';
import 'package:my_series_list/application/tags_provider.dart';
import 'package:my_series_list/domain/tag.dart';
import 'package:my_series_list/domain/tag_validator.dart';
import 'package:my_series_list/views/components/dialog_color_picker.dart';
import 'package:my_series_list/views/components/input_text.dart';
import 'package:provider/provider.dart';

class ModalFormTags extends StatefulWidget {
  final Tag? tag;
  const ModalFormTags({super.key, this.tag});

  @override
  State<ModalFormTags> createState() => _ModalFormTagsState();
}

class _ModalFormTagsState extends State<ModalFormTags> {
  late final TagsProvider _tagsProvider;

  final _formKey = GlobalKey<FormState>();

  final Tag _tag = Tag(id: 0, name: "", colorARGB: "0xffffffff");

  @override
  void initState() {
    super.initState();
    _tagsProvider = Provider.of<TagsProvider>(context, listen: false);

    if (widget.tag != null) {
      setState(() {
        _tag.id = widget.tag!.id;
        _tag.name = widget.tag!.name;
        _tag.colorARGB = widget.tag!.colorARGB;
      });
    }
  }

  void _onNameChanged(String value) {
    setState(() {
      _tag.name = value;
    });
  }

  void _onColorChanged(Color color) {
    setState(() {
      _tag.colorARGB = "0x${color.value.toRadixString(16)}";
    });
  }

  void _onSave(Tag tag) {
    if (widget.tag != null) {
      _tagsProvider.updateTag(tag);
    } else {
      _tagsProvider.addTag(tag);
    }
    Navigator.pop(context);
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
            "New tag",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InputText(
                  labelText: "Name",
                  onChanged: _onNameChanged,
                  value: _tag.name,
                  validator: (value) {
                    return TagValidator.isValidName(value);
                  },
                ),
                DialogColorPicker(
                  colorARGB: _tag.colorARGB,
                  onColorChanged: _onColorChanged,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _onSave(_tag);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
