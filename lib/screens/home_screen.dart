import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:eastravel/screens/profilescreen.dart';

import 'package:eastravel/widgets/roadtrip_carousel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lottie/lottie.dart';


import '../online/safari_tab.dart';
import '../widgets/car_carousel.dart';
import '../widgets/destination_carousel.dart';
import '../widgets/glassbox.dart';
import '../widgets/hotel_carousel.dart';
import '../widgets/places_carousel.dart';
import '../widgets/safari_carousel.dart';
import '../widgets/smarttourguide.dart';
import '../widgets/smarttourguide_carousel.dart';
import '../widgets/storelocator.dart';
import '../widgets/storemaplocator.dart';
import '../widgets/wildlifelocator.dart';
import 'maps.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.4),
      extendBody: true,

      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()
        ),
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        children: <Widget>[


          const TravelP(),
          TD(),
          //  DestinationCarousel(),




          HotelCarousel(),




          SafariCarousel(),

          CarCarousel(),


          PlaceCarousel(),

          RoadTripCarousel(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Wildlife Locator',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                GestureDetector(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => StoreFinderPage(),),);},
                  onLongPress: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppp(),),);},
                  // onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AI(),),);},
                  // onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SafariTab(),),);},
                  child: Text(
                    'Type Location',
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
          const STG(),




          const SizedBox(height: 60.0),
          //Maps()
        ],
      ),

    );
  }
}




class NewHome extends StatefulWidget {

  const NewHome( {Key? key, }) : super(key: key) ;

  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> with SingleTickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser!;
  late TabController tabController;
  @override
  void  initState(){
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // extendBody: false,
    //  backgroundColor: Color(0xFFF9EFEB),
      body: ListView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(
            parent:AlwaysScrollableScrollPhysics()
        ),
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 55.0,

                decoration:   BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.8),
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(5.0,),bottomLeft: Radius.circular(75.0,),topRight: Radius.circular(75)



                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                  GestureDetector(


                    child:  Container(

                      child: GestureDetector(
                        onLongPress: (){FirebaseAuth.instance.signOut();},
                        // onLongPress: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  PaymentPage()));},
                        //  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  PaymentPage()));},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedTextKit(
                              animatedTexts: [

                               // TyperAnimatedText(user.email!,textStyle: GoogleFonts.abrilFatface(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 17)),
                                TyperAnimatedText('EAS SAFARIS',textStyle: GoogleFonts.abrilFatface(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 28,letterSpacing: 1.5)),
                                TyperAnimatedText('Book Hotels',textStyle: GoogleFonts.abrilFatface(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 22)),

                                TyperAnimatedText('Book Travels',textStyle: GoogleFonts.abrilFatface(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 22)),
                                TyperAnimatedText('Car Hire',textStyle: GoogleFonts.abrilFatface(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 22)),


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
                    ),
                    // onTap: Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen())),
                  ),

                  Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: GestureDetector(
                      onTap: (){FirebaseAuth.instance.signOut();},
                      // onLongPress: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const BirdApp()));},
                      child:





                      Lottie.asset('assets/icons/96833-login.json',height: 50,),
                    ),)

                ],),
              ),


            ],
          ),
          TabBar(
            controller: tabController,
            indicatorColor: Theme.of(context).primaryColor.withOpacity(0.8),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 4.0,
            isScrollable: true,
            labelColor: Color(0xFF440206),
            unselectedLabelColor: Color(0xFF440206),
            tabs: const [

              Tab(
                child: Text(
                  'Travel Planner',style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 15.0,

                ),
                ),
              ),

              Tab(
                child: Text(
                  'Top Hotels',style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 15.0,

                ),
                ),
              ),
              Tab(
                child: Text(
                  'Top Tours',style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 15.0,

                ),
                ),
              ),
              Tab(
                child: Text(
                  'Top Cars',style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 15.0,

                ),
                ),
              ),
              Tab(
                child: Text(
                  'Road Trips',style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 15.0,

                ),
                ),
              ),




            ],



          ),
          const SizedBox(height: 10.0,),
          Container(
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              controller: tabController,
              children:  <Widget>[

            //    HomeScreen(),
                // BadgeScreen(name: '', email: user.email!, location: '', price: '',),




                TD(),

                HotelCarousel(),




                SafariCarousel(),

                CarCarousel(),




                RoadTripCarousel(),






              ],
            ),
          ),

        ],
      ),
    );
  }


}

