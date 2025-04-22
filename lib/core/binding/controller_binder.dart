import 'package:get/get.dart';
import 'package:task_project/core/services/db_helper.dart';
import '../../features/home/controllers/home_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
          () => HomeController(),
      fenix: true,
    );
  }}