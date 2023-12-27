import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:eastravel/screens/destination_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';



class DestinationCarousel extends StatefulWidget {

  final user = FirebaseAuth.instance.currentUser;
   DestinationCarousel({Key? key}) : super(key: key);

  @override
  State<DestinationCarousel> createState() => _DestinationCarouselState();
}

class _DestinationCarouselState extends State<DestinationCarousel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Top Things to Do',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'In Kenya',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),

        Container(
          height: 130,

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
                scrollDirection: Axis.horizontal,
                children: snapshot.data!.docs.map((document) {

                  final name = document.get('name');

                  final address = document.get('address');


                  final imageurl = document.get('imageurl');
                  final desc = document.get('desc');















                  return GestureDetector(
                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DestinationDetailScreen(document),),);},

                    child: Container(
                      margin: const EdgeInsets.all(5.0),
                      width: 240.0,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[

                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Stack(
                              children: <Widget>[
                                Hero(
                                  tag: '$imageurl',
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image(
                                      height: 150.0,
                                      width: 230.0,
                                      image: AssetImage('$imageurl'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 5.0,
                                  bottom: 5.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      //  color: Colors.deepPurple.shade900.withOpacity(0.6),
                                        color: Theme.of(context).primaryColor.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(10)
                                    ),

                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.searchLocation,
                                              size: 17.0,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 5.0),
                                            Container(
                                              width: 180,
                                              child: Wrap(
                                                children: [
                                                  Text(
                                                    '$name',
                                                    style: GoogleFonts.abrilFatface(
                                                      color: Colors.white,
                                                      fontSize: 15.0,letterSpacing: 1.4,
                                                      fontWeight: FontWeight.w600,
                                                      //letterSpacing: 1.2,
                                                    ),overflow: TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.locationArrow,
                                              size: 17.0,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 5.0),
                                            Text(
                                              '$address',
                                              style: GoogleFonts.abrilFatface(
                                                color: Colors.black,fontSize: 19
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
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
class RatingState extends ChangeNotifier {
  int _currentRating = 0;

  int get currentRating => _currentRating;


  void updateRating(int newRating) {
    _currentRating = newRating;
    notifyListeners();
  }

  Future<void> submitRating(BuildContext context, String destinationId, int rating) async {
    final CollectionReference ratings = FirebaseFirestore.instance.collection('ratings');
    String? userEmail = FirebaseAuth.instance.currentUser?.email;

    // Query for an existing rating with the same user email and destination ID
    QuerySnapshot existingRatings = await ratings
        .where('destination_id', isEqualTo: destinationId)
        .where('email', isEqualTo: userEmail)
        .get();

    // Use a Firestore transaction to either update or add a new rating
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      if (existingRatings.docs.isNotEmpty) {
        // If a rating exists for the user and destination, update the existing rating
        DocumentSnapshot ratingSnapshot = existingRatings.docs.first;
        transaction.update(ratingSnapshot.reference, {'rating': rating});
      } else {
        // If no rating exists, create a new document with the provided data
        await ratings.add({
          'destination_id': destinationId,
          'rating': rating,
          'email': userEmail,
          // Other data associated with the rating can be added here
        });
      }
    });

    // Update the state with the latest rating
    updateRating(rating);
  }
  Future<void> fetchRatingForDestination(String destinationId) async {
    String? userEmail = FirebaseAuth.instance.currentUser?.email;

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('ratings')
        .where('destination_id', isEqualTo: destinationId)
     //   .where('email', isEqualTo: userEmail) // Filter by user's email
        .get();

    int totalRating = 0;
    int count = 0;

    snapshot.docs.forEach((doc) {
      totalRating += doc['rating'] as int;
      count++;
    });

    if (count > 0) {
      double averageRating = totalRating / count;
      updateRating(averageRating.round());
    }
  }
}

class DestinationDetailScreen extends StatelessWidget {


  final DocumentSnapshot document;



  bool isLoading = false;

  DestinationDetailScreen(this.document);



  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late String _hotelname;




  void _submitForm() {


    _formKey.currentState?.save();

    _uploadData();

  }

  void _uploadData() async {

    final url = Uri.https('markiniltd.com', '/add.php');
    final response = await http.post(url,
        body: {'title': _title, 'description': _description});

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['status'] == 'success') {

        print('Succesfull');
      }

      else {
        print('Error');
      }
    } else {
      print('Error');
    }
  }




  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }











  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RatingState(),
      child: Consumer<RatingState>(
        builder: (context, ratingState, _) {
          return Scaffold(
            body:  DefaultTabController(
              length: 1,
              child: CustomScrollView(
      
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
                    pinned: true,
                    stretch: true,
                    onStretchTrigger: () {
                      // Function callback for stretch
                      return Future<void>.value();
                    },
                    expandedHeight: 300.0,
                    shadowColor: Colors.red[100],
                    flexibleSpace: FlexibleSpaceBar(
                      stretchModes: const <StretchMode>[
                        StretchMode.zoomBackground,
                        StretchMode.blurBackground,
                        StretchMode.fadeTitle,
      
                      ],
                      centerTitle: true,
                      title:  AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText(document['name'],textStyle: GoogleFonts.bebasNeue(color: Colors.white)),
      
      
      
                        ],
                        pause: const Duration(milliseconds: 3000),
      
                        stopPauseOnTap: true,
                        repeatForever: true,
                      ),
                      background: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          // Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg', fit: BoxFit.cover,),
      
                          CarouselSlider(
                            items: [
                              Image.asset(
                                document['imageurl'],
                                fit: BoxFit.cover,
                              ),
                              Image.asset(
                                document['imageurl'],
                                fit: BoxFit.cover,
                              ),
                              Image.asset(
                                document['imageurl'],
                                fit: BoxFit.cover,
                              ),
                            ],
                            options: CarouselOptions(
                              height: 355,
                              viewportFraction: 1.0,
                              autoPlay: true,
                              enlargeCenterPage: false,
                            ),
                          ),
      
      
      
                        ],
                      ),
                    ),
                  ),
      
      
                  SliverList(
                    delegate: SliverChildListDelegate(
                      <Widget>[
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
                        Column(
      
      
                          children: [



                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(5, (index) {
                                      final int displayIndex = index + 1;
                                      return IconButton(
                                        icon: Icon(
                                          displayIndex <= ratingState.currentRating ? Icons.star : Icons.star_border,
                                          color: Colors.amber,
                                        ),
                                        onPressed: () {
                                          ratingState.submitRating(context, document.id, displayIndex);
                                        },
                                      );
                                    }),
                                  ),
                                ),
                                // Show the current rating text
                                Text('Current Rating: ${ratingState.currentRating}'),
                              ],
                            ),
      
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
      
                                child: Text(
                                  document['desc'],
                                  style: GoogleFonts.andika(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                 // overflow: TextOverflow.visible,
      
                                ),
                              ),
                            ),
      
      
      
      
      
                          ],),
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
                        // ListTiles++
                      ],
                    ),
                  ),
                ],
              ),
            ),
      
          );
        }
      ),
    );
  }
}