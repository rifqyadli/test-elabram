import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapps/controllers/detailController.dart';
import 'package:newsapps/controllers/homeController.dart';

import 'package:newsapps/controllers/splashScreenController.dart';

import 'package:newsapps/routes.dart';

void main() {
  runApp(const MyApp());
  Get.put(SplashScreenController());
  Get.put(HomeController());
  Get.put(DetailController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/splash-screen',
      unknownRoute: ListRouteGetX().notFoundRoute,
      getPages: ListRouteGetX().route,
    );
  }
}
