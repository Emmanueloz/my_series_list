import 'package:my_series_list/domain/tag.dart';

class Series {
  int id;
  String name;
  String? description;
  List<Tag> tags;
  String? url;

  Series({
    required this.id,
    required this.name,
    this.description,
    required this.tags,
    this.url,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "tags": tags.map((e) => e.toJson()).toList(),
      "url": url,
    };
  }
}
