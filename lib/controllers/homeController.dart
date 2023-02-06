import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapps/components/theme.dart';
import 'package:newsapps/components/url.dart';
import 'package:newsapps/model/news_model/article.dart';
import 'package:newsapps/model/news_model/news_model.dart';
import 'package:newsapps/model/top_hot_line_model/article.dart';
import 'package:newsapps/services.dart';

class HomeController extends GetxController {
  final service = Services();
  List<Article> article = [];
  List<NewArticle> newArticle = [];
  TextEditingController searchController = TextEditingController();
  // bool newsIsloading = false;
  bool isLoading = false;

  Future<void> getTopHeadLines() async {
    var response = await service.getFunction(urlgetTopHeadline);

    print(response.statusCode);

    if (response.statusCode == 200) {
      // i just need article data
      var data = response.data['articles'];

      for (var i = 0; i < data.length; i++) {
        article.add(Article.fromJson(data[i]));
      }
    }

    update();
  }

  Future<void> getNews() async {
    var response = await Services().getFunction(urlgetNews);
    if (response.statusCode == 200) {
      // i just need article data
      var data = response.data['articles'];

      for (var i = 0; i < data.length; i++) {
        newArticle.add(NewArticle.fromJson(data[i]));
      }
    }
    update();
    print(response.statusCode);
  }

  Future<bool> onLikeButtonTapped(bool isLiked, BuildContext context) async {
    /// send your request here
    // final bool success= await sendRequest();
    if (!isLiked) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(milliseconds: 500),
        backgroundColor: successColor,
        content: Text("Anda Menyukai Berita Ini"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(milliseconds: 500),
        backgroundColor: errorColor,
        content: Text("Anda Batal Menyukai Berita Ini"),
      ));
    }
    print('ini $isLiked');

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return !isLiked;
  }

  firstInit() async {
    isLoading = true;

    await getTopHeadLines();
    //the progress is to fast and therefore i add delay for shimmer loading so can be seen
    await getNews();
    await Future.delayed(Duration(seconds: 3));

    isLoading = false;
    update();
  }

  Future<void> searchFunction() async {
    FocusManager.instance.primaryFocus?.unfocus();
    isLoading = true;
    update();

    var url =
        'https://newsapi.org/v2/everything?q=${searchController.text}&apiKey=3701026767e5475aada9abf499c57345';
    var response = await Services().getFunction(url);
    print(response.statusCode);
    print('ini article ${response.data['articles']}');
    if ((response.statusCode == 200)) {
      var data = response.data['articles'];
      newArticle = [];
      for (var i = 0; i < data.length; i++) {
        newArticle.add(NewArticle.fromJson(data[i]));
      }
      print(newArticle.length);
      update();
    }

    await Future.delayed(Duration(seconds: 3));

    isLoading = false;
    update();
  }

  @override
  void onInit() {
    firstInit();

    // TODO: implement onInit
    super.onInit();
  }
}
