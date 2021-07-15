class Bookmarks{
  final String name;
  final String url;

  Bookmarks({
    required this.name,
    required this.url,
  });

}

List<Bookmarks> bookmarkList = <Bookmarks>[];

// Unique bookmarks
// List<Bookmarks> bookmarked = <Bookmarks>[];
// List bookmarkList = bookmarked.toSet().toList();