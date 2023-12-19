

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eastravel/languagetranslator/languages/swahili.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:eastravel/screens/profilescreen.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../animalspotted.dart';
import '../badge.dart';
import '../deeplearning/birdclassifier.dart';
import '../hoteladmin/editroom.dart';
import '../languagetranslator/languagechoosetranslate.dart';
import '../languagetranslator/languages/list.dart';
import '../languagetranslator/languageteacherlistener.dart';
import '../languagetranslator/listener.dart';
import '../spottedanimal.dart';
import '../templates/profilepage.dart';
import '../templates/tabpage.dart';
import 'accountingpage.dart';
import 'editprofile.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
class MainAccount extends StatefulWidget {

   MainAccount({Key? key}) : super(key: key);

  @override
  State<MainAccount> createState() => _MainAccountState();
}

class _MainAccountState extends State<MainAccount> {
  final user = FirebaseAuth.instance.currentUser!;
  double fem=1;
  double ffem=0.9;


  @override
  Widget build(BuildContext context) {
    return  ListView(
      children: [

        Container(
          // autogroupftmnh3n (2Rx5e6o8oyEMBY4MriFtMN)
          padding:  EdgeInsets.fromLTRB(12.09*fem, 1*fem, 12.09*fem, 83*fem),
          width:  double.infinity,
          child:
          Column(
              crossAxisAlignment:  CrossAxisAlignment.center,
              children:  [
                Container(
                  // profileringNzU (0:2330)
                  margin:  EdgeInsets.fromLTRB(37.91*fem, 0*fem, 37.91*fem, 4*fem),
                  child:
                  TextButton(
                    onPressed:  () {},
                    style:  TextButton.styleFrom (
                      padding:  EdgeInsets.zero,
                    ),
                    child:
                    Container(
                      width:  double.infinity,
                      height:  220*fem,
                      child:
                      Container(
                        // frame34sJ (I0:2330;74:455)
                        width:  double.infinity,
                        height:  double.infinity,
                        child:
                        Stack(
                          children:  [
                            Positioned(
                              // ellipse21oK6 (I0:2330;74:375)
                              left:  35*fem,
                              top:  25*fem,
                              child:
                              Align(
                                child:
                                SizedBox(
                                  width:  160*fem,
                                  height:  160*fem,
                                  child:
                                  Container(
                                    decoration:  BoxDecoration (
                                      borderRadius:  BorderRadius.circular(105*fem),
                                      border:  Border.all(color:Color(0xffed1b24)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              // ellipse22URE (I0:2330;74:376)
                              left:  30*fem,
                              top:  20*fem,
                              child:
                              Align(
                                child:
                                SizedBox(
                                  width:  170*fem,
                                  height:  170*fem,
                                  child:
                                  Container(
                                    decoration:  BoxDecoration (
                                      borderRadius:  BorderRadius.circular(110*fem),
                                      border:  Border.all(color:Color(0xcced1b24)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              // ellipse23YAC (I0:2330;74:377)
                              left:  25*fem,
                              top:  15*fem,
                              child:
                              Align(
                                child:
                                SizedBox(
                                  width:  180*fem,
                                  height:  180*fem,
                                  child:
                                  Container(
                                    decoration:  BoxDecoration (
                                      borderRadius:  BorderRadius.circular(115*fem),
                                      border:  Border.all(color:Color(0x99ed1b24)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              // ellipse24Qy6 (I0:2330;74:378)
                              left:  20*fem,
                              top:  10*fem,
                              child:
                              Align(
                                child:
                                SizedBox(
                                  width:  190*fem,
                                  height:  190*fem,
                                  child:
                                  Container(
                                    decoration:  BoxDecoration (
                                      borderRadius:  BorderRadius.circular(120*fem),
                                      border:  Border.all(color:Color(0x66ed1b24)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              // ellipse25JHn (I0:2330;74:379)
                              left:  15*fem,
                              top:  5*fem,
                              child:
                              Align(
                                child:
                                SizedBox(
                                  width:  200*fem,
                                  height:  200*fem,
                                  child:
                                  Container(
                                    decoration:  BoxDecoration (
                                      borderRadius:  BorderRadius.circular(125*fem),
                                      border:  Border.all(color:Color(0x33ed1b24)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              // ellipse26x7S (I0:2330;74:380)
                              left:  10*fem,
                              top:  0*fem,
                              child:
                              Align(
                                child:
                                SizedBox(
                                  width:  210*fem,
                                  height:  210*fem,
                                  child:
                                  Container(
                                    decoration:  BoxDecoration (
                                      borderRadius:  BorderRadius.circular(130*fem),
                                      border:  Border.all(color:Color(0x19ed1b24)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              // ellipse15zpp (I0:2330;74:381)
                              left:  40*fem,
                              top:  30*fem,
                              child:
                              Align(
                                child:
                                SizedBox(
                                  width:  150*fem,
                                  height:  150*fem,
                                  child:
                                  Container(
                                    decoration:  BoxDecoration (
                                      borderRadius:  BorderRadius.circular(100*fem),
                                      border:  Border.all(color:Color(0x4cffffff)),
                                      image:  DecorationImage (
                                        fit:  BoxFit.cover,
                                        image:  AssetImage('assets/images/gondola.jpg'),

                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('email', isEqualTo: user.email)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.hasData && !(snapshot.data?.docs.isEmpty ?? true)) {
                      String firstName = snapshot.data!.docs[0].get('firstname');
                      String lastName = snapshot.data!.docs[0].get('lastname');
                      String id = snapshot.data!.docs[0].get('id');

                      return GestureDetector(
                        onTap:  () {Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(docId: '$id',),),);},
                        child: Container(
                          margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 25*fem),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '$firstName $lastName',
                                style:  GoogleFonts.inter(
                                  fontSize:  20*ffem,
                                  fontWeight:  FontWeight.w800,
                                  height:  1.2125*ffem/fem,
                                  color:  Colors.black,
                                ),
                              ),
                              Text(
                                'Edit',
                                style:  GoogleFonts.inter(
                                  fontSize:  15*ffem,
                                  fontWeight:  FontWeight.w800,
                                  height:  1.2125*ffem/fem,
                                  color:  Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),

                //USER PROFILE IMAGE





//Email





        //Wishlist


        //Scan QR CODE AND BADGES
        Container(
        // frame21JW4 (0:2390)

        child:
        TextButton(
        onPressed:  () {Navigator.push(context, MaterialPageRoute(builder: (context) =>  BadgeScreenn(),),);},
        style:  TextButton.styleFrom (
        padding:  EdgeInsets.zero,
        ),
        child:
        Row(
        crossAxisAlignment:  CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  [
          Text(
            'Badges',
            style:  GoogleFonts.inter (

              fontSize:  20*ffem,
              fontWeight:  FontWeight.w600,
              height:  1.2125*ffem/fem,
              color:  Colors.black,
            ),
          ),
          Lottie.asset('assets/icons/trophy.json',height: 70),


        ],
        ),
        ),
        ),






//Logout
        Container(
        // line1pic (0:2336)
        margin:  EdgeInsets.fromLTRB(7.91*fem, 0*fem, 7.91*fem, 27*fem),
        width:  double.infinity,
        height:  1*fem,
        decoration:  BoxDecoration (
        color:  Color(0x7fffffff),
        ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12)
          ),
        // signoutXsv (0:2335)
        margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 236*fem, 0*fem),
        child:
        Row(
          children: [
            Icon(Icons.logout,color: Colors.white,),
            TextButton(
            onPressed:  () {},
            style:  TextButton.styleFrom (
            padding:  EdgeInsets.zero,
            ),
            child:
            Text(
            'Log Out',
            style:  GoogleFonts.inter (

            fontSize:  20*ffem,
            fontWeight:  FontWeight.w600,
            height:  1.2125*ffem/fem,
            color:  Colors.white,
            ),
            ),
            ),
          ],
        ),
        ),
        ],
        ),
        ),
      ],
    );
  }
}


class Tools extends StatefulWidget {
  const Tools({Key? key}) : super(key: key);

  @override
  State<Tools> createState() => _ToolsState();
}

class _ToolsState extends State<Tools> {
  final user = FirebaseAuth.instance.currentUser!;
  double fem=1;
  double ffem=0.9;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
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
              padding: EdgeInsets.only(top: 15.0,left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 5,),
                  GestureDetector(
                    onTap: () {

                    },
                    child: Text(
                      'My Tools',
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {

                      },
                      child: Lottie.asset('assets/icons/133390-hotel-pop-up.json',height: 50,)),
                  SizedBox(width: 5,),
                ],
              ),


            ),


          ],
        ),

        Container(
          // autogroupftmnh3n (2Rx5e6o8oyEMBY4MriFtMN)
          padding:  EdgeInsets.fromLTRB(12.09*fem, 1*fem, 12.09*fem, 83*fem),
          width:  double.infinity,
          child:
          Column(
            crossAxisAlignment:  CrossAxisAlignment.center,
            children:  [






              //Animals Spotted
              Container(
                // frame21JW4 (0:2390)

                child:
                TextButton(
                  onPressed:  () {Navigator.push(context, MaterialPageRoute(builder: (context) => AnimalSpottedPage(),),);},
                  style:  TextButton.styleFrom (
                    padding:  EdgeInsets.zero,
                  ),
                  child:
                  Row(
                    crossAxisAlignment:  CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text(
                        'Animal Spotter',
                        style:  GoogleFonts.inter (

                          fontSize:  20*ffem,
                          fontWeight:  FontWeight.w600,
                          height:  1.2125*ffem/fem,
                          color:  Colors.black,
                        ),
                      ),
                      Lottie.asset('assets/icons/73387-tourist-travel.json',height: 50),


                    ],
                  ),
                ),
              ),
              //Language Translator
              Container(
                // frame21JW4 (0:2390)

                child:
                TextButton(
                  onPressed:  () {Navigator.push(context, MaterialPageRoute(builder: (context) => LearnSwahili(),),);},
                  style:  TextButton.styleFrom (
                    padding:  EdgeInsets.zero,
                  ),
                  child:
                  Row(
                    crossAxisAlignment:  CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text(
                        'Language Translator',
                        style:  GoogleFonts.inter (

                          fontSize:  20*ffem,
                          fontWeight:  FontWeight.w600,
                          height:  1.2125*ffem/fem,
                          color:  Colors.black,
                        ),
                      ),
                      Lottie.asset('assets/icons/translator.json',height: 50),


                    ],
                  ),
                ),
              ),
              //Bird Identifier
              Container(
                // frame21JW4 (0:2390)

                child:
                TextButton(
                  onPressed:  () {Navigator.push(context, MaterialPageRoute(builder: (context) => CatDogClassifier(),),);},
                  style:  TextButton.styleFrom (
                    padding:  EdgeInsets.zero,
                  ),
                  child:
                  Row(
                    crossAxisAlignment:  CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text(
                        'Smart Birdy App',
                        style:  GoogleFonts.inter (

                          fontSize:  20*ffem,
                          fontWeight:  FontWeight.w600,
                          height:  1.2125*ffem/fem,
                          color:  Colors.black,
                        ),
                      ),
                      Lottie.asset('assets/icons/bird.json',height: 50),


                    ],
                  ),
                ),
              ),

              //Mechanic locator
              Container(
                // frame21JW4 (0:2390)

                child:
                TextButton(
                  onPressed:  () {Navigator.push(context, MaterialPageRoute(builder: (context) => AnimalSpottedPage(),),);},
                  style:  TextButton.styleFrom (
                    padding:  EdgeInsets.zero,
                  ),
                  child:
                  Row(
                    crossAxisAlignment:  CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text(
                        'Mechanic Locator',
                        style:  GoogleFonts.inter (

                          fontSize:  20*ffem,
                          fontWeight:  FontWeight.w600,
                          height:  1.2125*ffem/fem,
                          color:  Colors.black,
                        ),
                      ),
                      Lottie.asset('assets/icons/73387-tourist-travel.json',height: 50),


                    ],
                  ),
                ),
              ),


//Paypal
              Container(
                // frame21JW4 (0:2390)

                child:
                TextButton(

                  onPressed:  () {

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>

                          PaypalCheckout(
                            sandboxMode: true,
                            clientId: "AfYlnWmnqqXYtpzbHcDIJuMsiGBmTWZWiMGWyENiTJrAr6iMryrjmwTSu79waheaPBgd2AbvgoJ8QJHq",
                            secretKey: "ECdK3iPxvLLIN9ty8ryen2rPqDGVuvG6b8h7IxLBqQaCuDTQqpet76ZzcNZVqW3pjc51t4CDtZn0dN0A",
                            returnURL: "com.example.eastravel://paypalpay",
                            cancelURL: "com.example.eastravel://paypalpay",
                            transactions: const [
                              {
                                "amount": {
                                  "total": '130',
                                  "currency": "USD",
                                  "details": {
                                    "subtotal": '30',
                                    "shipping": '100',
                                    "shipping_discount": 0
                                  }
                                },
                                "description": "The payment transaction description.",
                                "item_list": {
                                  "items": [
                                    {
                                      "name": "Apple",
                                      "quantity": 2,
                                      "price": '5',
                                      "currency": "USD"
                                    },
                                    {
                                      "name": "Pineapple",
                                      "quantity": 2,
                                      "price": '10',
                                      "currency": "USD"
                                    }
                                  ],
                                  // shipping address is Optional
                                  "shipping_address": {
                                    "recipient_name": "Raman Singh",
                                    "line1": "Nairobi",
                                    "line2": "",
                                    "city": "Delhi",
                                    "country_code": "KE",
                                    "postal_code": "00100",
                                    "phone": "+00000000",
                                    "state": "Texas"
                                  },
                                }
                              }
                            ],
                            note: "PAYMENT_NOTE",
                            onSuccess: (Map params) async {
                              print("onSuccess: $params");
                            },
                            onError: (error) {
                              print("onError: $error");
                              Navigator.pop(context);
                            },
                            onCancel: () {
                              print('cancelled:');
                            },
                          ),

                    ));
                  },
                  style:  TextButton.styleFrom (
                    padding:  EdgeInsets.zero,
                  ),
                  child:
                  Row(
                    crossAxisAlignment:  CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text(
                        'Paypal',
                        style:  GoogleFonts.inter (

                          fontSize:  20*ffem,
                          fontWeight:  FontWeight.w600,
                          height:  1.2125*ffem/fem,
                          color:  Colors.black,
                        ),
                      ),
                      Lottie.asset('assets/icons/73387-tourist-travel.json',height: 50),


                    ],
                  ),
                ),
              ),


//Logout

            ],
          ),
        ),
      ],
    );
  }
}









class TTools extends StatefulWidget {
  const TTools({Key? key}) : super(key: key);

  @override
  _TToolsState createState() => _TToolsState();
}

class _TToolsState extends State<HomeP> with SingleTickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser!;
  late TabController tabController;
  @override
  void  initState(){
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9EFEB),
      body: ListView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()
        ),
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 100.0,

                decoration: const BoxDecoration(

                    color: Color(0xFFFD7465),
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(75.0,),bottomLeft: Radius.circular(75.0,)



                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0,left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      children: [


                        Text('Tools')
                      ],
                    ),

                    GestureDetector(
                        onTap: (){FirebaseAuth.instance.signOut();},
                        child: Lottie.asset('assets/icons/133390-hotel-pop-up.json',height: 70,))
                  ],
                ),


              ),


            ],
          ),

          TabBar(
            controller: tabController,
            indicatorColor: Color(0xFFFE8A7E),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 4.0,
            isScrollable: true,
            labelColor: Color(0xFF440206),
            unselectedLabelColor: Color(0xFF440206),
            tabs: const [

              Tab(
                child: Text(
                  'Weather',style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 15.0,

                ),
                ),
              ),
              Tab(
                child: Text(
                  'Animal Locator',style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 15.0,

                ),
                ),
              ),
              Tab(
                child: Text(
                  'Smart Birdy',style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 15.0,

                ),
                ),
              ),
              Tab(
                child: Text(
                  'Language Translator',style: TextStyle(
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
                WeatherPage(),
                AnimalSpottedPage(),
                LearnSwahili(),
                CatDogClassifier()


 ],
            ),
          ),



        ],
      ),
    );
  }


}









class BadgeScreenn extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;


   BadgeScreenn({key, });

  @override
  Widget build(BuildContext context) {
    final String name=user.email!;


    final qrData = '$name';
    final fem=0.9;
    final ffem =0.9;

    return Scaffold(
      appBar: AppBar(title: Text('Badges',style: GoogleFonts.inter(),),),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // profilepage9h1A (0:1167)
              padding:  EdgeInsets.fromLTRB(12.09*fem, 1*fem, 12.09*fem, 48*fem),
              width:  double.infinity,
              decoration:  BoxDecoration (
                color:  Colors.white,
              ),
              child:
              Column(
                crossAxisAlignment:  CrossAxisAlignment.center,
                children:  [

                 //QR CODE
                  Container(
                    // profileringRv8 (0:1188)
                    margin:  EdgeInsets.fromLTRB(37.91*fem, 0*fem, 37.91*fem, 29*fem),
                    child:
                    TextButton(
                      onPressed:  () {},
                      style:  TextButton.styleFrom (
                        padding:  EdgeInsets.zero,
                      ),
                      child:
                      Container (
                        width:  double.infinity,
                        height:  260*fem,
                        child:
                        Container(
                          // frame3L1W (I0:1188;74:455)
                          width:  double.infinity,
                          height:  double.infinity,
                          child:
                          Stack(
                            children:  [
                              Positioned(
                                // ellipse214y6 (I0:1188;74:375)
                                left:  25*fem,
                                top:  25*fem,
                                child:
                                Align(
                                  child:
                                  SizedBox(
                                    width:  210*fem,
                                    height:  210*fem,
                                    child:
                                    Container(
                                      decoration:  BoxDecoration (
                                        borderRadius:  BorderRadius.circular(105*fem),
                                        border:  Border.all(color:Color(0xffed1b24)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                // ellipse22MhJ (I0:1188;74:376)
                                left:  20*fem,
                                top:  20*fem,
                                child:
                                Align(
                                  child:
                                  SizedBox(
                                    width:  220*fem,
                                    height:  220*fem,
                                    child:
                                    Container(
                                      decoration:  BoxDecoration (
                                        borderRadius:  BorderRadius.circular(110*fem),
                                        border:  Border.all(color:Color(0xcced1b24)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                // ellipse233q2 (I0:1188;74:377)
                                left:  15*fem,
                                top:  15*fem,
                                child:
                                Align(
                                  child:
                                  SizedBox(
                                    width:  230*fem,
                                    height:  230*fem,
                                    child:
                                    Container(
                                      decoration:  BoxDecoration (
                                        borderRadius:  BorderRadius.circular(115*fem),
                                        border:  Border.all(color:Color(0x99ed1b24)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                // ellipse24NcQ (I0:1188;74:378)
                                left:  10*fem,
                                top:  10*fem,
                                child:
                                Align(
                                  child:
                                  SizedBox(
                                    width:  240*fem,
                                    height:  240*fem,
                                    child:
                                    Container(
                                      decoration:  BoxDecoration (
                                        borderRadius:  BorderRadius.circular(120*fem),
                                        border:  Border.all(color:Color(0x66ed1b24)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                // ellipse25HUU (I0:1188;74:379)
                                left:  5*fem,
                                top:  5*fem,
                                child:
                                Align(
                                  child:
                                  SizedBox(
                                    width:  250*fem,
                                    height:  250*fem,
                                    child:
                                    Container(
                                      decoration:  BoxDecoration (
                                        borderRadius:  BorderRadius.circular(125*fem),
                                        border:  Border.all(color:Color(0x33ed1b24)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                // ellipse26Qoz (I0:1188;74:380)
                                left:  0*fem,
                                top:  0*fem,
                                child:
                                Align(
                                  child:
                                  SizedBox(
                                    width:  260*fem,
                                    height:  260*fem,
                                    child:
                                    Container(
                                      decoration:  BoxDecoration (
                                        borderRadius:  BorderRadius.circular(130*fem),
                                        border:  Border.all(color:Color(0x19ed1b24)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  //button text
                  Container(
                    // buttonLLG (0:1170)
                    margin:  EdgeInsets.fromLTRB(17.91*fem, 0*fem, 17.91*fem, 0*fem),
                    child:
                    TextButton(
                      onPressed:  () {},
                      style:  TextButton.styleFrom (
                        padding:  EdgeInsets.zero,
                      ),
                      child:
                      Container(
                        width:  double.infinity,
                        height:  50*fem,
                        decoration:  BoxDecoration (
                          color:  Color(0xffed1b24),
                        ),
                        child:
                        Center(
                          child:
                          Text(
                            'Scan this QR code to get the badge',
                            textAlign:  TextAlign.center,
                            style:  GoogleFonts.inter (

                              fontSize:  18.3821086884*ffem,
                              fontWeight:  FontWeight.w600,
                              height:  1.2125*ffem/fem,
                              color:  Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //ListView
                  Container(
                      height: 300,
                      child: UserBadgesPage(name: user.email!)),



                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
