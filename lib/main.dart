import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hr/auth/auth_controller.dart';
import 'package:hr/bottom%20nav/bottom_nav_controller.dart';
import 'package:hr/calendar/calendar_controller.dart';
import 'package:hr/route/page.dart';
import 'package:hr/storage/storage.dart';
import 'package:hr/universal/dialog.dart';
import 'package:hr/universal/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  await GetStorage.init(); // Initialize local storage
  Get.put(ShowDialog());
  Get.put(AuthController()); // Auth controller
  Get.put(CalendarController()); // Calendar controller
  Get.put(BottomNavController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: Storage().getAuthToken(), // Get stored auth token
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show loading indicator
        }

        String? authToken = snapshot.data;
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme, // 🌟 Light Theme
          darkTheme: AppTheme.darkTheme, // 🌙 Dark Theme
          themeMode: ThemeMode.system, // 🌓 Auto-switch theme

          // 📌 Set initial route: If logged in, go to home; else, go to login
          initialRoute: authToken != null 
          ? "/home" 
          : "/login",
          //initialRoute: '/home',
          getPages: AppRoutes.routes, // Route management
        );
      },
    );
  }
}
