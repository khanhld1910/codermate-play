import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppConstants {
  static const sampleValue = 'My_sample_value';

  static const Map<String, Marker> mySamplePlaces = {
    "Location A": Marker(
      markerId: MarkerId("location_a"),
      position: LatLng(45.521563, -122.677433),
      infoWindow: InfoWindow(
        title: "Offile A",
        snippet: "Claude Debussylaan 34\n1082 MD, Amsterdam\nNetherlands",
      ),
    ),
    "Location B": Marker(
      markerId: MarkerId("location_b"),
      position: LatLng(45.529563, -122.680433),
      infoWindow: InfoWindow(
        title: "Offile B",
        snippet: "Claude Debussylaan 34\n1082 MD, Amsterdam\nNetherlands",
      ),
    ),
  };
}
