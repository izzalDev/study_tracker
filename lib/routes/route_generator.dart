import 'package:flutter/material.dart';
import 'package:study_tracker/features/auth/screens/splash_screen.dart';
import 'package:study_tracker/features/tasks/models/task_model.dart';
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

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
