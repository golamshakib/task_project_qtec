import 'package:get/get.dart';

import '../features/home/views/home_view.dart';

class AppRoute {
  static const homeScreen = "/homeScreen";



  static List<GetPage> routes = [
    GetPage(name: homeScreen, page:() => const HomeScreen())
    // GetPage(name: homeScreen, page:() => const HomeScreen())
  ];
}