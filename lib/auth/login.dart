import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr/auth/auth_controller.dart';
import 'package:hr/universal/GlobalOverlay.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalOverlay _global = Get.find();
  final AuthController _auth = Get.find();
  final List<Map<String, dynamic>> field = [
    {"label": "Email", "controller": TextEditingController(), "isPassword": false},
    {"label": "Password", "controller": TextEditingController(), "isPassword": true},
  ];
  bool _isPasswordVisible = false;

  // Map to store validation results
  final Map<String, String?> _validationErrors = {
    "Email": null,
    "Password": null,
  };

  // Method to validate email
  String? _validateEmail(String value) {
    const emailPattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
    final regex = RegExp(emailPattern);
    if (value.isEmpty) {
      return "Email cannot be empty";
    } else if (!regex.hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  // Method to validate password
  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return "Password cannot be empty";
    } else if (value.length < 8) {
      return "Password must be at least 8 characters long";
    }
    return null;
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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: AutoSizeText(
                      "Login",
                      style: textTheme.titleLarge,
                      maxLines: 1,
                      minFontSize: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Loop through fields and create TextFields dynamically
                  ...field.map((field) {
                    final fieldLabel = field["label"];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextField(
                        controller: field["controller"],
                        obscureText: field["isPassword"] ? !_isPasswordVisible : false,
                        decoration: InputDecoration(
                          labelText: fieldLabel,
                          labelStyle: textTheme.labelLarge,
                          border: const OutlineInputBorder(),
                          // Use the label to get the corresponding error message
                          errorText: _validationErrors[fieldLabel], // Dynamically get the error text

                          suffixIcon: field["isPassword"]
                              ? IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: colorScheme.primary,
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
                    );
                  }).toList(),

                  const SizedBox(height: 20),

                  // Login Button
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: _global.buttonIsClick.value
                          ? null
                          : () {
                              final email = field[0]["controller"].text.trim();
                              final password = field[1]["controller"].text.trim();

                              // Validate both email and password
                              setState(() {
                                _validationErrors["Email"] = _validateEmail(email);
                                _validationErrors["Password"] = _validatePassword(password);
                              });

                              // If there's no validation error, call login
                              if (_validationErrors.values.every((e) => e == null)) {
                                _auth.login(email, password);
                              }
                            },
                      style: theme.elevatedButtonTheme.style,
                      child: AutoSizeText(
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
          _global.overlay(),
        ],
      ),
    );
  }
}
