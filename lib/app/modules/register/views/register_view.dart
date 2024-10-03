import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RegisterView'),
        centerTitle: true,
      ),
      body: ListView(
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
            height: 15,
          ),
          TextField(
            controller: controller.passC,
            decoration: InputDecoration(hintText: 'Password'),
          ),
          SizedBox(
            height: 35,
          ),
          Align(
            child: ElevatedButton(
              onPressed: () {
                controller.register();
              },
              child: Text('Register'),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
