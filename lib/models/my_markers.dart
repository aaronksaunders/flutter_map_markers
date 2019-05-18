import 'package:google_maps_flutter/google_maps_flutter.dart';

//
// extending the google map marker to add more information
// to it
class MyMarker extends Marker {
  final String name;

  MyMarker(this.name, {MarkerId id, lat, lng, onTap})
      : super(
          markerId: id,
          position: LatLng(
            lat,
            lng,
          ),
          infoWindow: InfoWindow(title: name, snippet: '*'),
          onTap: onTap,
        );
}
