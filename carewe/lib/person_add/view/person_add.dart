import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDetailsForm extends StatefulWidget {
  @override
  _UserDetailsFormState createState() => _UserDetailsFormState();
}

class _UserDetailsFormState extends State<UserDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _picController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedService;
  final List<String> _services = [
    'Transportation',
    'Shopping',
    'Personal Assistant',
    'Hospital Companion',
    'Hygiene and Toileting',
    'Dressing Grooming',
    'Companionship',
    'Med Administration',
    'Meal preparing',
    'Laundry',
    'cleaning',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: _selectedService,
                decoration: InputDecoration(labelText: 'Service Name'),
                items: _services.map((String service) {
                  return DropdownMenuItem<String>(
                    value: service,
                    child: Text(service),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedService = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a service';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _genderController,
                decoration: InputDecoration(labelText: 'Gender'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the gender';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _picController,
                decoration: InputDecoration(labelText: 'Picture URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the picture URL';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(labelText: 'ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Process the data
                    print('Service Name: ${_serviceNameController.text}');
                    print('Name: ${_nameController.text}');
                    print('Age: ${_ageController.text}');
                    print('Gender: ${_genderController.text}');
                    print('Picture URL: ${_picController.text}');
                    print('ID: ${_idController.text}');
                    print('Password: ${_passwordController.text}');
                    final DocumentReference teacherDocument = FirebaseFirestore
                        .instance
                        .collection('ad_ser')
                        .doc('${_selectedService}');
                    final DocumentReference personDoc = FirebaseFirestore
                        .instance
                        .collection('s_person')
                        .doc('${_idController.text}');
                    final DocumentSnapshot dat = await teacherDocument.get();
                    log('${(dat.data() as Map)['person']}');
                    List fbval = ((dat.data() as Map)['person']) as List;
                    Map<String, dynamic> ldate = {
                      'name': _nameController.text,
                      'age': _ageController.text,
                      'gender': _genderController.text,
                      'pic': _picController.text,
                      'id': _idController.text,
                      'password': _passwordController.text,
                      'rating':4.5
                    };
                    Map<String, dynamic> pdate = {
                      'name': _nameController.text,
                      'age': _ageController.text,
                      'gender': _genderController.text,
                      'pic': _picController.text,
                      'id': _idController.text,
                      'password': _passwordController.text,
                      'chat': [],
                      'duty': [],
                      'rating':4.5
                    };
                    fbval.add(ldate);
                    await teacherDocument
                        .set({'person': fbval}, SetOptions(merge: false));
                    await personDoc
                        .set({'person': pdate}, SetOptions(merge: false));
                    Get.back();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
