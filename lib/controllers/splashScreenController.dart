import 'package:get/get.dart';

import 'package:newsapps/routes.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    firstInit();
    super.onInit();
  }

  firstInit() async {
    await Future.delayed(const Duration(seconds: 3));

    Get.toNamed(ListRouteNameGetX().homeScreen);
  }
}
