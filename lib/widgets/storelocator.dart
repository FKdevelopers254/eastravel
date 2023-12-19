import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../spottedanimal.dart';



class StoreFinderPage extends StatefulWidget {
  @override
  _StoreFinderPageState createState() => _StoreFinderPageState();
}

class _StoreFinderPageState extends State<StoreFinderPage> {
 // List<String> closestStores = ['Loading...'];
  List<Map<String, dynamic>> closestStores = [{'name': 'Loading...'}];

  @override
  void initState() {
    super.initState();
    getUserLocation().then((Position userLocation) async {

      List<Map<String, dynamic>> stores = await findClosestStoress(userLocation);
      setState(() {
        closestStores = stores;
      });
    });
  }



  Future<List<Map<String, dynamic>>> findClosestStoress(Position userLocation) async {
    final stores = FirebaseFirestore.instance.collection('animalspotted');
    final QuerySnapshot snapshot = await stores.get();

    List<Map<String, dynamic>> storeDistances = [];

    for (QueryDocumentSnapshot doc in snapshot.docs) {
      double latitude = doc['latitude'];  // Assuming latitude field name is 'latitude'
      double longitude = doc['longitude'];
     // GeoPoint point = doc['location'];
      double distance = Geolocator.distanceBetween(
        userLocation.latitude,
        userLocation.longitude,
        latitude,
        longitude,
      );

      storeDistances.add({
        'name': doc['animalName'],
        'distance': distance,
      });
    }

    storeDistances.sort((a, b) => (a['distance']).compareTo(b['distance']));

    return storeDistances;
  }

  Future<Map<String, dynamic>> findClosestStores(Position userLocation) async {
    final stores = FirebaseFirestore.instance.collection('animalspotted');
    final QuerySnapshot snapshot = await stores.get();

    double minDistance = double.infinity;
    String closestStore = '';
    double closestDistance = 0.0;


    for (QueryDocumentSnapshot doc in snapshot.docs) {
      double latitude = doc['latitude'];
      double longitude = doc['longitude'];
      double distance = Geolocator.distanceBetween(
        userLocation.latitude,
        userLocation.longitude,
        latitude,
        longitude,
      );

      if (distance < minDistance) {
        minDistance = distance;
        closestStore = doc['animalName'];

        closestDistance = distance;
      }
    }
    return {'name': closestStore, 'distance': (closestDistance / 1000)};
  //  return {'name': closestStore, 'distance': closestDistance / 1000}; // Convert meters to kilometers
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Closest Store Finder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Closest Stores:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            for (var store   in closestStores)
              GestureDetector(
                onTap: () async {
      openMaps(1, 2);


    },
                child: Text(
                  '${store['name']} - ${store['distance']} km',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),



          ],
        ),
      ),
    );
  }
}

Future<Position> getUserLocation() async {
  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}
