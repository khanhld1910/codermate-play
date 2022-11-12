import 'package:codermate_play/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
// import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by default

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First Map',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My First Map'),
        ),
        body: const Center(
          child: MyMap(),
        ),
      ),
    );
  }
}

class MyMap extends StatefulWidget {
  const MyMap({super.key});

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        minZoom: 10,
        maxZoom: 18,
        zoom: 12,
        center: LatLng(16.0954879, 108.2496562), // get user's current location
      ),
      children: [
        TileLayer(
          urlTemplate: AppConstants.mapBoxUrlTemplate,
        ),
        MarkerLayer(
          markers: [
            // current user
            Marker(
                point: AppConstants.myLocation,
                builder: (_) {
                  return GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      backgroundColor: Colors.brown.shade800,
                      child: const Text('Me'),
                    ),
                  );
                }),
            // other person
            Marker(
                point: LatLng(16.1, 108.245),
                builder: (_) {
                  return GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      backgroundColor: Colors.brown.shade800,
                      child: const Text('AH'),
                    ),
                  );
                })
          ],
        )
      ],
    );
  }
}
