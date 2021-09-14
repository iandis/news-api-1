import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/core/constants/app_apis.dart';
import 'package:news_app/core/models/article.dart';
import 'package:news_app/core/repositories/base_news_repo.dart';
import 'package:postor/postor.dart';

typedef _JsonMap = Map<String, dynamic>;

class NewsRepository implements BaseNewsRepository {
  NewsRepository({Postor? postor}) : _postor = postor ?? GetIt.I<Postor>();

  final Postor _postor;

  String? lastSearchUrl;

  @protected
  Future<List<Article>> getArticles({int page = 1, int? howMany}) async {
    final String headlineEndpoint = AppApis.getHeadlineEndpoint();
    final _JsonMap rawResponse = await _postor.get(headlineEndpoint).get<_JsonMap>();
    final List<dynamic> rawArticles = rawResponse['articles'] as List<dynamic>;

    if (howMany != null) {
      return List<Article>.generate(howMany, (int index) {
        final Map<dynamic, dynamic> rawArticle = rawArticles[index] as Map<dynamic, dynamic>;
        return Article.fromMap(rawArticle as Map<String, dynamic>);
      });
    }

    return rawArticles.map<Article>(
      (dynamic rawArticle) {
        return Article.fromMap(rawArticle as Map<String, dynamic>);
      },
    ).toList();
  }

  @override
  Future<List<Article>> getHeadline() {
    return getArticles(howMany: 4);
  }

  @override
  Future<List<Article>> getLatest({int page = 1}) {
    return getArticles(page: page);
  }

  @override
  Future<List<Article>> search({required String keyword, int page = 1}) async {
    final String searchEndpoint = AppApis.getSearchEndpoint(keyword: keyword, page: page);
    final String requestUrl = Uri.parse(AppApis.baseUrl + searchEndpoint).toString();
    
    lastSearchUrl = requestUrl;

    final _JsonMap rawResponse = await _postor
        .get(
          searchEndpoint,
        )
        .get<_JsonMap>()
        .whenComplete(
      () {
        lastSearchUrl = null;
      },
    );

    final List<dynamic> rawArticles = rawResponse['articles'] as List<dynamic>;

    return rawArticles.map<Article>(
      (dynamic rawArticle) {
        return Article.fromMap(rawArticle as Map<String, dynamic>);
      },
    ).toList();
  }

  @override
  void cancelLastSearch() {
    if(lastSearchUrl != null) {
      _postor.cancel(lastSearchUrl!);
    }
  }
}
