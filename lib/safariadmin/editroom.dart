import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditRoomPage extends StatefulWidget {
  final String docId;

  EditRoomPage({required this.docId});

  @override
  _EditRoomPageState createState() => _EditRoomPageState();
}

class _EditRoomPageState extends State<EditRoomPage> {
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
    final doc = await FirebaseFirestore.instance.collection('safaris').doc(widget.docId).get();
    final data = doc.data() as Map<String, dynamic>;
    _nameController.text = data['name'];
    _cityController.text = data['address'];
    _ratingController.text = data['price'].toString();
    _imageController.text = data['imageUrl'];
    _descriptionController.text = data['description'];
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final city = _cityController.text.trim();
      final rating = int.parse(_ratingController.text.trim());
      final imageurl = _imageController.text.trim();
      final description = _descriptionController.text.trim();


      await FirebaseFirestore.instance.collection('rooms').doc(widget.docId).update({
        'name': name,
        'address': city,
        'price': rating,
        'imageurl': imageurl,
        'description': description,
      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Safari',),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a city';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: _ratingController,
                decoration: const InputDecoration(
                  labelText: 'Rating',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Price';
                  }
                  final rating = int.tryParse(value);
                  if (rating == null || rating < 0 || rating > 50000000) {
                    return 'Please enter a rating between 0 and 5000000';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(
                  labelText: 'Image',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Image  Url';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10,),


              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
