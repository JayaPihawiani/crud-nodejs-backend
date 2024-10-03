import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tasklist_app/app/controllers/authorization_controller.dart';
import 'package:tasklist_app/app/modules/home/controllers/home_controller.dart';
import 'package:tasklist_app/global_variable.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  AuthorizationController authC = Get.find();
  HomeController homeC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => controller.logout(), icon: Icon(Icons.logout))
          ],
          title: Text('MY PROFILE'),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: controller.getUser(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var user = controller.user;
              controller.nameC.text = user['name'] ?? '';
              controller.emailC.text = user['email'] ?? '';
              controller.phoneC.text = user['phone'] ?? '';
              return ListView(
                padding: EdgeInsets.all(12),
                children: [
                  TextField(
                    controller: controller.nameC,
                    decoration: InputDecoration(hintText: 'Name'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: controller.emailC,
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: controller.phoneC,
                    decoration: InputDecoration(hintText: 'Phone'),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Align(
                    child: Obx(() => ElevatedButton(
                          onPressed: () async {
                            if ((await authC.authorization())[0] == 401) {
                              expiredSession();
                            } else {
                              await controller.updateUser();
                              homeC.getData();
                            }
                          },
                          child: Text(controller.isLoading.isFalse
                              ? 'UPDATE PROFILE'
                              : 'Loading...'),
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(200, 40),
                          ),
                        )),
                  ),
                ],
              );
            }));
  }
}
