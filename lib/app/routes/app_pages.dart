import 'package:get/get.dart';

import 'package:tasklist_app/app/modules/add_task/bindings/add_task_binding.dart';
import 'package:tasklist_app/app/modules/add_task/views/add_task_view.dart';
import 'package:tasklist_app/app/modules/home/bindings/home_binding.dart';
import 'package:tasklist_app/app/modules/home/views/home_view.dart';
import 'package:tasklist_app/app/modules/login/bindings/login_binding.dart';
import 'package:tasklist_app/app/modules/login/views/login_view.dart';
import 'package:tasklist_app/app/modules/profile/bindings/profile_binding.dart';
import 'package:tasklist_app/app/modules/profile/views/profile_view.dart';
import 'package:tasklist_app/app/modules/register/bindings/register_binding.dart';
import 'package:tasklist_app/app/modules/register/views/register_view.dart';
import 'package:tasklist_app/app/modules/update_task/bindings/update_task_binding.dart';
import 'package:tasklist_app/app/modules/update_task/views/update_task_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      transition: Transition.fadeIn,
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      transition: Transition.fadeIn,
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      transition: Transition.fadeIn,
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      transition: Transition.fadeIn,
      name: _Paths.UPDATE_TASK,
      page: () => UpdateTaskView(),
      binding: UpdateTaskBinding(),
    ),
    GetPage(
      transition: Transition.fadeIn,
      name: _Paths.ADD_TASK,
      page: () => AddTaskView(),
      binding: AddTaskBinding(),
    ),
    GetPage(
      transition: Transition.fadeIn,
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
  ];
}
