
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

        Expanded(
         
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('hotels')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error occurred while loading the data.'),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No  details found.'),
                );
              }

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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

                                                onTap:_isLoading
                                                    ? null // Disable the button while loading
                                                    : () => _djfollowers(hotelId, context),

                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Icon(Icons.favorite_outline,color: Theme.of(context).primaryColor,size: 30,),
                                                ),
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
                              padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 140,
                                    child: Text(
                                      '$name',
                                      style: GoogleFonts.dmSerifDisplay(fontSize: 18,color: Colors.black,),overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                  Row(
                                    children: [
                                      Icon(Icons.star,color: Colors.yellow.shade700,size: 16,),
                                      Center(
                                        child: StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection('hotelratings')
                                              .where('destination_id', isEqualTo: document['id'])
                                              .snapshots(),
                                          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            }
                                            if (snapshot.hasError) {
                                              return Text('Error: ${snapshot.error}');
                                            }
                                            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                              return Text(
                                                '0.0',
                                                style: GoogleFonts.dmSerifDisplay(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),

                                              );
                                            }

                                            // Calculate the average rating
                                            double totalRating = 0;
                                            snapshot.data!.docs.forEach((doc) {
                                              totalRating += doc['rating'] ?? 0;
                                            });

                                            double averageRating = totalRating / snapshot.data!.docs.length;

                                            return Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${averageRating.toStringAsFixed(1)}',
                                                  style: GoogleFonts.dmSerifDisplay(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),

                                                ),

                                                // You can display other information about the destination here
                                              ],
                                            );
                                          },
                                        ),
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
                },

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
          .collection('placestovisit')
          .doc(hotelId)
          .get();

      // Check if the hotel is already in the user's wishlist
      final QuerySnapshot wishlistSnapshot = await FirebaseFirestore.instance
          .collection('wishlistplacestovisit')
          .where('email', isEqualTo: email)
          .where('id', isEqualTo: hotelId)
          .get();
      final isWishlisted = wishlistSnapshot.docs.isNotEmpty;
      if (isWishlisted) {
        // Hotel is already in the wishlist, show a snackbar and return

        ScaffoldMessenger.of(context).showSnackBar(



          const SnackBar(
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
      await FirebaseFirestore.instance.collection('wishlistplacestovisit').doc(hotelId).set({
        'email': email,


        'id': hotelId,
      });

      // Show a snackbar to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
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
          .collection('wishlistplacestovisit')
          .doc(hotelId)
          .delete()
          .then((value) => print('Unfollowed'))
          .catchError((error) => print('Failed to delete car: $error'));
    }




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
                return const Center(
                  child: Text('An error occurred while loading the data.'),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No  details found.'),
                );
              }

              return GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 2, // Number of columns
               crossAxisSpacing: 5.0,
               mainAxisSpacing: 5.0,
                            ),
                   scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.docs.length,
                   itemBuilder: (BuildContext context, int index) {
                     final document = snapshot.data!.docs[index];
                     final name = document.get('name');
                     final address = document.get('address');
                     final imageurl = document.get('imageurl');
                     final hotelId = document.get('id');
                     final user = FirebaseAuth.instance.currentUser;// <-- Get the hotel ID
                     bool _isLoading = false;
              return  GestureDetector(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DestinationDetailScreens(document),),);},
            //    onLongPress: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DestinationDetailScreen(document),),);},

                child: Container(


                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [

                          Container(
                            height: 140,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(60),
                                         image: DecorationImage(image: AssetImage('$imageurl'))
                            ),
                          ),


                          Positioned(
                            left: 10.0,
                            top: 10.0,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection('wishlistplacestovisit')
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
                                            child: Container(



                                                decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(30)
                                            ),



                                                child: Icon(Icons.favorite_outlined,color: Theme.of(context).primaryColor,size: 30,),),

                                          ),
                                        ),
                                      );
                                    } else {
                                      return GestureDetector(

                                        onTap:_isLoading
                                            ? null // Disable the button while loading
                                            : () => _djfollowers(hotelId, context),

                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration:BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(30)
                                            ),
                                              child: Icon(Icons.favorite_outline,color: Theme.of(context).primaryColor,size: 30,)),
                                        ),
                                      );
                                    }
                                }
                              },
                            ),
                          ),

                        ],
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
                                 const Icon(Icons.star,color: Colors.yellow,size: 15,),
                                 Center(
                 child: StreamBuilder(
                   stream: FirebaseFirestore.instance
                       .collection('ratings')
                       .where('destination_id', isEqualTo: document['id'])
                       .snapshots(),
                   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                     if (snapshot.connectionState == ConnectionState.waiting) {
                       return CircularProgressIndicator();
                     }
                     if (snapshot.hasError) {
                       return Text('Error: ${snapshot.error}');
                     }
                     if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                       return Text(
                         '0.0',
                         style: GoogleFonts.dmSerifDisplay(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),

                       );
                     }

                     // Calculate the average rating
                     double totalRating = 0;
                     snapshot.data!.docs.forEach((doc) {
                       totalRating += doc['rating'] ?? 0;
                     });

                     double averageRating = totalRating / snapshot.data!.docs.length;

                     return Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Text(
                          '${averageRating.toStringAsFixed(1)}',
                           style: GoogleFonts.dmSerifDisplay(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),

                         ),

                         // You can display other information about the destination here
                       ],
                     );
                   },
                 ),
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



