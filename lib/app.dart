import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'routes/route_generator.dart';
import 'routes/app_routes.dart';

class StudyTrackerApp extends StatelessWidget {
  const StudyTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
      localizationsDelegates: [FlutterQuillLocalizations.delegate],
    );
  }
}
