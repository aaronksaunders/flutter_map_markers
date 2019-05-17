import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';
import 'package:flutter/material.dart';

class MainMap extends StatefulWidget {
  @override
  _MainMapState createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  GoogleMapController mapController;
  Set<Marker> markers = new Set();
  // MarkerId selectedMarker;

  List<Map<String, dynamic>> locations = [
    {
      "Location_Number": "-76.97892538.882767",
      "Location_Name": "John Dean and Hannibal Hamlin Burial Sites",
      "coordinates": [-76.978923660098019, 38.882767398397789]
    },
    {
      "Location_Number": "-77.16515878125193238.938782583950172",
      "Location_Name": "Camp Greene",
      "coordinates": [-77.165158781251932, 38.938782583950172]
    },
    {
      "Location_Number": "-77.04500938.919531",
      "Location_Name": "John Little Farm Site",
      "coordinates": [-77.045009, 38.919531]
    },
  ];

  void _addMarkers() {
    locations.forEach((Map<String, dynamic> location) {
      final MarkerId markerId = MarkerId(location['Location_Number']);

      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(
          location['coordinates'][1],
          location['coordinates'][0],
        ),
        infoWindow: InfoWindow(title: location['Location_Name'], snippet: '*'),
        onTap: () {
          //_onMarkerTapped(markerId);
        },
      );

      markers.add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(38.90, -77.03), zoom: 15),
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        mapType: MapType.normal,
        markers: markers.toSet());
  }

  void _onMapCreated(GoogleMapController controller) {
    // update map controller
    setState(() {
      mapController = controller;
    });

    // create bounding box for view
    LatLngBounds _bounds = FindBoundsCoordinates().getBounds(locations);

    // add the markers to the map
    _addMarkers();

    // adjust camera to boundingBox
    controller.animateCamera(CameraUpdate.newLatLngBounds(_bounds, 100.0));
  }
}

//
// used to calculate the boundry for rendering the markers
//
class FindBoundsCoordinates {
  List<Map<String, dynamic>> locations = [];

  LatLngBounds getBounds(List<Map<String, dynamic>> locations) {
    List<double> latitudes = [];
    List<double> londitude = [];

    locations.asMap().forEach((index, latLng) {
      latitudes.add(latLng['coordinates'][1]);
      londitude.add(latLng['coordinates'][0]);
    });

    return LatLngBounds(
      southwest: LatLng(latitudes.reduce(min), londitude.reduce(min)),
      northeast: LatLng(latitudes.reduce(max), londitude.reduce(max)),
    );
  }
}
