import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyAppp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FutureBuilder(
              future: _initialization,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  List<DocumentSnapshot> stores = snapshot.data as List<DocumentSnapshot>;
                  return StoreFinderPagee(stores: stores);
                }
                return CircularProgressIndicator(); // Loading indicator while fetching store data
              },
            );
          }
          return CircularProgressIndicator(); // Loading indicator while Firebase initializes
        },
      ),
    );
  }

  Future<List<DocumentSnapshot>> getStoreData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('stores').get();
    return querySnapshot.docs;
  }
}

class StoreFinderPagee extends StatelessWidget {
  final List<DocumentSnapshot> stores; // Pass your list of stores here

  StoreFinderPagee({required this.stores});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Closest Store Finder'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StoreFinderMap(stores), // Pass your list of stores here
          ),
          // Add any other widgets you want to display below the map
        ],
      ),
    );
  }
}


class StoreFinderMap extends StatelessWidget {
  final List<DocumentSnapshot> stores;

  StoreFinderMap(this.stores);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(0, 0), // Initial map center (will be updated)
        zoom: 13.0, // Initial zoom level
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: stores.map((store) {
            double latitude = store['latitude'];
            double longitude = store['longitude'];
            return Marker(
              width: 40.0,
              height: 40.0,
              point: LatLng(latitude, longitude),
              builder: (ctx) => Container(
                child: Icon(Icons.store),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
