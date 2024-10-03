import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tasklist_app/app/controllers/authorization_controller.dart';
import 'package:tasklist_app/global_variable.dart';
import '../../../data/models/task_model.dart';

class HomeController extends GetxController {
  AuthorizationController auth = Get.find();
  RxList allData = <Task>[].obs;
  RxMap user = {}.obs;

  getData() async {
    var authorization = await auth.authorization();
    if (authorization[0] == 401) {
      expiredSession();
    } else {
      try {
        List<Task> dataNotes = [];
        var userRespon =
            await http.get(Uri.parse('$url/api/users/user'), headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${auth.jwt()}',
        });
        var userBody = json.decode(userRespon.body);
        user.value = userBody;
        var response = await http.get(Uri.parse('$url/api/notes'), headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${auth.jwt()}',
        });
        // print(response.body);
        var body = json.decode(response.body);
        // print(body);
        body.forEach((element) {
          dataNotes.add(Task(element['name'], element['description'],
              element['_id'], element['userID']));
        });
        allData.value = dataNotes;
        // print(allData);
        return allData;
      } catch (e) {
        print(e);
      }
    }
  }

  void delete(int index) async {
    var authorization = await auth.authorization();
    if (authorization[0] == 401) {
      expiredSession();
    } else {
      try {
        var response = await http.get(Uri.parse('$url/api/notes'), headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${auth.jwt()}',
        });

        var id = json.decode(response.body)[index]['_id'];
        var deleteNote =
            await http.delete(Uri.parse('$url/api/notes/$id'), headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${auth.jwt()}',
        });
        if (deleteNote.statusCode != 200) {
          print(deleteNote.body);
        } else {
          allData.removeAt(index);
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
