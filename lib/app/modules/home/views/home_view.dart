import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tasklist_app/app/controllers/authorization_controller.dart';
import 'package:tasklist_app/app/data/models/task_model.dart';
import 'package:tasklist_app/app/routes/app_pages.dart';
import 'package:tasklist_app/global_variable.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  AuthorizationController authC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.PROFILE);
              },
              icon: Icon(Icons.person_4))
        ],
        title: Obx(() => Text('${controller.user['name']}\'s task')),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: controller.getData(),
          builder: (context, snap) {
            // print(snap.data);
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Obx(
              () => controller.allData.length == 0
                  ? Center(
                      child: Text('Task kosong.'),
                    )
                  : ListView.builder(
                      itemCount: controller.allData.length,
                      itemBuilder: (context, index) {
                        Task data = controller.allData[index];
                        // print(data.name);
                        return ListTile(
                          trailing: IconButton(
                              onPressed: () => controller.delete(index),
                              icon: Icon(Icons.delete_forever)),
                          onTap: () =>
                              Get.toNamed(Routes.UPDATE_TASK, arguments: data),
                          leading: CircleAvatar(),
                          title: Text(data.name),
                          subtitle: Text(
                              '${controller.user['email']}\n${data.description}'),
                        );
                      },
                    ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var auth = await authC.authorization();
          if (auth[0] == 401) {
            expiredSession();
          } else {
            Get.toNamed(Routes.ADD_TASK);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
