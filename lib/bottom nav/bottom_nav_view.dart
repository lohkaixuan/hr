import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr/admin/approve.dart';
import 'package:hr/auth/auth_controller.dart';
import 'package:hr/calendar/calendar.dart';
import 'package:hr/home/home.dart';
import 'package:hr/profile/profile.dart';

import 'bottom_nav_controller.dart';

class BottomNavApp extends StatelessWidget {
  BottomNavApp({super.key});

  final BottomNavController navController = Get.find();
  final AuthController _auth = Get.find(); // AuthController instance

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get current theme

    return Obx(() {
      // Reactive role fetching
      final String userRole = _auth.role.value;

      // Define base pages
      List<Widget> pages = [
        Home(),
        CustomCalendar(),
        Profile(),
      ];

      List<BottomNavigationBarItem> navItems = [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: theme.iconTheme.color),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today, color: theme.iconTheme.color),
          label: "Calendar",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: theme.iconTheme.color),
          label: "Profile",
        ),
      ];

      // If the user is an admin, add the Approve page
      if (userRole == "admin") {
        pages.add(Approve());
        navItems.add(
          BottomNavigationBarItem(
            icon: Icon(Icons.check, color: theme.iconTheme.color),
            label: "Approve",
          ),
        );
      }

      return Scaffold(
        body: pages[navController.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navController.selectedIndex.value,
          onTap: (index) => navController.changeIndex(index),
          items: navItems,
          backgroundColor: theme.bottomNavigationBarTheme.backgroundColor, // Use theme's background
          selectedItemColor: theme.bottomNavigationBarTheme.selectedItemColor, // Theme-selected color
          unselectedItemColor: theme.bottomNavigationBarTheme.unselectedItemColor, // Theme-unselected color
          selectedLabelStyle: theme.textTheme.labelLarge, // Apply label style from theme
          unselectedLabelStyle: theme.textTheme.labelLarge?.copyWith(color: theme.bottomNavigationBarTheme.unselectedItemColor),
        ),
      );
    });
  }
}
