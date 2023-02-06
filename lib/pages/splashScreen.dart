import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapps/controllers/splashScreenController.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(builder: (controller) {
      return Center(
        child: Image.asset(
          'assets/world-news.png',
          width: 500,
          height: 500,
        ),
      );
    });
  }
}
