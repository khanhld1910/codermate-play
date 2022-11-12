import 'package:latlong2/latlong.dart';

class AppConstants {
  static const String mapBoxUsername = 'khanhcp';
  static const String mapBoxAccessToken =
      'pk.eyJ1Ijoia2hhbmhjcCIsImEiOiJjbGE5cGdjMjYwMDgyM3ZwbXZ1ZWpzcHJiIn0.P4VGml_5VpTcE5_Z7LRIJw';
  static const String mapBoxStyleId = 'cladnmbec000h15odstgzrai1';
  static const String mapBoxUrlTemplate =
      'https://api.mapbox.com/styles/v1/$mapBoxUsername/$mapBoxStyleId/tiles/256/{z}/{x}/{y}@2x?access_token=$mapBoxAccessToken';

  static final myLocation = LatLng(16.0954879, 108.2496562);
}
