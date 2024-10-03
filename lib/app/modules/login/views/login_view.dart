import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tasklist_app/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          title: Text(
            'LOGIN',
          ),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(12),
          children: [
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: controller.emailC,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            SizedBox(
              height: 15,
            ),
            Obx(
              () => TextField(
                obscureText: controller.isHidden.value,
                controller: controller.passC,
                decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                        onPressed: () => controller.isHidden.toggle(),
                        icon: Icon(controller.isHidden.isTrue
                            ? Icons.remove_red_eye
                            : Icons.remove_red_eye_outlined))),
              ),
            ),
            SizedBox(
              height: 39,
            ),
            Align(
              child: Obx(
                () => ElevatedButton(
                  onPressed: () {
                    controller.login();
                  },
                  child:
                      Text(controller.isLoading.isTrue ? 'LOGIN' : 'Loading'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(100, 40),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 39,
            ),
            Center(
              child: RichText(
                  text: TextSpan(
                children: [
                  TextSpan(
                      text: 'Tidak punya akun? ',
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                    text: 'Buat akun.',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.toNamed(
                            Routes.REGISTER,
                          ),
                  ),
                ],
              )),
            )
          ],
        ));
  }
}
