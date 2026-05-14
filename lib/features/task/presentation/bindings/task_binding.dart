import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../data/repositories/task_repository_impl.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/usecases/add_task_usecase.dart';
import '../../domain/usecases/delete_task_usecase.dart';
import '../../domain/usecases/get_tasks_usecase.dart';
import '../../domain/usecases/toggle_task_usecase.dart';
import '../controllers/task_controller.dart';
import '../controllers/main_controller.dart';

class TaskBinding extends Bindings {
  @override
  void dependencies() {
    // Repository
    Get.lazyPut<TaskRepository>(
      () => TaskRepositoryImpl(Get.find<GetStorage>()),
    );

    // Use Cases
    Get.lazyPut(() => GetTasksUseCase(Get.find<TaskRepository>()));
    Get.lazyPut(() => AddTaskUseCase(Get.find<TaskRepository>()));
    Get.lazyPut(() => ToggleTaskUseCase(Get.find<TaskRepository>()));
    Get.lazyPut(() => DeleteTaskUseCase(Get.find<TaskRepository>()));

    // Controller
    Get.lazyPut(
      () => TaskController(
        Get.find<GetTasksUseCase>(),
        Get.find<AddTaskUseCase>(),
        Get.find<ToggleTaskUseCase>(),
        Get.find<DeleteTaskUseCase>(),
      ),
    );
    Get.lazyPut(() => MainController());
  }
}
