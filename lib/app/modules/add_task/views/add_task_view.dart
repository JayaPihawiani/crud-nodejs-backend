import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tasklist_app/app/modules/home/controllers/home_controller.dart';
import 'package:tasklist_app/app/routes/app_pages.dart';

import '../controllers/add_task_controller.dart';

class AddTaskView extends GetView<AddTaskController> {
  HomeController homeC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('AddTaskView'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(12),
          children: [
            TextField(
              controller: controller.nameC,
              decoration: InputDecoration(hintText: 'Task name'),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: controller.taskC,
              decoration: InputDecoration(hintText: 'Task description'),
            ),
            SizedBox(
              height: 35,
            ),
            Align(
              child: ElevatedButton(
                onPressed: () async {
                  bool task = await controller.addTask();
                  if (task == true) {
                    Get.offAllNamed(Routes.HOME);
                  }
                },
                child: Text('ADD TASK'),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(100, 40),
                ),
              ),
            ),
          ],
        ));
  }
}
