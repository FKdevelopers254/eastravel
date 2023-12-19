import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfile extends StatefulWidget {
  final String docId;

  EditProfile({required this.docId});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _cityController;
  late TextEditingController _ratingController;
  late TextEditingController _imageController;
  late TextEditingController _descriptionController;


  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _cityController = TextEditingController();
    _ratingController = TextEditingController();
    _imageController = TextEditingController();
    _descriptionController = TextEditingController();

    _loadData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    _ratingController.dispose();
    _imageController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  void _loadData() async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(widget.docId).get();
    final data = doc.data() as Map<String, dynamic>;
    _nameController.text = data['firstname'];
    _cityController.text = data['location'];
    _ratingController.text = data['age'].toString();
    _imageController.text = data['lastname'];
    _descriptionController.text = data['email'];



  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final city = _cityController.text.trim();
      final rating = int.parse(_ratingController.text.trim());
      final imageurl = _imageController.text.trim();
      final description = _descriptionController.text.trim();



      await FirebaseFirestore.instance.collection('users').doc(widget.docId).update({
        'firstname': name,
        'location': city,
        'age': rating,
        'lastname': imageurl,
        'email': description,

      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _imageController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Last Name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      labelText: 'City',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a city';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _ratingController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Phone Number';
                      }
                      final rating = int.tryParse(value);
                      if (rating == null || rating < 0 || rating > 50000000) {
                        return 'Please enter a rating between 0 and 5000000';
                      }
                      return null;
                    },
                  ),

                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                  ),







                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text('Save'),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
