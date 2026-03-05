import 'package:flutter/material.dart';
import 'package:google_tasks_clone/app.dart';

import 'di/dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyManager.inject();
  runApp(const App());
}
