import 'package:flutter/material.dart';
import 'package:study_tracker/features/auth/screens/login_screen.dart';
import 'package:study_tracker/features/auth/screens/splash_screen.dart';
import 'package:study_tracker/features/tasks/models/task_model.dart';
import 'package:study_tracker/features/tasks/screens/add_task_screen.dart';
import 'package:study_tracker/features/tasks/screens/edit_task_screen.dart';
import 'package:study_tracker/features/tasks/screens/task_detail_screen.dart';
import 'package:study_tracker/features/tasks/screens/task_list_screen.dart';
import 'app_routes.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.taskDetail:
        final task = settings.arguments as TaskModel;
        return MaterialPageRoute(builder: (_) => TaskDetailScreen(task: task));

      case AppRoutes.taskList:
        return MaterialPageRoute(builder: (_) => const TaskListScreen());

      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppRoutes.addTask:
        return MaterialPageRoute(builder: (_) => const AddTaskScreen());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRoutes.editTask:
        final task = settings.arguments as TaskModel;
        return MaterialPageRoute(builder: (_) => EditTaskScreen(task: task));

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Page not found')),
      ),
    );
  }
}
