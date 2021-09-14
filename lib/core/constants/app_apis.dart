
class AppApis {
  static const String apiKey = '5f00d331dfd24c32a3e34d70cae204b6';
  static const String baseUrl = 'https://newsapi.org';

  static String getHeadlineEndpoint({int page = 1}) {
    return '/v2/top-headlines?country=id&page=$page&apiKey=$apiKey';
  }

  static String getSearchEndpoint({required final String keyword, int page = 1}) {
    return '/v2/everything?q=$keyword&page=$page&apiKey=$apiKey';
  }

}
