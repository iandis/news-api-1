import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/core/constants/app_apis.dart';
import 'package:news_app/core/repositories/base_news_repo.dart';
import 'package:news_app/core/repositories/news_repo.dart';
import 'package:news_app/views/home/home_screen.dart';
import 'package:postor/error_handler.dart';
import 'package:postor/postor.dart';

void main() {
  HttpOverrides.runWithHttpOverrides(
    () {
      GetIt.I.registerSingleton<Postor>(Postor(
        AppApis.baseUrl,
      ));
      GetIt.I.registerSingleton<BaseNewsRepository>(NewsRepository());
      initErrorMessages(defaultErrorMessageHandler);
      runApp(const MyApp());
    },
    MyHttpOverrides(),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
