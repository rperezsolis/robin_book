class Author {
  String key;
  String name;
  String? wikipediaUrl;
  String? bio;
  List<int>? photoIds;

  Author({
    required this.key,
    required this.name,
    this.wikipediaUrl,
    this.bio,
    this.photoIds
  });
}