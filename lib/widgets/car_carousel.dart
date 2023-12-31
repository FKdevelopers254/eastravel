import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../models/car_model.dart';
import '../screens/car_screen.dart';
import 'car_tab.dart';
import 'cardata.dart';



class CarCarousel extends StatefulWidget {
  const CarCarousel({Key? key}) : super(key: key);


  @override
  State<CarCarousel> createState() => _CarCarouselState();
}

class _CarCarouselState extends State<CarCarousel> {
  @override
  Widget build(BuildContext context) {

    bool _isLoading = false;

    void _djfollowers(String hotelId, BuildContext context) async {
      // Set the loading state to true
      setState(() {
        _isLoading = true;
      });
      // Get the current user's email and name
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final String? email = user!.email;
      // final String email = user?.email ?? 'nashtunic@gmail.com';


      // Get the hotel data using its ID
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('cars')
          .doc(hotelId)
          .get();

      // Check if the hotel is already in the user's wishlist
      final QuerySnapshot wishlistSnapshot = await FirebaseFirestore.instance
          .collection('wishlistcars')
          .where('email', isEqualTo: email)
          .where('id', isEqualTo: hotelId)
          .get();
      final isWishlisted = wishlistSnapshot.docs.isNotEmpty;
      if (isWishlisted) {
        // Hotel is already in the wishlist, show a snackbar and return

        ScaffoldMessenger.of(context).showSnackBar(



          SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: Text('failed'),
            duration: Duration(seconds: 2),
          ),
        );
        // Set the loading state back to false
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Add the hotel data to   the wishlisthotels collection
      await FirebaseFirestore.instance.collection('wishlistcars').doc(hotelId).set({
        'email': email,


        'id': hotelId,
      });

      // Show a snackbar to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: Text('Success'),
          duration: Duration(seconds: 2),
        ),

      );

      // Set the loading state back to false
      setState(() {
        _isLoading = false;
      });
    }

    void deleteHotel(String hotelId) {
      FirebaseFirestore.instance
          .collection('wishlistcars')
          .doc(hotelId)
          .delete()
          .then((value) => print('Unfollowed'))
          .catchError((error) => print('Failed to delete car: $error'));
    }



    Future<bool> isUserFollowing(String userEmail, String hotelId) async {
      final QuerySnapshot wishlistSnapshot = await FirebaseFirestore.instance
          .collection('wishlistcars')
          .where('email', isEqualTo: userEmail)
          .where('id', isEqualTo: hotelId)
          .get();

      return wishlistSnapshot.docs.isNotEmpty;
    }


    return Column(
      children: [

        Expanded(

          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('cars')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('An error occurred while loading the data.'),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text('No  details found.'),
                );
              }

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 2.0,
                ),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final document = snapshot.data!.docs[index];
                  final name = document.get('name');
                  final price = document.get('price');
                  final doors = document.get('doors');
                  final type = document.get('type');
                  final year = document.get('modelyear');
                  final address = document.get('address');



                  final imageurl = document.get('imageurl');


                  final hotelId = document.get('id');
                  final user = FirebaseAuth.instance.currentUser;// <-- Get the hotel ID



                  bool _isLoading = false;

return   Padding(
  padding: const EdgeInsets.only(left: 6.0,bottom: 20),
  child: GestureDetector(

    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  CarDetailScreen(document),),);},


    child: Container(

      // width: 280,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Container(



            height: 130,

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey)
            ),



            child: Stack(
              children: [


                Container(

                  decoration: BoxDecoration(

                    image: DecorationImage(image: AssetImage('$imageurl',),fit: BoxFit.fitWidth),


                    borderRadius: BorderRadius.circular(10),
                    //  border: Border.all(color: Colors.grey)
                    color: Colors.transparent,
                  ),


                  //  width: 300,
                  height: 130,
                ),
                Positioned(
                  top: 1.0,
                  right: 10.0,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('wishlistcars')
                        .where('email', isEqualTo: user!.email)
                        .where('id', isEqualTo: hotelId)
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return CircularProgressIndicator();
                        default:
                          if (snapshot.data!.docs.isNotEmpty) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 2.0,right: 2),
                              child: GestureDetector(

                                onTap:_isLoading
                                    ? null // Disable the button while loading
                                    : () => deleteHotel(hotelId),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.favorite_outlined,color: Theme.of(context).primaryColor,size: 30,),
                                ),
                              ),
                            );
                          } else {
                            return GestureDetector(

                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.favorite_outline,color: Theme.of(context).primaryColor,size: 30,),
                              ),
                              onTap:_isLoading
                                  ? null // Disable the button while loading
                                  : () => _djfollowers(hotelId, context),
                            );
                          }
                      }
                    },
                  ),
                ),
                Positioned(
                  top: 10.0,
                  left: 10.0,
                  child:    Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Icon(Icons.airline_seat_recline_extra_sharp,color: Colors.yellow.shade700,size: 12,),
                          Text(
                            '$doors',
                            style: GoogleFonts.dmSerifDisplay(fontSize: 12,  color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10.0,
                  left: 10.0,
                  child:    Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Icon(Icons.star,color: Colors.yellow.shade700,size: 12,),
                          Text(
                            '4.2',
                            style: GoogleFonts.dmSerifDisplay(fontSize: 12,  color: Theme.of(context).primaryColor ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10.0,
                  right: 10.0,
                  child:    Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Text(
                            'Ksh $price',
                            style: GoogleFonts.dmSerifDisplay(fontSize: 12, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                          ),

                          Text(
                            '/night',
                            style: GoogleFonts.dmSerifDisplay(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),




              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13.0,right: 13.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(

                  child: Row(
                    children: [
                      Text(
                        '$name',
                        style: GoogleFonts.dmSerifDisplay(fontSize: 14,   color: Colors.black),
                      ),
                      Text(
                        ' $type',
                        style: GoogleFonts.dmSerifDisplay(fontSize: 14,   color: Colors.black),
                      ),
                      Text(
                        ' $year',
                        style: GoogleFonts.dmSerifDisplay(fontSize: 14,   color: Colors.black),overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),



              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0,right: 5.0),
            child: Text(
              '$address',
              style: GoogleFonts.dmSerifDisplay(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  ),
);

                },

              );
            },
          ),
        ),

      ],
    );
  }
}