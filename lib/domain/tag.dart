class Tag {
  int id;
  String name;
  String colorARGB;
  Tag({required this.id, required this.name, required this.colorARGB});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "colorARGB": colorARGB,
    };
  }
}
