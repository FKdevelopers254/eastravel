import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eastravel/widgets/safari_tab.dart';
import 'package:eastravel/widgets/safaridata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';






class SafariCarousel extends StatefulWidget {
  const SafariCarousel({Key? key}) : super(key: key);


  @override
  State<SafariCarousel> createState() => _SafariCarouselState();
}

class _SafariCarouselState extends State<SafariCarousel> {
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
          .collection('safaris')
          .doc(hotelId)
          .get();

      // Check if the hotel is already in the user's wishlist
      final QuerySnapshot wishlistSnapshot = await FirebaseFirestore.instance
          .collection('wishlistsafaris')
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
      await FirebaseFirestore.instance.collection('wishlistsafaris').doc(hotelId).set({
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
          .collection('wishlistsafaris')
          .doc(hotelId)
          .delete()
          .then((value) => print('Unfollowed'))
          .catchError((error) => print('Failed to delete car: $error'));
    }



    Future<bool> isUserFollowing(String userEmail, String hotelId) async {
      final QuerySnapshot wishlistSnapshot = await FirebaseFirestore.instance
          .collection('wishlistsafaris')
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
                .collection('safaris')
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
                  final days = document.get('days');
                  final desc = document.get('description');
                  final location = document.get('address');



                  final imageurl = document.get('imageUrl');


                  final hotelId = document.get('id');
                  final user = FirebaseAuth.instance.currentUser;// <-- Get the hotel ID



                  bool _isLoading = false;






                  return  Padding(
                    padding: const EdgeInsets.only(left: 3.0,right: 3.0,bottom: 10),
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.transparent,

                          width: 300,

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(




                                height: 100,
                                width: 100,

                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    image: DecorationImage(image: AssetImage('$imageurl',),fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.grey)
                                ),



                                child:  Positioned(



                                  top: 0,left: 0,



                                  child:  Padding(
                                    padding: const EdgeInsets.only(left: 3.0,right: 3.0),
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance.collection('wishlistsafaris')
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
                                  ),),
                              ),

                              Container(
                                width: 198,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                   onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SafariDetailScreen(document),),);},
                                  //  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Sa(document),),);},

                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '$name',
                                          style: GoogleFonts.dmSerifDisplay(fontSize: 18,fontWeight: FontWeight.bold,   color: Colors.black),
                                        ),

                                        Text(
                                          '$desc',
                                          style: GoogleFonts.dmSerifDisplay(fontSize: 16,   color: Colors.grey.shade900),overflow: TextOverflow.ellipsis,maxLines: 2,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.monetization_on,size: 16,color: Theme.of(context).primaryColor),
                                                Text(
                                                  '$price',
                                                  style: GoogleFonts.dmSerifDisplay(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.star,color: Colors.yellow.shade700,size: 16,),
                                                Text(
                                                  ' 3.4',
                                                  style: GoogleFonts.dmSerifDisplay(fontSize: 17,fontWeight: FontWeight.bold,   color: Colors.black),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.dark_mode,color: Theme.of(context).primaryColor,size: 16,),
                                                    Text(
                                                      '$days',
                                                      style: GoogleFonts.dmSerifDisplay(fontSize: 17,fontWeight: FontWeight.bold,   color: Colors.black),
                                                    ),

                                                  ],
                                                )

                                              ],
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        Positioned(right:2,bottom:70,child: GestureDetector(
                            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SafariDetailScreen(document),),);},


                            child: Icon(Icons.add,color: Theme.of(context).primaryColor,size: 29,)))

                      ],
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





