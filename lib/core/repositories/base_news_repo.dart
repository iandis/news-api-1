
import 'package:news_app/core/models/article.dart';

abstract class BaseNewsRepository {

  Future<List<Article>> getHeadline();

  Future<List<Article>> getLatest({int page = 1});

  Future<List<Article>> search({required final String keyword, int page = 1});

  void cancelLastSearch();
}
