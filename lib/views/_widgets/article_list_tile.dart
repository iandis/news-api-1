import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/models/article.dart';

class ArticleListTile extends StatelessWidget {
  const ArticleListTile({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: kMinInteractiveDimension,
        width: kMinInteractiveDimension,
        child: CachedNetworkImage(
          imageUrl: article.imageUrl,
        ),
      ),
      title: Text(article.title),
      subtitle: Text(article.author),
    );
  }
}
