import 'dart:developer';

import 'package:codermate_play/app_constants.dart';
import 'package:codermate_play/helpers/location.dart';
import 'package:codermate_play/map_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  var currentLocation = AppConstants.testLocation;
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
              maxZoom: 18,
              zoom: 13,
              // center: LatLng(16.0954879, 108.2496562), // get user's current location
              center: currentLocation, // get user's current location
            ),
            children: [
              TileLayer(
                urlTemplate: AppConstants.mapBoxUrlTemplate,
              ),
              MarkerLayer(
                markers: [
                  for (int i = 0; i < mapMarkers.length; i++)
                    Marker(
                      height: 40,
                      width: 40,
                      point: mapMarkers[i].location ?? AppConstants.myLocation,
                      builder: (_) {
                        return GestureDetector(
                          onTap: () async {
                            // inspect(mapMarkers[i]);
                            currentLocation = mapMarkers[i].location ??
                                AppConstants.testLocation;

                            _animatedMapMove(currentLocation, 13);

                            Position loc =
                                await LocationHelper.getCurrentLocation();
                            inspect(loc);
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.brown.shade800,
                            child: Text(
                              mapMarkers[i].shortName ?? 'Un',
                            ),
                          ),
                        );
                      },
                    ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  // to moving smoothly when change map's center
  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }
}
