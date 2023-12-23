import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../online/glassbox.dart';




class RoadTripCarousel extends StatefulWidget {

  RoadTripCarousel({Key? key}) : super(key: key);

  @override
  State<RoadTripCarousel> createState() => _RoadTripCarouselState();
}

class _RoadTripCarouselState extends State<RoadTripCarousel> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: <Widget>[


        Expanded(
         // height: 180,

          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('roadtrips')
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

              return  GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final document = snapshot.data!.docs[index];
                  final name = document.get('destination');
                  final location = document.get('location');
                  final email = document.get('email');
                  final days = document.get('days');
                  final price = document.get('price');

                  final imageurl = document.get('imageurl');


                  final hotelId = document.get('id'); // <-- Get the hotel ID



                  bool _isLoading = false;
                  return  GestureDetector(
                    onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RoadTripDetailScreen(document)),
                      );
                    },
                    // onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => EventSingles(safari: safaris[index]),),);},
                    //    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SafariScreen(safari: safaris[index]),),);},
                    child: Container(

                      margin: EdgeInsets.all(10.0),
                      width: 300.0,
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
                                  tag:
                                  '$imageurl',
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image(
                                      height: 250.0,
                                      width: 300.0,
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

                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[

                                          Row(
                                            children: <Widget>[
                                              const Icon(
                                                FontAwesomeIcons.safari,
                                                size: 10.0,
                                                color: Colors.white,
                                              ),
                                              SizedBox(width: 5.0),
                                              Text(
                                                '$location',
                                                style: GoogleFonts.abrilFatface(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),

                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: <Widget>[
                                                  const Icon(
                                                    FontAwesomeIcons.calendarDay,
                                                    size: 10.0,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(width: 5.0),
                                                  Text(
                                                    '$days',
                                                    style: GoogleFonts.abrilFatface(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    ' Days',
                                                    style: GoogleFonts.abrilFatface(
                                                      color: Colors.white,
                                                    ),
                                                  )

                                                ],
                                              ),
                                              SizedBox(width: 30,),
                                              Row(
                                                children: <Widget>[
                                                  Icon(
                                                    FontAwesomeIcons.moneyBill,
                                                    size: 10.0,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(width: 5.0),
                                                  Text(
                                                    '$price',
                                                    style: GoogleFonts.bebasNeue(
                                                      color: Colors.white,
                                                    ),
                                                  ),

                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 5.0,
                                  top: 5.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      //  color: Colors.deepPurple.shade900.withOpacity(0.6),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(2)
                                    ),

                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Wrap(
                                          children: [
                                            Text(
                                              '$name',
                                              style: GoogleFonts.bebasNeue(
                                                color: Theme.of(context).primaryColor.withOpacity(0.8),
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1.2,
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
                },

              );
            },
          ),
        ),
      ],
    );
  }
}




class RoadTripDetailScreen extends StatelessWidget  {
  final DocumentSnapshot documentt;

  bool isLoading = false;


  RoadTripDetailScreen(this.documentt);
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
        body: {'title':  'imageUrl', 'description': _description});

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['status'] == 'success') {



        print('Succesfull');

      }

      else {
        print('Error');
      }
    } else {
      print('Loading');
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

  void deleteSafari(String hotelId) {
    FirebaseFirestore.instance
        .collection('wishlistsafaris')
        .doc(hotelId)
        .delete()
        .then((value) => print('Safari deleted'))
        .catchError((error) => print('Failed to delete Safari: $error'));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  DefaultTabController(
        length: 2,
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
                    TypewriterAnimatedText(documentt['destination'],textStyle: GoogleFonts.bebasNeue(color: Colors.white)),
                    TypewriterAnimatedText(documentt['price'].toString(),textStyle: GoogleFonts.bebasNeue(color: Colors.white)),


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
                          documentt['imageurl'],
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          documentt['imageurl'],
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          documentt['imageurl'],
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

            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                const TabBar(
                  tabs: [
                    Tab(text: 'Road Trip Details'),

                    Tab(text: 'Itinerary'),



                  ],
                ),

              ),
              pinned: true,
            ),

            SliverFillRemaining(
              child:  TabBarView(
                children: [
                  Container(
                    child: ListView(
                      children: [
                        Wrap(
                          children: [
                            Container(

                              child: Column(
                                children: [



                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[





                                        const Text(
                                          'Inclusives',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.5,
                                          ),
                                        ),
                                        GestureDetector(
                                          // onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => HotelTab(),),);},
                                          child: Text(
                                            'Available',
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
                                  StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('roadtripamenities')

                                       // .where('safariid', isEqualTo: documentt['id'])
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const CircularProgressIndicator();
                                      }
                                      if (snapshot.data!.docs.isEmpty) {
                                        return Text('No data');
                                      }
                                      final data = snapshot.data!.docs.first;
                                      final wifi = data['pe'] ?? false;
                                      final spa = data['ti'] ?? false;
                                      final pool = data['ugd'] ?? false;
                                      final drinks = data['drinks'] ?? false;

                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(width: 30,),
                                              Row(
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons.caravan,
                                                    size: 21.0,
                                                    color: wifi ? Colors.green : Colors.red,
                                                  ),
                                                  const SizedBox(width: 10,),
                                                  const Text(
                                                    'Park Entrance',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.0,
                                                    ),
                                                  ),

                                                ],
                                              ),
                                              const SizedBox(width: 30,),
                                              Row(
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons.spa,
                                                    size: 21.0,
                                                    color: spa ? Colors.green : Colors.red,
                                                  ),
                                                  const SizedBox(width: 10,),
                                                  const Text(
                                                    'Tourism Insurance',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.0,
                                                    ),
                                                  ),

                                                ],
                                              ),
                                              SizedBox(width: 30,),


                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [

                                                Row(
                                                  children: [
                                                    Icon(
                                                      FontAwesomeIcons.swimmingPool,
                                                      size: 21.0,
                                                      color: pool ? Colors.green : Colors.red,
                                                    ),
                                                    const Text(
                                                      'Unlimited Game Drives',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),



                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      FontAwesomeIcons.swimmingPool,
                                                      size: 21.0,
                                                      color: drinks ? Colors.green : Colors.red,
                                                    ),
                                                    const Text(
                                                      'Drinks',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),



                                                  ],
                                                ),


                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  )


                                ],
                              ),
                            ),
                          ],

                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[





                              const Text(
                                'Trip Package',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              GestureDetector(
                                // onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => HotelTab(),),);},
                                child: Text(
                                  'Available',
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
                        Stack(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                              height: 250.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: 130.0,
                                          child: Text(
                                            documentt['destination'],
                                            style: const TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 4,
                                          ),
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              documentt['price'].toString() + '\$',
                                              style: const TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const Text(
                                              '/1 pax',
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),



                                          ],
                                        ),
                                      ],
                                    ),
                                    _buildRatingStars(5),
                                    Row(
                                      children: [
                                        const Icon(Icons.pin_drop,size: 15,),
                                        Text(
                                          documentt['location'],
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12

                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        const Icon(Icons.hotel,size: 15,),
                                        Text(
                                          documentt['location'],
                                          style:  TextStyle(
                                              color: Colors.grey.shade900,
                                              fontSize: 12

                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          documentt['days'],
                                          style: const TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Icon(Icons.sunny,size: 15,color: Colors.yellow,),

                                        SizedBox(width: 10,),
                                        Text(
                                          documentt['days'] ,
                                          style: const TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Icon(Icons.dark_mode,size: 15,color: Colors.black,),

                                      ],
                                    ),

                                    const SizedBox(height: 10.0),

                                    Row(
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          width: 100.0,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).primaryColor.withOpacity(0.8),
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          alignment: Alignment.center,
                                          child: GestureDetector(

                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Column(
                                                      children: [

                                                        Text(documentt['destination']),
                                                        Text(documentt['price'].toString()),
                                                      ],
                                                    ),
                                                    content: Padding(
                                                      padding: const EdgeInsets.all(16.0),
                                                      child: Form(
                                                        key: _formKey,
                                                        child: Wrap(
                                                          children: [
                                                            TextFormField(
                                                              decoration: InputDecoration(labelText: 'Contact Number'),
                                                              onSaved: (value) => _title = value!,
                                                            ),
                                                            SizedBox(height: 16.0),
                                                            TextFormField(
                                                              decoration: InputDecoration(labelText: 'Description'),
                                                              onSaved: (value) => _description = value!,
                                                            ),
                                                            const SizedBox(height: 16.0),
                                                            MaterialButton(
                                                              child: Text('Submit'),
                                                              onPressed: () async {
                                                                _submitForm();
                                                                // initiate cURL request to Twilio API to send SMS message
                                                                final response = await http.post(
                                                                  Uri.parse('https://markiniltd.com/twilio.php'),
                                                                  body: {
                                                                    'to': '+254794155449', // replace with recipient phone number
                                                                    'message': 'Safari name: ${documentt["name"]},Safari Price: ${documentt['price'].toString()},$_title: $_description,', // use the title and description as the message body
                                                                  },
                                                                );
                                                                print(response.body);

                                                                Navigator.of(context).pop();

                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                  const SnackBar(
                                                                    backgroundColor: Colors.green,
                                                                    content: Text('Message sent successfully'),
                                                                    duration: Duration(seconds: 3),
                                                                  ),
                                                                );



                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    actions:  [

                                                      ElevatedButton(
                                                        child: Text('Close'),
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                      ),

                                                    ],
                                                  );
                                                },
                                              );



                                            },
                                            child: const Text(
                                              'Contact Now',
                                              maxLines: 1,),
                                          ),
                                        ),


                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20.0,
                              top: 15.0,
                              bottom: 15.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image(
                                  width: 110.0,
                                  image: AssetImage(
                                    documentt['imageurl'],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),


                      ],
                    ),
                  ),

                  //Book Safari


                  Container(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                'Itinerary',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              GestureDetector(
                                // onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => HotelTab(),),);},
                                child: Text(
                                  ' ',
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
                        Stack(
                          children: <Widget>[
                            Container(



                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: 190.0,
                                          child: Text(
                                            documentt['destination'],
                                            style: const TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2000,
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



                        //Safari days
                        Container(
                          width: 130.0,
                          child: Text(
                            documentt['destination'],
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                          ),
                        ),

                      ],
                    ),
                  ),


                  // ListTiles++
                ],
              ),
            )

          ],
        ),
      ),

    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.transparent, // Customize the background color of the tab bar
      child: GlassBox(child: _tabBar),
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}



