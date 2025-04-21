import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr/auth/auth_controller.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isPasswordVisible = false;
  final AuthController _auth = Get.find();

  final List<String> genderList = ['Male', 'Female'];
  final List<String> roleList = ['Admin', 'User'];

  String? selectedGender;
  String? selectedRole;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form Key for validation

  final List<Map<String, dynamic>> field = [
    {
      "label": "Name",
      "controller": TextEditingController(),
      "isPassword": false,
    },
    {
      "label": "Email",
      "controller": TextEditingController(),
      "isPassword": false,
    },
    {
      "label": "Password",
      "controller": TextEditingController(),
      "isPassword": true,
    },
    {
      "label": "Date Joined",
      "controller": TextEditingController(),
      "isPassword": false,
    },
    {
      "label": "Gender",
      "controller": TextEditingController(),
      "isPassword": false,
    },
    {
      "label": "Role",
      "controller": TextEditingController(),
      "isPassword": false,
    },
    {
      "label": "Phone number",
      "controller": TextEditingController(),
      "isPassword": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          "Register",
          style: textTheme.titleLarge,
          maxLines: 1,
          minFontSize: 18,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(  // Wrap everything in a Form widget
          key: _formKey, // Attach the form key for validation
          child: Column(
            children: [
              AutoSizeText(
                "Register",
                style: textTheme.titleLarge!
                    .copyWith(fontSize: 40, fontWeight: FontWeight.w500),
                maxLines: 1,
                minFontSize: 18,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              ...field.map((field) {
                if (field['label'] == 'Gender' || field['label'] == 'Role') {
                  List<String> options = field['label'] == 'Gender' ? genderList : roleList;
                  String? selectedValue = field['label'] == 'Gender' ? selectedGender : selectedRole;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: DropdownButtonFormField<String>(
                      value: selectedValue,
                      decoration: InputDecoration(
                        labelText: field['label'],
                        border: const OutlineInputBorder(),
                      ),
                      items: options.map((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          if (field['label'] == 'Gender') {
                            selectedGender = value;
                            field['controller'].text = value!;
                          } else {
                            selectedRole = value;
                            field['controller'].text = value!;
                          }
                        });
                      },
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: TextFormField(  // Use TextFormField for validation
                      controller: field['controller'],
                      obscureText: field['isPassword'] ? !_isPasswordVisible : false,
                      validator: (value) {
                        if (field['label'] == 'Email') {
                          // Validate email format
                          if (value == null || value.isEmpty || !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                        }
                        if (field['label'] == 'Password') {
                          // Validate password length (min 8 characters)
                          if (value == null || value.isEmpty || value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                        }
                        return null;  // No error
                      },
                      decoration: InputDecoration(
                        labelText: field['label'],
                        border: const OutlineInputBorder(),
                        suffixIcon: field['isPassword']
                            ? IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
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
                }
              }),

              const SizedBox(height: 20),

              SizedBox(
                width: 120,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // // Only proceed if validation passes
                      // _auth.register(
                      //   field[0]['controller'].text.trim(),  // Name
                      //   field[1]['controller'].text.trim(),  // Email
                      //   field[2]['controller'].text.trim(),  // Password
                      //   field[3]['controller'].text.trim(),  // Date Joined
                      //   field[4]['controller'].text.trim(),  // Gender
                      //   field[5]['controller'].text.trim(),  // Role
                      //   field[6]['controller'].text.trim(),  // Phone Number
                      // );
                    }
                  },
                  child: AutoSizeText(
                    "Register",
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
