import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sql/config/app_binding.dart';

import 'view/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.dark,
      home: const HomeScreen(),
      initialBinding: AppBindings(),
    );
  }
}
