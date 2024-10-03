import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_task_controller.dart';

class UpdateTaskView extends GetView<UpdateTaskController> {
  @override
  Widget build(BuildContext context) {
    controller.nameC.text = controller.data.name;
    controller.taskC.text = controller.data.description;
    return Scaffold(
        appBar: AppBar(
          title: Text('UPDATE TASK'),
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
              child: Obx(() => ElevatedButton(
                    onPressed: () {
                      controller.updateTask();
                    },
                    child: Text(
                        controller.isLoading.isFalse ? 'UPDATE' : 'Loading'),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(100, 40),
                    ),
                  )),
            ),
          ],
        ));
  }
}
