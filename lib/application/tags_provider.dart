import 'package:flutter/material.dart';
import 'package:my_series_list/domain/tag.dart';
import 'package:my_series_list/domain/tag_repository.dart';

class TagsProvider with ChangeNotifier {
  final ITagRepository _repository;

  List<Tag> listTags = [];

  TagsProvider({required ITagRepository repository}) : _repository = repository;

  Future<void> init() async {
    await _repository.init();
  }

  Future<void> getTags() async {
    listTags = await _repository.getTags();
    notifyListeners();
  }

  Future<void> addTag(Tag tag) async {
    await _repository.addTag(tag);
    listTags = await _repository.getTags();
    notifyListeners();
  }

  Future<void> deleteTag(Tag tag) async {
    await _repository.deleteTag(tag);
    listTags = await _repository.getTags();
    notifyListeners();
  }

  Future<void> updateTag(Tag tag) async {
    await _repository.updateTag(tag);
    listTags = await _repository.getTags();
    notifyListeners();
  }
}
