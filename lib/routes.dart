import 'package:get/get.dart';
import 'package:newsapps/pages/homeScreen.dart';
import 'package:newsapps/pages/splashScreen.dart';
import 'package:newsapps/pages/unknownRoute.dart';

class ListRouteNameGetX {
  final String splashScreen = '/splash-screen';
  final String unknownRoute = '/unknown-route';
  final String homeScreen = '/home';
}

class ListRouteGetX {
  List<GetPage<dynamic>> route = [
    GetPage(
        name: ListRouteNameGetX().splashScreen,
        page: () => const SplashScreen()),
    GetPage(
        transition: Transition.circularReveal,
        name: ListRouteNameGetX().homeScreen,
        page: () => const HomeScreen()),
  ];
  var notFoundRoute = GetPage(
      name: ListRouteNameGetX().unknownRoute, page: () => const UnknownRoute());
}
