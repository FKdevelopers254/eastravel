
import 'package:eastravel/widgets/safari_tab.dart';
import 'package:eastravel/widgets/safaridata.dart';
import 'package:eastravel/widgets/workingdata.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../screens/accountingpage.dart';
import '../screens/accountingpagegeneral.dart';
import '../screens/home_screen.dart';
import '../screens/profilescreen.dart';

import '../templates/tabpage.dart';
import 'car_tab.dart';

import 'cardata.dart';
import 'glassbox.dart';
import 'hotel_tab.dart';
import 'hoteldata.dart';








class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         extendBody: true,

        body: Center(child: getSelectedWidget(index: index),),

        bottomNavigationBar:GlassBox(
          child: BottomNavigationBar(
            items:    [
              BottomNavigationBarItem(
                  icon: Lottie.asset('assets/icons/travelone.json',height: 20),activeIcon: Lottie.asset('assets/icons/traveltwo.json',height: 20), label: 'HOME'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.airplane_ticket,),activeIcon: Icon(Icons.search), label: 'Travel') ,

              const BottomNavigationBarItem(
                  icon: Icon(Icons.settings_applications),activeIcon: Icon(Icons.settings_applications), label: 'Tools'),

              const BottomNavigationBarItem(
                  icon: Icon(Icons.account_box),activeIcon: Icon(Icons.account_box_outlined), label: 'Account'),

            ],

            currentIndex: index,
            elevation: 0,
            selectedItemColor: Theme.of(context).primaryColor,
           backgroundColor: Colors.transparent,

           // color: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.red.shade700,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,


           // backgroundColor: Colors.grey[300],

            onTap: (selectedIndex){
              setState(() {
                index = selectedIndex;
              });
            },








          ),
        )

    );
  }






  Widget getSelectedWidget({required int index}){
    Widget widget;
    switch(index){
      case 0:
      //  widget =  CardWithImageAndTextExample();
        widget =  const NewHome();
        break;

      case 1:
        widget =  const HotelP();
        break;

      case 2:
        widget = const Tools();
        break;

      default:
       // widget = const TabPage();
        widget =  MainAccount();
       // widget = const AccountingPage();
       // widget = const HomeP();
        break;
    }
    return widget;
  }










}



