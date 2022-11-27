import 'package:codermate_play/app_constants.dart';
import 'package:codermate_play/helpers/location.dart';
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
  // late LatLng currentLocation = AppConstants.testLocation;
  late final MapController mapController;
  late LatLng currentLocation;
  late Marker marker;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    setCurrentPosition();
  }

  Future<void> setCurrentPosition() async {
    Position myPosition = await LocationHelper.getCurrentLocation();
    setState(() {
      currentLocation = LatLng(myPosition.latitude, myPosition.longitude);
      marker = Marker(
        height: 40,
        width: 40,
        point: currentLocation,
        builder: (_) {
          return const Icon(
            Icons.location_pin,
            color: Colors.black,
            size: 40,
          );
        },
      );
    });
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
              center: currentLocation, // get user's current location
            ),
            children: [
              TileLayer(
                urlTemplate: AppConstants.mapBoxUrlTemplate,
              ),
              MarkerLayer(
                markers: [marker],
              )
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await setCurrentPosition();
          _animatedMapMove(currentLocation, 13);
        },
        label: const Text('My Location'),
        icon: const Icon(Icons.location_pin),
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
