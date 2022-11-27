import 'package:codermate_play/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  late LatLng currentLocation = AppConstants.testLocation;
  late final MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
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
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              minZoom: 10,
              maxZoom: 22,
              zoom: 14,
              center: currentLocation, // get user's current location
            ),
            children: [
              TileLayer(
                urlTemplate: AppConstants.mapBoxUrlTemplate,
                retinaMode: MediaQuery.of(context).devicePixelRatio > 1.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
