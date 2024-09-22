import 'package:my_series_list/domain/tag.dart';

abstract class ITagRepository {
  Future<void> init();
  Future<List<Tag>> getTags();
  Future<void> addTag(Tag tag);
  Future<void> deleteTag(Tag tag);
  Future<void> updateTag(Tag tag);
}

class MemoryTagRepository implements ITagRepository {
  final List<Tag> _tags = [];

  @override
  Future<void> init() async {
    if (_tags.isNotEmpty) return;

    _tags.add(Tag(id: 1, name: "horror", colorARGB: "0xfffa5252"));
    _tags.add(Tag(id: 2, name: "drama", colorARGB: "0xff099268"));
    _tags.add(Tag(id: 3, name: "thriller", colorARGB: "0xfff08c00"));
  }

  @override
  Future<List<Tag>> getTags() async {
    return _tags;
  }

  @override
  Future<void> addTag(Tag tag) async {
    _tags.add(tag);
  }

  @override
  Future<void> deleteTag(Tag tag) async {
    _tags.remove(tag);
  }

  @override
  Future<void> updateTag(Tag tag) async {
    List<Tag> newTags = _tags.map((t) => t.id == tag.id ? tag : t).toList();

    _tags.clear();
    _tags.addAll(newTags);
  }
}
