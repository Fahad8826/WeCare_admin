// main.dart
import 'dart:developer';

import 'package:carewe/firebase_options.dart';
import 'package:carewe/home/view/home.dart';
import 'package:carewe/service_home/home/service_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const WeCareApp());
}

class WeCareApp extends StatelessWidget {
  const WeCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WeCare App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Login(),
    );
  }
}

// Welcome Screen

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool isAdmin = false;
  bool obscurePassword = true;
  TextEditingController id = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          // Top decoration shape
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: size.height * 0.3,
              decoration: BoxDecoration(
                color: isAdmin
                    ? const Color(0xFF1E3A8A) // Darker blue for admin
                    : const Color(0xFF047204), // Green for service
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
          ),

          // Logo or app icon placeholder
          Positioned(
            top: size.height * 0.12,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Icon(
                  isAdmin
                      ? Icons.admin_panel_settings
                      : Icons.miscellaneous_services,
                  size: 45,
                  color: isAdmin
                      ? const Color(0xFF1E3A8A)
                      : const Color(0xFF047204),
                ),
              ),
            ),
          ),

          // Main form
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  width: size.width * 0.9,
                  margin: EdgeInsets.only(top: size.height * 0.15),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 15,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          '${isAdmin ? 'Admin' : 'Service'} Login',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isAdmin
                                ? const Color(0xFF1E3A8A)
                                : const Color(0xFF047204),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Please enter your credentials to continue',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 30),

                        // Username field
                        Text(
                          'User ID',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: id,
                          decoration: InputDecoration(
                            hintText: 'Enter your ID',
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: isAdmin
                                  ? const Color(0xFF1E3A8A)
                                  : const Color(0xFF047204),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: isAdmin
                                    ? const Color(0xFF1E3A8A)
                                    : const Color(0xFF047204),
                                width: 2,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your ID';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24),

                        // Password field
                        Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: pass,
                          obscureText: obscurePassword,
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: isAdmin
                                  ? const Color(0xFF1E3A8A)
                                  : const Color(0xFF047204),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: isAdmin
                                    ? const Color(0xFF1E3A8A)
                                    : const Color(0xFF047204),
                                width: 2,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),

                        // Login button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (id.text == 'admin' &&
                                    pass.text == 'admin@456' &&
                                    isAdmin) {
                                  Get.to(HomePage());
                                } else {
                                  final DocumentReference document =
                                      FirebaseFirestore.instance
                                          .collection('s_person')
                                          .doc(id.text);
                                  DocumentSnapshot snapshot =
                                      await document.get();
                                  final val = snapshot.data();
                                  log('$val');
                                  if (val.toString() == 'null') {
                                    Get.snackbar(
                                        'Error!', 'Error occurred in given ID',
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.red[100],
                                        colorText: Colors.red[800],
                                        margin: EdgeInsets.all(10));
                                  } else {
                                    log('${(val as Map)['person']['password']}');
                                    if ((val as Map)['person']['password'] ==
                                        pass.text) {
                                      Get.to(ServiceHomePage());
                                    } else {
                                      Get.snackbar('Error!',
                                          'Error occurred in given password',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.red[100],
                                          colorText: Colors.red[800],
                                          margin: EdgeInsets.all(10));
                                    }
                                  }
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isAdmin
                                  ? const Color(0xFF1E3A8A)
                                  : const Color(0xFF047204),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        // Toggle between admin and service
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Switch to ',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isAdmin = !isAdmin;
                                  });
                                },
                                child: Text(
                                  '${isAdmin ? 'Service' : 'Admin'} Login',
                                  style: TextStyle(
                                    color: isAdmin
                                        ? const Color(0xFF1E3A8A)
                                        : const Color(0xFF047204),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Bottom decoration shape
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: (isAdmin
                        ? const Color(0xFF1E3A8A)
                        : const Color(0xFF047204))
                    .withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
