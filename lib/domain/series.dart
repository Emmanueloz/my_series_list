import 'package:my_series_list/domain/tag.dart';

class Series {
  int? id;
  String name;
  String? description;
  List<Tag> tags;
  String? url;

  Series({
    this.id,
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

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      tags: json["tags"].map((e) => Tag.fromJson(e)).toList(),
      url: json["url"],
    );
  }
}
