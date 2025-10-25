import 'package:flutter/material.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';

/// Root widget untuk StudyTracker app
class StudyTrackerApp extends StatelessWidget {
  const StudyTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      home: Scaffold(
        appBar: AppBar(title: const Text(AppStrings.appName)),
        body: const Center(child: Text('StudyTracker App - Theme Applied!')),
      ),
    );
  }
}
