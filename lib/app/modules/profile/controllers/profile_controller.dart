import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tasklist_app/app/controllers/authorization_controller.dart';
import 'package:tasklist_app/app/routes/app_pages.dart';
import 'package:tasklist_app/global_variable.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  AuthorizationController authC = Get.find();
  RxBool isLoading = false.obs;
  Map user = {};

  void logout() {
    final box = GetStorage();
    Get.defaultDialog(
      title: 'KONFIRMASI',
      content: Text('Anda yakin ingin logout?'),
      actions: [
        OutlinedButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
            )),
        OutlinedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.blue)),
          onPressed: () {
            Get.offAllNamed(Routes.LOGIN);
            box.remove('myJWT');
          },
          child: Text(
            'Logout',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  updateUser() async {
    if (nameC.text.isEmpty || emailC.text.isEmpty || phoneC.text.isEmpty) {
      Get.snackbar('WARNING', 'Nama, email, dan nomor hp tidak boleh kosong!');
    } else {
      var code = (await authC.authorization())[0];
      if (code == 401) {
        expiredSession();
      } else {
        try {
          isLoading.value = true;
          var userRespon = await http.put(Uri.parse('$url/api/users/profile'),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ${authC.jwt()}',
              },
              body: json.encode({
                'name': nameC.text,
                'email': emailC.text,
                'phone': phoneC.text,
              }));

          if (userRespon.statusCode == 200) {
            Get.snackbar('BERHASIL', 'Berhasil update profil anda');
          }
        } catch (e) {
          print(e);
        } finally {
          isLoading.value = false;
        }
      }
    }
  }

  getUser() async {
    try {
      var userRespon = await http.get(
        Uri.parse('$url/api/users/user'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${authC.jwt()}',
        },
      );

      var body = json.decode(userRespon.body);
      user = body;
      return user;
    } catch (e) {
      print(e);
    }
  }
}
