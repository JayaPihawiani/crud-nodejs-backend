import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../global_variable.dart';

class AuthorizationController extends GetxController {
  String? jwt() {
    final box = GetStorage();
    return box.read('myJWT');
  }

  Future<List> authorization() async {
    try {
      var response = await http.get(
        Uri.parse('$url/api/users/current'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${jwt()}'
        },
      );
      return [response.statusCode, response.body];
    } catch (e) {
      Get.snackbar('ERROR', '$e');
      return [];
    }
  }
}
