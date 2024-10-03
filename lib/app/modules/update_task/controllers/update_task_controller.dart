import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasklist_app/app/controllers/authorization_controller.dart';
import 'package:tasklist_app/app/data/models/task_model.dart';
import 'package:tasklist_app/app/modules/home/controllers/home_controller.dart';
import 'package:tasklist_app/global_variable.dart';
import 'package:http/http.dart' as http;

class UpdateTaskController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController taskC = TextEditingController();
  Task data = Get.arguments;
  AuthorizationController authC = Get.find();
  HomeController homeC = Get.find();
  RxBool isLoading = false.obs;

  void updateTask() async {
    var code = await authC.authorization();
    if (nameC.text.isNotEmpty && taskC.text.isNotEmpty) {
      if (code[0] == 401) {
      } else {
        try {
          isLoading.value = true;
          var response = await http.put(Uri.parse('$url/api/notes/${data.id}'),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ${authC.jwt()}',
              },
              body:
                  json.encode({'name': nameC.text, 'description': taskC.text}));
          if (response.statusCode == 200) {
            homeC.getData();
            Get.back();
            Get.snackbar('BERHASIL', 'Berhasil mengupdate data');
          }
        } catch (e) {
          print(e);
        } finally {
          isLoading.value = false;
        }
      }
    }
  }
}
