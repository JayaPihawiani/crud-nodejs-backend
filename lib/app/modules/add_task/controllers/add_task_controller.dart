import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasklist_app/app/controllers/authorization_controller.dart';
import 'package:tasklist_app/app/modules/home/controllers/home_controller.dart';
import 'package:tasklist_app/global_variable.dart';
import 'package:http/http.dart' as http;

class AddTaskController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController taskC = TextEditingController();
  AuthorizationController auth = Get.find();
  HomeController homeC = Get.find();

  Future<bool> addTask() async {
    var autorisasi = await auth.authorization();
    if (nameC.text.isNotEmpty && taskC.text.isNotEmpty) {
      if (autorisasi[0] == 401) {
        expiredSession();
      } else {
        try {
          var response = await http.post(Uri.parse('$url/api/notes'),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ${auth.jwt()}',
              },
              body:
                  json.encode({'name': nameC.text, 'description': taskC.text}));

          if (response.statusCode == 201) {
            Get.snackbar('BERHASIL', 'Berhasil tambah note.');
          }
          return true;
        } catch (e) {
          print(e);
          return false;
        }
      }
      return false;
    } else {
      Get.snackbar('ERROR', 'Field ada yang kosong.');
      return false;
    }
  }
}
