
import 'dart:ui';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eastravel/widgets/hotel_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../screens/profilescreen.dart';
import 'destination_carousel.dart';





class HotelCarousel extends StatefulWidget {
  const HotelCarousel({Key? key}) : super(key: key);


  @override
  State<HotelCarousel> createState() => _HotelCarouselState();
}

class _HotelCarouselState extends State<HotelCarousel> {
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
          .collection('hotels')
          .doc(hotelId)
          .get();

      // Check if the hotel is already in the user's wishlist
      final QuerySnapshot wishlistSnapshot = await FirebaseFirestore.instance
          .collection('wishlisthotels')
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
      await FirebaseFirestore.instance.collection('wishlisthotels').doc(hotelId).set({
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
          .collection('wishlisthotels')
          .doc(hotelId)
          .delete()
          .then((value) => print('Unfollowed'))
          .catchError((error) => print('Failed to delete car: $error'));
    }



    Future<bool> isUserFollowing(String userEmail, String hotelId) async {
      final QuerySnapshot wishlistSnapshot = await FirebaseFirestore.instance
          .collection('wishlisthotels')
          .where('email', isEqualTo: userEmail)
          .where('id', isEqualTo: hotelId)
          .get();

      return wishlistSnapshot.docs.isNotEmpty;
    }


    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Top Hotels',
              style: GoogleFonts.dmSerifDisplay(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            GestureDetector(
              //   onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => CarSearch()));},
              child: Row(
                children: [
                  Text(
                    'See All',
                    style: GoogleFonts.dmSerifDisplay(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                  ),
                  Icon(Icons.chevron_right,color: Theme.of(context).primaryColor,)
                ],
              ),
            ),
          ],
        ),
        Expanded(
         
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('hotels')
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

              return ListView(
                scrollDirection: Axis.vertical,
                children: snapshot.data!.docs.map((document) {
                  final name = document.get('name');
                  final price = document.get('price');
                  final address = document.get('address');



                  final imageurl = document.get('imageurl');


                  final hotelId = document.get('id');
                  final user = FirebaseAuth.instance.currentUser;// <-- Get the hotel ID



                  bool _isLoading = false;






                  return  Padding(
                    padding: const EdgeInsets.only(left: 6.0,bottom: 20),
                    child: GestureDetector(
                      onLongPress: () async {
                        bool isFollowing = await isUserFollowing(user!.email!, hotelId);
                        if (isFollowing) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                child: AlertDialog(
                                  backgroundColor: Colors.white.withOpacity(0.7),
                                  title: Text('Unfollow?'),
                                  content: Text('Are you sure you want to unfollow?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        deleteHotel(hotelId);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Unfollow'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },

                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  HotelDetailScreen(document),),);},


                      child: Container(

                        width: 280,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


                            Container(



                              height: 160,

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


                                    width: 300,
                                    height: 160,
                                  ),
                                  Positioned(
                                    top: 1.0,
                                    right: 10.0,
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance.collection('wishlisthotels')
                                          .where('email', isEqualTo: user!.email)
                                          .where('id', isEqualTo: hotelId)
                                          .snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (snapshot.hasError) {
                                          return Text('Error: ${snapshot.error}');
                                        }

                                        switch (snapshot.connectionState) {
                                          case ConnectionState.waiting:
                                            return Lottie.asset('assets/icons/135803-loader.json',height: 50,);
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




                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 13.0,right: 13.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '$name',
                                    style: GoogleFonts.dmSerifDisplay(fontSize: 18,   color: Colors.black),
                                  ),

                                  Row(
                                    children: [
                                      Icon(Icons.star,color: Colors.yellow.shade700,size: 16,),
                                      Text(
                                        '4.2',
                                        style: GoogleFonts.dmSerifDisplay(fontSize: 18,   color: Colors.black),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 13.0,right: 13.0),
                              child: Row(

                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Text(
                                    '$address',
                                    style: GoogleFonts.dmSerifDisplay(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Ksh $price',
                                        style: GoogleFonts.dmSerifDisplay(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                                      ),

                                      Text(
                                        '/night',
                                        style: GoogleFonts.dmSerifDisplay(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
                                      ),
                                    ],
                                  ),




                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),

      ],
    );
  }
}


class TD extends StatefulWidget {
  const TD({Key? key}) : super(key: key);


  @override
  State<TD> createState() => _TDState();
}

class _TDState extends State<TD> {
  @override
  Widget build(BuildContext context) {






    return Column(
      children: [
        const TravelP(),
      //  sWeatherPage(),
        Expanded(

          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('placestovisit')
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

              return ListView(
                scrollDirection: Axis.vertical,
                children: snapshot.data!.docs.map((document) {
                  final name = document.get('name');

                  final address = document.get('address');



                  final imageurl = document.get('imageurl');


                  final hotelId = document.get('id');
                  final user = FirebaseAuth.instance.currentUser;// <-- Get the hotel ID



                  bool _isLoading = false;






                  return  GestureDetector(
                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DestinationDetailScreen(document),),);},

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                       decoration: BoxDecoration(
                      //   border: Border.all( color: Colors.red,)
                       ),
                        padding: EdgeInsets.only(right: 6.0),


                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                        height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                image: DecorationImage(image: AssetImage('$imageurl'))
                              ),
                            ),

                            Text(
                              '$name',
                              style: GoogleFonts.dmSerifDisplay(fontSize: 18,   color: Colors.black),maxLines: 1,
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '$address',
                                  style: GoogleFonts.dmSerifDisplay(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor,),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star,color: Colors.yellow,size: 15,),
                                    Text(
                                      '4.0',
                                      style: GoogleFonts.dmSerifDisplay(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                    ),
                                    Text(
                                      ' (120+)',
                                      style: GoogleFonts.dmSerifDisplay(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ],
                        ),
                       // width: 250,
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),

      ],
    );
  }
}



