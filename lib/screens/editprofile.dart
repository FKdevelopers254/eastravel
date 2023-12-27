import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

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
        title:  Stack(
          children: <Widget>[
            Container(
              height: 55.0,

              decoration:   BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.8),
                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(5.0,),bottomLeft: Radius.circular(75.0,),topRight: Radius.circular(75)



                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                GestureDetector(


                  child:  GestureDetector(
                    onLongPress: (){FirebaseAuth.instance.signOut();},
                    // onLongPress: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  PaymentPage()));},
                    //  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  PaymentPage()));},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedTextKit(
                          animatedTexts: [

                            // TyperAnimatedText(user.email!,textStyle: GoogleFonts.abrilFatface(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 17)),
                            TyperAnimatedText('Edit Profile',textStyle: GoogleFonts.abrilFatface(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 28,letterSpacing: 1.5)),

                          ],
                          pause: const Duration(milliseconds: 5000),

                          stopPauseOnTap: true,
                          repeatForever: true,
                        ),

                        // child:  Text('EAS SAFARIS',style: GoogleFonts.sassyFrass(fontWeight: FontWeight.bold,fontSize: 28,letterSpacing: 1.5)
                        //),
                      ],
                    ),
                  ),
                  // onTap: Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen())),
                ),

                Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: GestureDetector(
                  //  onTap: (){FirebaseAuth.instance.signOut();},
                    // onLongPress: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const BirdApp()));},
                    child:
                    Lottie.asset('assets/icons/96833-login.json',height: 50,),
                  ),)

              ],),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(),
                      hintText: 'Enter your first name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _imageController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(),
                      hintText: 'Enter your last name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a last name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      labelText: 'City',
                      border: OutlineInputBorder(),
                      hintText: 'Enter your city',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a city';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _ratingController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                      hintText: 'Enter your phone number',
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      final rating = int.tryParse(value);
                      if (rating == null || rating < 0 || rating > 50000000) {
                        return 'Please enter a valid rating between 0 and 5000000';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      hintText: 'Enter your email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an email';
                      }
                      // You can add more sophisticated email validation logic here
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
