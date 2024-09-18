class Series {
  final int id;
  final String name;
  final String? description;
  final List<String> tags;
  final String? url;

  Series({
    required this.id,
    required this.name,
    this.description,
    required this.tags,
    this.url,
  });
}
