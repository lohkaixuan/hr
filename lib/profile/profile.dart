import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void _logout() {
    // Implement your logout logic (e.g., clearing tokens, navigating to login page)
    Get.offAllNamed('/login'); // Example using GetX for navigation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("John Doe"), // Replace with dynamic data
              accountEmail: Text("johndoe@example.com"), // Replace with dynamic data
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/profile_pic.png"), // Replace with user's profile picture
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {
                Navigator.pop(context); // Close drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text("Change Password"),
              onTap: () {
                Navigator.pop(context); // Close drawer
                Get.toNamed('/change-password'); // Example navigation using GetX
              },
            ),
            const Spacer(), // Pushes logout button to the bottom
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: _logout,
            ),
            const SizedBox(height: 20), // Space at the bottom
          ],
        ),
      ),
      body: const Center(
        child: Text("Profile Page Content"),
      ),
    );
  }
}
