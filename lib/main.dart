import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tasklist_app/app/controllers/authorization_controller.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  AuthorizationController auth =
      Get.put(AuthorizationController(), permanent: true);
  var code = await auth.authorization();
  print(code[0]);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "tasklist",
      initialRoute: code[0] == 200 ? Routes.HOME : Routes.LOGIN,
      getPages: AppPages.routes,
    ),
  );
}
