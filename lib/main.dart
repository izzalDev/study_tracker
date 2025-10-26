import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_tracker/app.dart';
import 'package:study_tracker/features/auth/providers/auth_provider.dart';
import 'package:study_tracker/features/tasks/provider/category_filter_provider.dart';
import 'package:study_tracker/features/tasks/provider/task_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => CategoryFilterProvider()),
      ],
      child: const StudyTrackerApp(),
    ),
  );
}
