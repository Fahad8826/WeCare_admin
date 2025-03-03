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
        title: Text(
          'User Details Form',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Colors.white, // Standard blue AppBar
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Service Dropdown
              _buildDropdownField(
                label: 'Service Name',
                value: _selectedService,
                items: _services,
                onChanged: (newValue) {
                  setState(() {
                    _selectedService = newValue;
                  });
                },
                icon: Icons.work_outline,
              ),
              SizedBox(height: 16),

              // Name Field
              _buildTextFormField(
                controller: _nameController,
                label: 'Name',
                icon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Age Field
              _buildTextFormField(
                controller: _ageController,
                label: 'Age',
                icon: Icons.calendar_today,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the age';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Gender Field
              _buildTextFormField(
                controller: _genderController,
                label: 'Gender',
                icon: Icons.transgender,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the gender';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Picture URL Field
              _buildTextFormField(
                controller: _picController,
                label: 'Picture URL',
                icon: Icons.image_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the picture URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // ID Field
              _buildTextFormField(
                controller: _idController,
                label: 'ID',
                icon: Icons.assignment_ind_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the ID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Password Field
              _buildTextFormField(
                controller: _passwordController,
                label: 'Password',
                icon: Icons.lock_outline,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Process the data
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
                      'rating': 4.5
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
                      'rating': 4.5
                    };
                    fbval.add(ldate);
                    await teacherDocument
                        .set({'person': fbval}, SetOptions(merge: false));
                    await personDoc
                        .set({'person': pdate}, SetOptions(merge: false));
                    Get.back();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1E3A8A), // Standard blue button
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build a dropdown field
  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    required IconData icon,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xFF1E3A8A)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF1E3A8A), width: 2),
        ),
      ),
      items: items.map((String service) {
        return DropdownMenuItem<String>(
          value: service,
          child: Text(service),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a service';
        }
        return null;
      },
    );
  }

  // Helper method to build a text form field
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    required String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xFF1E3A8A)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
    );
  }
}
