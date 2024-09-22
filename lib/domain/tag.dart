class Tag {
  final int id;
  final String name;
  final String colorARGB;
  Tag({required this.id, required this.name, required this.colorARGB});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "colorARGB": colorARGB,
    };
  }
}
