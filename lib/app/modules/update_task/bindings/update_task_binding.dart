import 'package:get/get.dart';

import '../controllers/update_task_controller.dart';

class UpdateTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateTaskController>(
      () => UpdateTaskController(),
    );
  }
}
