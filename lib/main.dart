import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_tracker/features/auth/providers/auth_provider.dart';
import 'app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: const StudyTrackerApp(),
    ),
  );
}
