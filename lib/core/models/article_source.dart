class ArticleSource {
  const ArticleSource({
    this.id,
    required this.name,
  });

  factory ArticleSource.fromMap(Map<String, dynamic> map) {
    final String? id = map['id'] as String?;
    final String name = map['name'] as String;

    return ArticleSource(
      id: id,
      name: name,
    );
  }

  final String? id;
  final String name;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ArticleSource && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
