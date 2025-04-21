import 'dart:async';  // Import for Timer
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr/auth/auth_controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isPasswordVisible = false; // Toggle for password visibility
  bool _isButtonDisabled = false; // Track button disable state
  Timer? _timer; // Timer to reset button state
  final AuthController _auth = Get.find();
  final List<Map<String, dynamic>> field = [
    {"label": "Gmail", "controller": TextEditingController(), "isPassword": false},
    {"label": "Password", "controller": TextEditingController(), "isPassword": true},
  ];

  // Function to handle login
  void _handleLogin() {
    if (_isButtonDisabled) return; // Prevent multiple clicks

    setState(() {
      _isButtonDisabled = true; // Disable button on click
    });

    _auth.login(
      field[0]["controller"].text.trim(),
      field[1]["controller"].text.trim(),
    );

    // Reset button after 30 seconds
    _timer = Timer(Duration(seconds: 30), () {
      setState(() {
        _isButtonDisabled = false; // Re-enable the button after 30 seconds
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Login", style: textTheme.titleLarge),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: AutoSizeText(
                  "Login",
                  style: textTheme.titleLarge, // Use themed title
                  maxLines: 1,
                  minFontSize: 25,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20), // Add spacing

              // TextFields for email and password
              ...field.map((field) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: TextField(
                      controller: field["controller"],
                      obscureText: field["isPassword"] ? !_isPasswordVisible : false,
                      decoration: InputDecoration(
                        labelText: field["label"],
                        labelStyle: textTheme.labelLarge, // Use themed label style
                        border: const OutlineInputBorder(),
                        suffixIcon: field["isPassword"]
                            ? IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: colorScheme.primary, // Match theme
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              )
                            : null,
                      ),
                    ),
                  )),

             

              const SizedBox(height: 20), // Add spacing

              // Login button
              SizedBox(
                width: 120, // Set your desired width
                child: ElevatedButton(
                  onPressed: _isButtonDisabled ? null : _handleLogin, // Disable if button is disabled
                  style: theme.elevatedButtonTheme.style, // Use the themed button style
                  child: _isButtonDisabled
                      ? CircularProgressIndicator(color: Colors.white) // Show loading indicator
                      : AutoSizeText(
                          "Log in",
                          style: textTheme.bodyLarge!.copyWith(color: Colors.white),
                          maxLines: 1,
                          minFontSize: 14,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
