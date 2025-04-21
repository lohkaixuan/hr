import 'package:get/get.dart';
import 'package:hr/auth/login.dart';
import 'package:hr/auth/register.dart';
import 'package:hr/bottom%20nav/bottom_nav_view.dart';

class AppRoutes {
  static const initial = '/login';

  static final routes = [
    GetPage(
      name: '/login',
      page: () => Login(),
    ),
    GetPage(
      name: '/register',
      page: () => Register(),
    ),
    // GetPage(
    //   name: '/home',
    // page:()=> CustomCalendar()
    // ),
    GetPage(
      name: '/home', // 🔥 After login, navigate here
      page: () => BottomNavApp(),
    ),
  ];
}
