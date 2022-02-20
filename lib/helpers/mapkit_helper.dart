import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as LatitudeLongitude;
import 'package:maps_toolkit/maps_toolkit.dart';

class MapKitHelper {
  static double getMarkerRotation(
      sourceLat, sourceLong, destinationLat, destinationLong) {
    var rotation = SphericalUtil.computeHeading(
        LatitudeLongitude.LatLng(sourceLat, sourceLong),
        LatitudeLongitude.LatLng(destinationLat, destinationLong));

    return rotation.toDouble();
  }
}
