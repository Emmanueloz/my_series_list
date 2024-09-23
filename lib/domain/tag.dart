class Tag {
  int? id;
  String name;
  String colorARGB;
  Tag({this.id, required this.name, required this.colorARGB});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "colorARGB": colorARGB,
    };
  }

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json["id"],
      name: json["name"],
      colorARGB: json["colorARGB"],
    );
  }
}
