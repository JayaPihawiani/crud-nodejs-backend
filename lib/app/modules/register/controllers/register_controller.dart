import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tasklist_app/app/routes/app_pages.dart';

import '../../../../global_variable.dart';

class RegisterController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController passC = TextEditingController();

  void register() async {
    if (emailC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        passC.text.isNotEmpty &&
        phoneC.text.isNotEmpty) {
      try {
        var response = await http.post(
          Uri.parse('$url/api/users/register'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(
            {
              'name': nameC.text,
              'email': emailC.text,
              'password': passC.text,
              'phone': phoneC.text,
            },
          ),
        );
        if (response.statusCode == 201) {
          Center(
            child: CircularProgressIndicator(),
          );
          Get.snackbar('BERHASIL',
              'Akun anda berhasil dibuat, silakan login dengan email dan password.');
          Get.offAllNamed(Routes.LOGIN);
        } else {
          var body = json.decode(response.body);
          Get.snackbar('ERROR', body['msg']);
        }
      } catch (e) {
        print(e);
      }
    } else {
      Get.snackbar('ERROR', 'Field ada yang kosong.');
    }
  }
}
