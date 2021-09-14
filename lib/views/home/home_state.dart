import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/core/models/article.dart';
import 'package:news_app/core/repositories/base_news_repo.dart';
import 'package:postor/error_handler.dart' as eh;

class HomeState extends ChangeNotifier {
  HomeState({BaseNewsRepository? newsRepo}) : _newsRepo = newsRepo ?? GetIt.I<BaseNewsRepository>();

  final BaseNewsRepository _newsRepo;

  int _currentPage = 1;

  bool _isBusy = false;
  bool get isBusy => _isBusy;
  @protected
  set isBusy(bool newIsBusy) {
    if(newIsBusy == _isBusy) {
      return;
    }

    _isBusy = newIsBusy;
    notifyListeners();
  }

  List<Article> _headlines = <Article>[];
  List<Article> get headlines => _headlines;
  @protected
  set headlines(List<Article> newHeadlines) {
    if (listEquals(newHeadlines, _headlines)) {
      return;
    }

    _headlines = newHeadlines;
    notifyListeners();
  }

    List<Article> _latestNews = <Article>[];
  List<Article> get latestNews => _latestNews;
  @protected
  set latestNews(List<Article> newLatestNews) {
    if (listEquals(newLatestNews, _latestNews)) {
      return;
    }

    _latestNews = newLatestNews;
    notifyListeners();
  }

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  @protected
  set errorMessage(String? newErrorMessage) {
    if (newErrorMessage == _errorMessage) {
      return;
    }

    _errorMessage = newErrorMessage;
    notifyListeners();
  }

  Future<void> loadHeadline() async {
    try {
      final List<Article> newHeadlines = await _newsRepo.getHeadline();
      headlines = newHeadlines;
    } catch (e, st) {
      eh.catchIt(
        error: e,
        stackTrace: st,
        otherErrorMessage: 'Failed to fetch headlines',
        onCatch: _catchError,
      );
    }
  }

  Future<void> loadLatestNews({bool more = false}) async {
    if(_isBusy) {
      return;
    }

    isBusy = true;
    if(!more) {
      latestNews = const [];
    }

    try {
      final int nextPage = more ? _currentPage + 1 : 1;
      final List<Article> newLatestNews = await _newsRepo.getLatest(page: nextPage);
      latestNews = latestNews + newLatestNews;
      _currentPage = nextPage;
      isBusy = false;
    }catch(e, st) {
      eh.catchIt(
        error: e,
        stackTrace: st,
        otherErrorMessage: 'Failed to fetch latest news',
        onCatch: _catchError,
      );
    }
  }

  void _catchError(String message) {
    errorMessage = message;
  }
}
