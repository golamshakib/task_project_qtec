import 'package:get/get.dart';

import '../features/home/views/screen/home_screen.dart';

class AppRoute {
  static const homeScreen = "/homeScreen";



  static List<GetPage> routes = [
    GetPage(name: homeScreen, page:() => const HomeScreen())
  ];
}