import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:news_app/core/constants/app_apis.dart';
import 'package:news_app/core/models/article.dart';
import 'package:news_app/core/repositories/news_repo.dart';
import 'package:postor/http.dart';
import 'package:postor/postor.dart';

import 'news_repo_test.mocks.dart';

@GenerateMocks(<Type>[Postor])
void main() {
  GetIt.I.registerSingleton<Postor>(MockPostor());
  final Postor postor = GetIt.I<Postor>();
  final NewsRepository newsRepo = NewsRepository();
  group(
    'Test News Repo',
    () {
      setUpAll(() {
        when(postor.get(AppApis.getHeadlineEndpoint())).thenAnswer((_) {
          return Future<Response>.value(
            Response(_headlineResponse, 200),
          );
        });
      });
      test(
        'Verifiy `NewsRepository` is able to parse response for [getHeadline]',
        () {
          expectLater(
            newsRepo.getHeadline().then((List<Article> value) {
              expect(value, isA<List<Article>>());
              expect(value.length, equals(4));
            }),
            completes,
          );
        },
      );

      test(
        'Verifiy `NewsRepository` is able to parse response for [getLatest]',
        () {
          expectLater(
            newsRepo.getHeadline().then((List<Article> value) {
              expect(value, isA<List<Article>>());
              expect(value.length, equals(20));
            }),
            completes,
          );
        },
      );
    },
  );
}
