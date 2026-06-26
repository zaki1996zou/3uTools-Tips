class NewsArticle {
  const NewsArticle({
    required this.id,
    required this.category,
    required this.title,
    required this.summary,
    required this.date,
    required this.views,
    required this.url,
  });

  final String id;
  final String category;
  final String title;
  final String summary;
  final String date;
  final int views;
  final String url;
}
