import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:twilio/models/message.dart';
import 'package:twilio/models/messages_data.dart';
import 'dart:convert';
import 'package:twilio/twilio.dart';


import 'package:twilio/models/message.dart';
import 'package:twilio/models/messages_data.dart';
import 'package:twilio/twilio.dart';


import '../screens/hotel_screen.dart';
import 'hotel_tab.dart';
import 'hotel_tab_location.dart';
import 'hotel_tab_price.dart';

class HotelTabLocation extends StatefulWidget {
   HotelTabLocation({Key? key}) : super(key: key);

  @override
  State<HotelTabLocation> createState() => _HotelTabLocationState();
}

class _HotelTabLocationState extends State<HotelTabLocation> {

  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  List<DocumentSnapshot> _hotels = [];
  List<DocumentSnapshot> _filteredHotels = [];



  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('hotels')
        .get()
        .then((QuerySnapshot snapshot) {
      setState(() {
        _hotels = snapshot.docs;
        _filteredHotels = _hotels;
      });
    });
  }

  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2/2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 10,

      ),
      padding: const EdgeInsets.all(8),

      itemCount: _filteredHotels.length,
      itemBuilder: (context, index) => _buildItem(index),


    );
  }


  Widget _buildListView() {
    return ListView.builder(
      itemCount: _filteredHotels.length ,
      itemBuilder: (context, index) => _buildItemm(index),




    );
  }


  Widget _buildItem(int index) {
    final hotel = _filteredHotels[index];


    final hotelId = hotel.id;
    final user = FirebaseAuth.instance.currentUser;
    final CollectionReference _ratingsRef =
    FirebaseFirestore.instance.collection('ratinghotel');







    bool _isLoading = false;

    void _wishlistHotel(String hotelId, BuildContext context) async {
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
          .where('name', isEqualTo: snapshot['name'])
          .get();
      final isWishlisted = wishlistSnapshot.docs.isNotEmpty;
      if (isWishlisted) {
        // Hotel is already in the wishlist, show a snackbar and return
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hotel is already in wishlist!'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
        // Set the loading state back to false
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Add the hotel data to the wishlisthotels collection
      await FirebaseFirestore.instance.collection('wishlisthotels').add({
        'email': email,
        'name': snapshot['name'],
        'address': snapshot['address'],
        'price': snapshot['price'],
        'imageurl': snapshot['imageurl'],
        'id': hotelId,
      });

      // Show a snackbar to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(

          content: Text('Hotel added to wishlist!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // Set the loading state back to false
      setState(() {
        _isLoading = false;
      });
    }
    return InkWell(
      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => HotelDetailScreen(hotel),),);},
      child: Container(
        margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),

        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[



            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Hero(
                tag: hotel['imageurl'],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image(
                    height: 180.0,
                    width: 180.0,
                    image: AssetImage(hotel['imageurl']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),






            Positioned(
              bottom: 24,
              left: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(2),
                ),


                child: Wrap(
                  children: [
                    Text(
                      hotel['name'],
                      style: GoogleFonts.bebasNeue(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),


                child: Wrap(
                  children: [
                    Text(
                      hotel['address'],
                      style: GoogleFonts.bebasNeue(
                        color: Theme.of(context).primaryColor.withOpacity(0.8),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,

                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(2),
                ),


                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          '${hotel['price']} \$',
                          style: GoogleFonts.bebasNeue(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),





            Positioned(
              top: 10.0,
              left: 10.0,
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
                      return CircularProgressIndicator();
                    default:
                      if (snapshot.data!.docs.isNotEmpty) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.0),
                            color: Colors.white,
                          ),

                          child: Text(
                            'Wishlisted',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor.withOpacity(0.8),
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          height: 30,



                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(

                                child: Lottie.asset('assets/icons/like.json',height: 230,),
                                onTap:_isLoading
                                    ? null // Disable the button while loading
                                    : () => _wishlistHotel(hotelId, context),),



                              if (_isLoading)
                                Positioned.fill(
                                  child: Container(
                                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    ),
                                  ),
                                ),


                            ],
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


    );
  }


  Widget _buildItemm(int index) {
    final hotel = _filteredHotels[index];


    final hotelId = hotel.id;
    final user = FirebaseAuth.instance.currentUser;






    bool _isLoading = false;

    void _wishlistHotel(String hotelId, BuildContext context) async {
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
          .where('name', isEqualTo: snapshot['name'])
          .get();
      final isWishlisted = wishlistSnapshot.docs.isNotEmpty;
      if (isWishlisted) {
        // Hotel is already in the wishlist, show a snackbar and return
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hotel is already in wishlist!'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
        // Set the loading state back to false
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Add the hotel data to the wishlisthotels collection
      await FirebaseFirestore.instance.collection('wishlisthotels').add({
        'email': email,
        'name': snapshot['name'],
        'address': snapshot['address'],
        'price': snapshot['price'],
        'imageurl': snapshot['imageurl'],
        'id': hotelId,
      });

      // Show a snackbar to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(

          content: Text('Hotel added to wishlist!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // Set the loading state back to false
      setState(() {
        _isLoading = false;
      });
    }
    return InkWell(
      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => HotelDetailScreen(hotel),),);},
      child: Container(
        margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),

        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              height: 190,
            ),
            Positioned(
              left: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(
                  height: 180.0,
                  width: 180.0,
                  image: AssetImage(hotel['imageurl']),
                  fit: BoxFit.cover,
                ),
              ),),
            Positioned(
              bottom: 35,
              left: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(2),
                ),


                child: Wrap(
                  children: [
                    Text(
                      hotel['name'],
                      style: GoogleFonts.bebasNeue(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),


                child: Wrap(
                  children: [
                    Text(
                      hotel['address'],
                      style: GoogleFonts.bebasNeue(
                        color: Theme.of(context).primaryColor.withOpacity(0.8),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,

                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 45,
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(2),
                ),


                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          '${hotel['price']} \$',
                          style: GoogleFonts.bebasNeue(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(

              left: 200,
              child: Container(
                width: 205,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(2),
                ),


                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Wrap(
                      children: [
                        Text(
                          '${hotel['description']} \$',
                          style: GoogleFonts.bebasNeue(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 8,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),





            Positioned(
              top: 10.0,
              left: 10.0,
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
                      return CircularProgressIndicator();
                    default:
                      if (snapshot.data!.docs.isNotEmpty) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.0),
                            color: Colors.white,
                          ),

                          child: Text(
                            'Wishlisted',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor.withOpacity(0.8),
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          height: 30,

                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(2),
                          ),

                          child: Row(
                            children: [
                              IconButton(


                                icon: Icon(


                                  Icons.favorite ,
                                  color: Colors.white,
                                ),
                                iconSize: 20,

                                onPressed: _isLoading
                                    ? null // Disable the button while loading
                                    : () => _wishlistHotel(hotelId, context),

                              ),


                              if (_isLoading)
                                Positioned.fill(
                                  child: Container(
                                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    ),
                                  ),
                                ),


                            ],
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


    );
  }

  bool _isGridView = true;







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: "Type Hotel Location",
            hintStyle: TextStyle(color: Colors.white,),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              _searchText = value;
              _filteredHotels = _hotels.where((hotel) {
                final name = hotel['address'] as String;
                final address = hotel['address'] as String;
                final searchText = _searchText.toLowerCase();
                return name.toLowerCase().contains(searchText) ||
                    address.toLowerCase().contains(searchText);
              }).toList();
            });
          },




        ),
        actions: [

          MaterialButton(
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
            child: Icon(_isGridView ? Icons.view_list : Icons.view_module),

          )


        ],


      ),
      body:_filteredHotels.isEmpty
          ? Center(child: Lottie.asset('assets/icons/36352-lion-running.json',height: 300))
          : _isGridView ? _buildGridView() : _buildListView() ,

    );
  }
}






