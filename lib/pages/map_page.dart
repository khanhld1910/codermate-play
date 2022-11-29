import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:codermate_play/app_constants.dart';
import 'package:codermate_play/helpers/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  late GoogleMapController mapController;
  final Map<String, Marker> _markers = AppConstants.mySamplePlaces;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 32, 32),
        title: const Text('CoderMate - Explore'),
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: LocationHelper.getCurrentLocation(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: Text("Loading map. Please Wait ... ..."),
                );
              }

              Position position = snapshot.data as Position;
              return GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 13.0,
                ),
                markers: _markers.values.toSet(),
              );
            },
          ),
        ],
      ),
    );
  }
}
