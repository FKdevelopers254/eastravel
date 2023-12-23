
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'homepage.dart';

class RegisterPage extends StatefulWidget {

  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {



  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _priceController = TextEditingController();
  final _modelyearController = TextEditingController();

  final _geartypeController = TextEditingController();
  final _typeController = TextEditingController();
  final _doorsController = TextEditingController();
  final _engineController = TextEditingController();
  final _passController = TextEditingController();
  final _luggageController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageurlController = TextEditingController();
  final _fuelconsumptionController = TextEditingController();
  final _drivetypeController = TextEditingController();
  final _enginecapacityController = TextEditingController();
  final _numberofseatsController = TextEditingController();





  @override
  void dispose(){



    _nameController.dispose();
    _addressController.dispose();
    _priceController.dispose();
     _modelyearController.dispose();
     _geartypeController.dispose();
     _typeController.dispose();
     _doorsController.dispose();
     _engineController.dispose();
     _passController.dispose();
     _luggageController.dispose();
    _descriptionController.dispose();
    _imageurlController.dispose();
    _fuelconsumptionController.dispose();
    _drivetypeController.dispose();
    _enginecapacityController.dispose();
    _numberofseatsController.dispose();
    super.dispose();
  }


  Future<void> addHotel() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    final user = FirebaseAuth.instance.currentUser!;
    print(user.email);
    final userDetailsSnapshot = await FirebaseFirestore.instance
        .collection('carusers')
        .where('email', isEqualTo: user.email)
        .get();

    if (userDetailsSnapshot.docs.isNotEmpty) {
      final documentId = userDetailsSnapshot.docs[0].id;
      final userDetails = userDetailsSnapshot.docs.first.data();
      final email = userDetails['email'];

      final name = _nameController.text;


      final address = _addressController.text;
      final price = _priceController.text;
      final modelyear = _modelyearController.text;
    final geartype =  _geartypeController.text;
    final type = _typeController.text;
    final doors =  _doorsController.text;
    final engine =  _engineController.text;
    final pass =  _passController.text;
    final luggage =  _luggageController.text;


      final description = _descriptionController.text;
      final imageurl = _imageurlController.text;
      final fuelconsumption = _fuelconsumptionController.text;
      final drivetype = _drivetypeController.text;
      final enginecapacity = _enginecapacityController.text;
      final numberofseats = _numberofseatsController.text;


      print('User details found: ${userDetails.toString()}');

      try {
        String docId = FirebaseFirestore.instance.collection('cars').doc().id;
        await FirebaseFirestore.instance.collection('cars').doc(docId).set({

          'email': email,
          'name': name,
          'address': address,
          'price': price,
          'modelyear': modelyear,
          'geartype': geartype,
          'type': type,
          'doors': doors,
          'engine': engine,
          'pass': pass,
          'luggage': luggage,
          'description': description,
          'imageurl': imageurl,

          'fuelconsumption': fuelconsumption,
          'drivetype': drivetype,
          'enginecapacity': enginecapacity,
          'numberofseats': numberofseats,
          'id': docId

        });

        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Your Car  details have been saved.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CarHomePage())),
                ),
              ],
            );
          },
        );// dismiss the progress indicator dialog
      } catch (e) {
        print('Error writing car details to Firestore: $e');
        Navigator.pop(context); // dismiss the progress indicator dialog
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('An error occurred while saving your car details. Please try again later.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          },
        );
      }
    } else {
      // handle the case where the user details document doesn't exist
      Navigator.pop(context); // dismiss the progress indicator dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('User Details Not Found'),
            content: Text('We could not find your user details. Please try again later.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
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
                            TyperAnimatedText('Add Car',textStyle: GoogleFonts.abrilFatface(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 28,letterSpacing: 1.5)),


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
                    onTap: (){FirebaseAuth.instance.signOut();},
                    // onLongPress: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const BirdApp()));},
                    child:
                    Lottie.asset('assets/icons/90770-traveller.json',height: 50,),
                  ),)

              ],),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          hintText: 'Car Name',
                          fillColor: Colors.grey[200],
                          filled: true,

                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: TextField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          hintText: 'Car Address',
                          fillColor: Colors.grey[200],
                          filled: true,

                        ),
                      ),
                    ),
                  ),
                ),



                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: TextField(
                        controller: _priceController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          hintText: 'Enter Price',
                          fillColor: Colors.grey[200],
                          filled: true,

                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),



                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: TextField(
                        controller: _modelyearController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          hintText: 'Enter Model Year',
                          fillColor: Colors.grey[200],
                          filled: true,

                        ),

                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: TextField(
                        controller: _geartypeController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          hintText: 'Enter Gear Type',
                          fillColor: Colors.grey[200],
                          filled: true,

                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: TextField(
                        controller: _typeController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          hintText: 'Enter Vehicle Type e.g SUV/Van',
                          fillColor: Colors.grey[200],
                          filled: true,

                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: TextField(
                        controller: _doorsController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          hintText: 'Enter Number of Doors',
                          fillColor: Colors.grey[200],
                          filled: true,

                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: TextField(
                        controller: _engineController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          hintText: 'Enter Engine Fuel Type',
                          fillColor: Colors.grey[200],
                          filled: true,

                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: TextField(
                        controller: _passController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          hintText: 'Enter Number of Passengers',
                          fillColor: Colors.grey[200],
                          filled: true,

                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: TextField(
                        controller: _luggageController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          hintText: 'Enter Luggage Number',
                          fillColor: Colors.grey[200],
                          filled: true,

                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),





                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          hintText: 'Enter Description',
                          fillColor: Colors.grey[200],
                          filled: true,

                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),



                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: TextField(
                        controller: _imageurlController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          hintText: 'Enter Image Url',
                          fillColor: Colors.grey[200],
                          filled: true,

                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),




                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: TextField(
                        controller: _fuelconsumptionController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          hintText: 'Fuel Consumption',
                          fillColor: Colors.grey[200],
                          filled: true,

                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: TextField(
                        controller: _drivetypeController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          hintText: 'Drive Type',
                          fillColor: Colors.grey[200],
                          filled: true,

                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: TextField(
                        controller: _enginecapacityController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          hintText: 'Engine Capacity',
                          fillColor: Colors.grey[200],
                          filled: true,

                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),

                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: TextField(
                        controller: _numberofseatsController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),

                          hintText: 'Number of seats',
                          fillColor: Colors.grey[200],
                          filled: true,

                        ),
                      ),
                    ),
                  ),
                ),














                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: addHotel,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Add Car',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25,),



              ],
            ),
          ),
        ),
      ),
    );
  }
}