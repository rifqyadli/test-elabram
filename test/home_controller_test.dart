import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:newsapps/components/url.dart';
import 'package:newsapps/controllers/homeController.dart';
import 'package:newsapps/model/top_hot_line_model/article.dart';
import 'package:newsapps/services.dart';

class TestingService extends Mock implements Services {}

void main() {
  late HomeController sut;
  late TestingService testingService;

  setUp(() {
    sut = HomeController();
    testingService = TestingService();
  });

  test("inital values are correct", () {
    expect(sut.article, []);
    expect(sut.newArticle, []);
    expect(sut.isLoading, false);
  });

  group('getTopHeadLines', () {
    test("get hotline articles", () async {
      final future = sut.getTopHeadLines();

      await future;
      expect(sut.article, isNot([]));
    });

    test("get news articles", () async {
      final future = sut.getNews();

      await future;
      expect(sut.newArticle, isNot([]));
    });

    test('first init function', () async {
      final future = sut.firstInit();
      expect(sut.isLoading, true);
      await future;
      expect(sut.isLoading, false);
    });
  });
}
