class Tag {
  final String name;
  final String colorARGB;
  Tag({required this.name, required this.colorARGB});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "colorARGB": colorARGB,
    };
  }
}
