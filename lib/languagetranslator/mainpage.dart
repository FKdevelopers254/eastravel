import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'languages/chinese.dart';
import 'languages/french.dart';
import 'languages/norwegian.dart';
import 'languages/polish.dart';
import 'languages/spanish.dart';
import 'languageteacher.dart';
import 'languages/french.dart';


class RHomePage extends StatefulWidget {
  const RHomePage({Key? key}) : super(key: key);




  @override
  State<RHomePage> createState() => _RHomePageState();
}

class _RHomePageState extends State<RHomePage> {
  double fem=1;
  double ffem= 0.9;



  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          // homeshort19S (2:2596)
          width:  double.infinity,
          decoration:  BoxDecoration (
            color:  Color(0xffffffff),
            borderRadius:  BorderRadius.circular(50*fem),
          ),
          child:
          Column(
            crossAxisAlignment:  CrossAxisAlignment.center,
            children:  [
              Container(
                // autogroupajigsBe (US5pPttDyEo7amQgshAjiG)
                padding:  EdgeInsets.fromLTRB(8*fem, 29*fem, 0*fem, 8*fem),
                width:  double.infinity,
                child:
                Column(
                  crossAxisAlignment:  CrossAxisAlignment.start,
                  children:  [
//AppBAr Text
                    Container(
                      // heyjonathanletsstartexploringF (2:2605)
                      margin:  EdgeInsets.fromLTRB(19*fem, 0*fem, 0*fem, 20*fem),
                      constraints:  BoxConstraints (
                        maxWidth:  232*fem,
                      ),
                      child:
                      RichText(
                        text:
                        TextSpan(
                          style:  TextStyle  (

                            fontSize:  25*ffem,
                            fontWeight:  FontWeight.w500,
                            height:  1.6*ffem/fem,
                            letterSpacing:  0.75*fem,
                            color:  Color(0xff252b5c),
                          ),
                          children:  [
                            TextSpan(
                              text:  'Hey,',
                              style:  TextStyle  (

                                fontSize:  25*ffem,
                                fontWeight:  FontWeight.w500,
                                height:  1.6*ffem/fem,
                                letterSpacing:  0.75*fem,
                                color:  Color(0xff252b5c),
                              ),
                            ),
                            TextSpan(
                              text:  ' ',
                              style:  TextStyle (

                                fontSize:  25*ffem,
                                fontWeight:  FontWeight.w600,
                                height:  1.6*ffem/fem,
                                letterSpacing:  0.75*fem,
                                color:  Color(0xff252b5c),
                              ),
                            ),
                            TextSpan(
                              text:  'Jonathan!',
                              style:  TextStyle (

                                fontSize:  25*ffem,
                                fontWeight:  FontWeight.w800,
                                height:  1.6*ffem/fem,
                                letterSpacing:  0.75*fem,
                                color:  Color(0xff234f68),
                              ),
                            ),
                            TextSpan(
                              text:  ' \n',
                              style:  TextStyle (

                                fontSize:  25*ffem,
                                fontWeight:  FontWeight.w800,
                                height:  1.6*ffem/fem,
                                letterSpacing:  0.75*fem,
                                color:  Color(0xff252b5c),
                              ),
                            ),
                            TextSpan(
                              text:  'Your Journey to',
                              style:  TextStyle  (

                                fontSize:  25*ffem,
                                fontWeight:  FontWeight.w500,
                                height:  1.6*ffem/fem,
                                letterSpacing:  0.75*fem,
                                color:  Color(0xff252b5c),
                              ),
                            ),
                            TextSpan(
                              text:  ' Speaking like a local ',
                              style:  TextStyle  (

                                fontSize:  22*ffem,
                                fontWeight:  FontWeight.w500,
                                height:  1.6*ffem/fem,
                                letterSpacing:  0.75*fem,
                                color:  Color(0xff252b5c),
                              ),
                            ),
                            TextSpan(
                              text:  ' With over 20 Languages',
                              style:  TextStyle  (

                                fontSize:  15*ffem,
                                fontWeight:  FontWeight.w500,
                                height:  1.6*ffem/fem,
                                letterSpacing:  0.75*fem,
                                color:  Color(0xff252b5c),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),







//Blue Button Text
                    Container(
                      // categoryL3r (2:2599)
                      margin:  EdgeInsets.fromLTRB(16*fem, 0*fem, 0*fem, 18*fem),
                      height:  47*fem,
                      child:
                      Container(
                        // buttoncategoryroundedactiveeqE (2:2600)
                        padding:  EdgeInsets.fromLTRB(24*fem, 17.5*fem, 24*fem, 14.5*fem),
                        width:  300*fem,
                        height:  double.infinity,
                        decoration:  BoxDecoration (
                          color:  Color(0xff234f68),
                          borderRadius:  BorderRadius.circular(20*fem),
                        ),
                        child:
                        Text(
                          'Your Journey to Speaking like a local',
                          style:  TextStyle  (

                            fontSize:  10*ffem,
                            fontWeight:  FontWeight.w700,
                            height:  1.175*ffem/fem,
                            letterSpacing:  0.3*fem,
                            color:  Color(0xfff5f4f7),
                          ),
                        ),
                      ),
                    ),


                    Container(
                      // autogroup7w2qADE (US5motMqtnng1DxbEk7w2Q)
                      margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 15*fem),
                      width:  double.infinity,
                      child:
                      Column(
                        crossAxisAlignment:  CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          
                          //French
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LearnFrench()),
                              );
                            },
                            child: Container(
                              // autogroupebsyhDA (US5n48T7RFzQTpbt6neBSY)
                              margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 13*fem, 1*fem),
                              padding:  EdgeInsets.fromLTRB(0*fem, 43*fem, 0*fem, 0*fem),
                              width:  330,
                              decoration:  BoxDecoration (
                                borderRadius:  BorderRadius.circular(25*fem),
                                color:  Color(0x63000000),
                                image:  DecorationImage (
                                  fit:  BoxFit.cover,
                                  image: AssetImage('lib/assets/images/france.webp'),
                                ),
                              ),
                              child:
                              Column(
                                crossAxisAlignment:  CrossAxisAlignment.start,
                                children:  [
                                  Container(
                                    // textYja (2:2650)
                                    margin:  EdgeInsets.fromLTRB(20*fem, 0*fem, 0*fem, 7*fem),
                                    constraints:  BoxConstraints (
                                      maxWidth:  143*fem,
                                    ),
                                    child:
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                      
                                      child: Text(
                                        'French',
                                        style:  TextStyle  (

                                          fontSize:  18*ffem,
                                          fontWeight:  FontWeight.w700,
                                          height:  1.175*ffem/fem,
                                          letterSpacing:  0.54*fem,
                                          color:  Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(21.0, 0, 0, 5.0),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child:
                                    Text(
                                      'Learn French Words and Pronunciation',
                                      style:  TextStyle  (

                                        fontSize:  10*ffem,
                                        fontWeight:  FontWeight.w400,
                                        height:  1.175*ffem/fem,
                                        color:  Colors.white,
                                      ),
                                    ),
                                  ),

                               



                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          //Spanish
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LearnSpanish()),
                              );
                            },
                            child: Container(
                              // autogroupebsyhDA (US5n48T7RFzQTpbt6neBSY)
                              margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 13*fem, 1*fem),
                              padding:  EdgeInsets.fromLTRB(0*fem, 43*fem, 0*fem, 0*fem),
                              width:  330,
                              decoration:  BoxDecoration (
                                borderRadius:  BorderRadius.circular(25*fem),
                                color:  Color(0x63000000),
                                image:  DecorationImage (
                                  fit:  BoxFit.cover,
                                  image: AssetImage('lib/assets/images/spanish.jpg'),
                                ),
                              ),
                              child:
                              Column(
                                crossAxisAlignment:  CrossAxisAlignment.start,
                                children:  [
                                  Container(
                                    // textYja (2:2650)
                                    margin:  EdgeInsets.fromLTRB(20*fem, 0*fem, 0*fem, 7*fem),
                                    constraints:  BoxConstraints (
                                      maxWidth:  143*fem,
                                    ),
                                    child:
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Text(
                                        'Spanish',
                                        style:  TextStyle  (

                                          fontSize:  18*ffem,
                                          fontWeight:  FontWeight.w700,
                                          height:  1.175*ffem/fem,
                                          letterSpacing:  0.54*fem,
                                          color:  Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(21.0, 0, 0, 5.0),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child:
                                    Text(
                                      'Learn Spanish Words and Pronunciation',
                                      style:  TextStyle  (

                                        fontSize:  10*ffem,
                                        fontWeight:  FontWeight.w400,
                                        height:  1.175*ffem/fem,
                                        color:  Colors.white,
                                      ),
                                    ),
                                  ),





                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          
                          //Polish
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LearnPolish()),
                              );
                            },
                            child: Container(
                              // autogroupebsyhDA (US5n48T7RFzQTpbt6neBSY)
                              margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 13*fem, 1*fem),
                              padding:  EdgeInsets.fromLTRB(0*fem, 43*fem, 0*fem, 0*fem),
                              width:  330,
                              decoration:  BoxDecoration (
                                borderRadius:  BorderRadius.circular(25*fem),
                                color:  Color(0x63000000),
                                image:  DecorationImage (
                                  fit:  BoxFit.cover,
                                  image: AssetImage('lib/assets/images/polishflag.jpg'),
                                ),
                              ),
                              child:
                              Column(
                                crossAxisAlignment:  CrossAxisAlignment.start,
                                children:  [
                                  Container(
                                    // textYja (2:2650)
                                    margin:  EdgeInsets.fromLTRB(20*fem, 0*fem, 0*fem, 7*fem),
                                    constraints:  BoxConstraints (
                                      maxWidth:  143*fem,
                                    ),
                                    child:
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Text(
                                        'Polish',
                                        style:  TextStyle  (

                                          fontSize:  18*ffem,
                                          fontWeight:  FontWeight.w700,
                                          height:  1.175*ffem/fem,
                                          letterSpacing:  0.54*fem,
                                          color:  Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(21.0, 0, 0, 5.0),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child:
                                    Text(
                                      'Learn Polish Words and Pronunciation',
                                      style:  TextStyle  (

                                        fontSize:  10*ffem,
                                        fontWeight:  FontWeight.w400,
                                        height:  1.175*ffem/fem,
                                        color:  Colors.white,
                                      ),
                                    ),
                                  ),





                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 10,),

                          //Norwegian
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LearnNorwegian()),
                              );
                            },
                            child: Container(
                              // autogroupebsyhDA (US5n48T7RFzQTpbt6neBSY)
                              margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 13*fem, 1*fem),
                              padding:  EdgeInsets.fromLTRB(0*fem, 43*fem, 0*fem, 0*fem),
                              width:  330,
                              decoration:  BoxDecoration (
                                borderRadius:  BorderRadius.circular(25*fem),
                                color:  Color(0x63000000),
                                image:  DecorationImage (
                                  fit:  BoxFit.cover,
                                  image: AssetImage('lib/assets/images/polishflag.jpg'),
                                ),
                              ),
                              child:
                              Column(
                                crossAxisAlignment:  CrossAxisAlignment.start,
                                children:  [
                                  Container(
                                    // textYja (2:2650)
                                    margin:  EdgeInsets.fromLTRB(20*fem, 0*fem, 0*fem, 7*fem),
                                    constraints:  BoxConstraints (
                                      maxWidth:  143*fem,
                                    ),
                                    child:
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Text(
                                        'Norwegian',
                                        style:  TextStyle  (

                                          fontSize:  18*ffem,
                                          fontWeight:  FontWeight.w700,
                                          height:  1.175*ffem/fem,
                                          letterSpacing:  0.54*fem,
                                          color:  Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(21.0, 0, 0, 5.0),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child:
                                    Text(
                                      'Learn Norwegian Words and Pronunciation',
                                      style:  TextStyle  (

                                        fontSize:  10*ffem,
                                        fontWeight:  FontWeight.w400,
                                        height:  1.175*ffem/fem,
                                        color:  Colors.white,
                                      ),
                                    ),
                                  ),





                                ],
                              ),
                            ),
                          ),


                          SizedBox(height: 10,),

                          //Chinese
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LearnChinese()),
                              );
                            },
                            child: Container(
                              // autogroupebsyhDA (US5n48T7RFzQTpbt6neBSY)
                              margin:  EdgeInsets.fromLTRB(0*fem, 0*fem, 13*fem, 1*fem),
                              padding:  EdgeInsets.fromLTRB(0*fem, 43*fem, 0*fem, 0*fem),
                              width:  330,
                              decoration:  BoxDecoration (
                                borderRadius:  BorderRadius.circular(25*fem),
                                color:  Color(0x63000000),
                                image:  DecorationImage (
                                  fit:  BoxFit.cover,
                                  image: AssetImage('lib/assets/images/polishflag.jpg'),
                                ),
                              ),
                              child:
                              Column(
                                crossAxisAlignment:  CrossAxisAlignment.start,
                                children:  [
                                  Container(
                                    // textYja (2:2650)
                                    margin:  EdgeInsets.fromLTRB(20*fem, 0*fem, 0*fem, 7*fem),
                                    constraints:  BoxConstraints (
                                      maxWidth:  143*fem,
                                    ),
                                    child:
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Text(
                                        'Chinese',
                                        style:  TextStyle  (

                                          fontSize:  18*ffem,
                                          fontWeight:  FontWeight.w700,
                                          height:  1.175*ffem/fem,
                                          letterSpacing:  0.54*fem,
                                          color:  Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(21.0, 0, 0, 5.0),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child:
                                    Text(
                                      'Learn Chinese Words and Pronunciation',
                                      style:  TextStyle  (

                                        fontSize:  10*ffem,
                                        fontWeight:  FontWeight.w400,
                                        height:  1.175*ffem/fem,
                                        color:  Colors.white,
                                      ),
                                    ),
                                  ),





                                ],
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
          ),
        ),
      ],
    );
  }
}
