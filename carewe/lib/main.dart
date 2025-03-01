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
  TextEditingController id = TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${isAdmin ? 'Admin' : 'Service'} login',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: id,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13)),
                  // icon: Icon(Icons.text_fields),
                  // fillColor: Colors.lightBlueAccent.withOpacity(0.3),
                  // filled: true,
                  labelText: 'Enter your id',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: pass,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13)),
                  labelText: 'Enter your password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            const Color.fromARGB(255, 4, 114, 8))),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (id.text == 'admin' &&
                            pass.text == 'admin@456' &&
                            isAdmin) {
                          Get.to(HomePage());
                        } else {
                          final DocumentReference document = FirebaseFirestore
                              .instance
                              .collection('s_person')
                              .doc(id.text);
                          DocumentSnapshot snapshot = await document.get();
                          final val = snapshot.data();
                          log('$val');
                          if (val.toString() == 'null') {
                            Get.snackbar('Error!', 'Error occured in given id');
                          } else {
                            log('${(val as Map)['person']['password']}');
                            if ((val as Map)['person']['password'] ==
                                pass.text) {
                              Get.to(ServiceHomePage());
                            } else {
                              Get.snackbar(
                                  'Error!', 'Error occured in given password');
                            }
                          }

                          // Get.to(ServiceHomePage());
                        }
                      }
                    },
                    child: Text(
                      'login',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isAdmin = !isAdmin;
                      });
                    },
                    child: Text(
                      '${isAdmin ? 'Service' : 'Admin'} login!!',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 9, 50, 83)),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
