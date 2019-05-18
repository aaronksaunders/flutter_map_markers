import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hello_world/models/my_markers.dart';

class MainMap extends StatefulWidget {
  @override
  _MainMapState createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  GoogleMapController mapController;
  Set<MyMarker> markersList = new Set();

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

//
// add the markers to the markersList
  void _addMarkers() {
    locations.forEach((Map<String, dynamic> location) {
      final MyMarker marker = MyMarker(location['Location_Name'],
          id: MarkerId(location['Location_Number']),
          lat: location['coordinates'][1],
          lng: location['coordinates'][0],
          onTap: null);

      markersList.add(marker);
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
        markers: markersList.toSet());
  }

  void _onMapCreated(GoogleMapController controller) {
    // update map controller
    setState(() {
      mapController = controller;
    });
    // add the markers to the map
    _addMarkers();

    // create bounding box for view
    LatLngBounds _bounds = FindBoundsCoordinates().getBounds(markersList);

    // adjust camera to boundingBox
    controller.animateCamera(CameraUpdate.newLatLngBounds(_bounds, 100.0));
  }
}

//
// used to calculate the boundry for rendering the markers
//
class FindBoundsCoordinates {
  LatLngBounds getBounds(Set<MyMarker> locations) {
    List<double> latitudes = [];
    List<double> londitude = [];

    locations.toList().forEach((index) {
      latitudes.add(index.position.latitude);
      londitude.add(index.position.longitude);
    });

    return LatLngBounds(
      southwest: LatLng(latitudes.reduce(min), londitude.reduce(min)),
      northeast: LatLng(latitudes.reduce(max), londitude.reduce(max)),
    );
  }
}
