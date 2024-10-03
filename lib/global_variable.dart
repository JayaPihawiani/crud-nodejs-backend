import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tasklist_app/app/routes/app_pages.dart';

String url = 'http://localhost:8080';

void expiredSession() {
  final box = GetStorage();
  Get.defaultDialog(
    barrierDismissible: false,
    title: 'EXPIRED SESSION',
    content:
        Center(child: Text('Sesi anda sudah habis. Silakan login kembali.')),
    actions: [
      OutlinedButton(
        style:
            ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),
        onPressed: () => Get.offAllNamed(Routes.LOGIN),
        child: Text(
          'Logout',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ],
  );
  box.remove('myJWT');
}
