import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tasklist_app/app/routes/app_pages.dart';
import 'package:tasklist_app/global_variable.dart';

class LoginController extends GetxController {
  RxBool isHidden = true.obs;
  RxBool isLoading = true.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  final box = GetStorage();

  void login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      try {
        isLoading.value = false;
        var response = await http.post(
          Uri.parse('${url}/api/users/login'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(
            {
              'email': emailC.text,
              'password': passC.text,
            },
          ),
        );
        if (response.statusCode == 200) {
          var body = json.decode(response.body);
          String token = body['token'];
          box.write('myJWT', token);
          String name = body['user']['name'];
          Get.snackbar('Welcome', 'Selamat datang $name');
          Get.offAllNamed(Routes.HOME);
        } else {
          var body = json.decode(response.body);
          print(body);
          Get.snackbar('Error', body['msg']);
        }
      } catch (e) {
        print(e);
        Get.snackbar('Error', '$e');
      } finally {
        isLoading.value = true;
      }
    }
  }
}
