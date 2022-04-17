class Edition {
  String title;
  String? publishDate;
  List<String>? publishers;
  List<int>? coverIds;

  Edition({
    required this.title,
    this.publishDate,
    this.publishers,
    this.coverIds
  });
}