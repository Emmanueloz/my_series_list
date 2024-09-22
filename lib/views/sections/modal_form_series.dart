import 'package:flutter/material.dart';
import 'package:my_series_list/application/series_provider.dart';
import 'package:my_series_list/application/tags_provider.dart';
import 'package:my_series_list/domain/serie_validator.dart';
import 'package:my_series_list/domain/series.dart';
import 'package:my_series_list/domain/tag.dart';
import 'package:my_series_list/views/components/input_chip_tag.dart';

import 'package:my_series_list/views/components/input_text.dart';
import 'package:provider/provider.dart';

class ModalFormSeries extends StatefulWidget {
  final Series? serie;
  const ModalFormSeries({
    super.key,
    this.serie,
  });

  @override
  State<ModalFormSeries> createState() => _ModalFormSeriesState();
}

class _ModalFormSeriesState extends State<ModalFormSeries> {
  late final TagsProvider _tagsProvider;
  late final SeriesProvider _seriesProvider;

  final _formKey = GlobalKey<FormState>();

  Series _serie = Series(
    id: 0,
    name: "",
    tags: [],
    url: "",
    description: "",
  );

  @override
  void initState() {
    super.initState();

    _tagsProvider = Provider.of<TagsProvider>(context, listen: false);
    _seriesProvider = Provider.of<SeriesProvider>(context, listen: false);

    _tagsProvider.getTags();

    if (widget.serie != null) {
      _setSerie(widget.serie!);
    }
  }

  void _setSerie(Series serie) {
    setState(() {
      _serie = serie;
    });
  }

  void _onNameChanged(String value) {
    setState(() {
      _serie.name = value;
    });
  }

  void _onDescriptionChanged(String value) {
    setState(() {
      _serie.description = value;
    });
  }

  void _onUrlChanged(String value) {
    setState(() {
      _serie.url = value;
    });
  }

  void _onTagChanged(bool isSelected, Tag tag) {
    setState(() {
      if (isSelected) {
        _serie.tags.add(tag);
      } else {
        _serie.tags.remove(tag);
      }
    });
  }

  void _onSave(Series serie) {
    if (widget.serie != null) {
      _seriesProvider.updateSeries(serie);
    } else {
      _seriesProvider.addSeries(serie);
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
            "New serie",
            style: TextStyle(fontSize: 20),
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InputText(
                  labelText: "Name",
                  onChanged: _onNameChanged,
                  value: _serie.name,
                  validator: (value) {
                    return SerieValidator.isValidName(value);
                  },
                ),
                InputText(
                  labelText: "Description",
                  keyboardType: TextInputType.multiline,
                  onChanged: _onDescriptionChanged,
                  value: _serie.description,
                  validator: (value) {
                    return SerieValidator.isValidDescription(value);
                  },
                ),
                InputText(
                  labelText: "URL",
                  keyboardType: TextInputType.url,
                  onChanged: _onUrlChanged,
                  value: _serie.url,
                  validator: (value) {
                    return SerieValidator.isValidUrl(value);
                  },
                ),
                Consumer<TagsProvider>(
                  builder: (context, tagsProvider, child) {
                    return FormField<List<Tag>>(
                      validator: (value) {
                        return SerieValidator.isValidTags(_serie.tags);
                      },
                      builder: (field) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 4,
                              children: tagsProvider.listTags
                                  .map(
                                    (tag) => InputChipTag(
                                      tag: tag,
                                      selected: _serie.tags.contains(tag),
                                      onSelected: (value) {
                                        _onTagChanged(value, tag);
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
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _onSave(_serie);
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
