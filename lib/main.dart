import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_project/routes/app_routes.dart';

import 'core/binding/controller_binder.dart';
import 'core/services/db_helper.dart';
import 'core/utils/constants/app_sizer.dart';

void main() {
  runApp(
    MyApp(),
  );
}
class PlatformUtils {
  static bool get isIOS =>
      foundation.defaultTargetPlatform == TargetPlatform.iOS;
  static bool get isAndroid =>
      foundation.defaultTargetPlatform == TargetPlatform.android;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoute.homeScreen,
          getPages: AppRoute.routes,
          initialBinding: ControllerBinder(),
          themeMode: ThemeMode.system,

          defaultTransition: PlatformUtils.isIOS ? Transition.cupertino : Transition.fade,
          locale: Get.deviceLocale,
          builder: (context, child) => PlatformUtils.isIOS
              ? CupertinoTheme(data: const CupertinoThemeData(), child: child!)
              : child!,
        );
      },
    );
  }
}
