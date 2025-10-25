import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';
import 'package:study_tracker/features/auth/providers/auth_provider.dart';
import 'package:study_tracker/features/auth/screens/login_screen.dart';
import 'package:study_tracker/features/tasks/screens/task_list_screen.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'routes/route_generator.dart';
import 'routes/app_routes.dart';

class StudyTrackerApp extends StatefulWidget {
  const StudyTrackerApp({super.key});

  @override
  State<StudyTrackerApp> createState() => _StudyTrackerAppState();
}

class _StudyTrackerAppState extends State<StudyTrackerApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthProvider>().checkAuthStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
      home: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (authProvider.isAuthenticated) {
            return const TaskListScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
      localizationsDelegates: [FlutterQuillLocalizations.delegate],
    );
  }
}
