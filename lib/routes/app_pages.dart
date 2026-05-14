import 'package:get/get.dart';
import '../features/task/presentation/bindings/task_binding.dart';
import '../features/task/presentation/screens/main_screen.dart';
import '../features/task/presentation/screens/add_task_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.main,
      page: () => const MainScreen(),
      binding: TaskBinding(),
    ),
    GetPage(
      name: AppRoutes.addTask,
      page: () => AddTaskScreen(),
      binding: TaskBinding(),
      transition: Transition.downToUp,
    ),
  ];
}
