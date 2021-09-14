import 'package:news_app/core/models/article_source.dart';

class Article {
  const Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.content,
    required this.publishedAt,
  });

  factory Article.fromMap(Map<String, dynamic> map) {
    final Map<dynamic, dynamic> rawSource = map['source'] as Map<dynamic, dynamic>;
    final ArticleSource source = ArticleSource.fromMap(rawSource as Map<String, dynamic>);
    return Article(
      source: source,
      author: map['author'] as String? ?? '',
      title: map['title'] as String,
      description: map['description'] as String? ?? '',
      url: map['url'] as String,
      imageUrl: map['urlToImage'] as String? ?? '',
      content: map['content'] as String? ?? '',
      publishedAt: DateTime.parse(map['publishedAt'] as String),
    );
  }

  final ArticleSource source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final DateTime publishedAt;
  final String content;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Article &&
        other.source == source &&
        other.author == author &&
        other.content == content &&
        other.description == description &&
        other.imageUrl == imageUrl &&
        other.publishedAt == publishedAt &&
        other.title == title &&
        other.url == url;
  }

  @override
  int get hashCode =>
      source.hashCode ^
      author.hashCode ^
      title.hashCode ^
      description.hashCode ^
      url.hashCode ^
      imageUrl.hashCode ^
      publishedAt.hashCode ^
      content.hashCode;
}
