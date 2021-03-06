# Flutter Map Markers Example Using Google Maps Plugin

A Sample Flutter Google Maps project.

- renders map
- renders markers on map
- calculates `LatLngBounds` from the markers to ensure they are visible

<p align="center">
<img src="https://raw.githubusercontent.com/aaronksaunders/flutter_map_markers/master/Screen%20Shot%202019-05-17%20at%208.05.29%20PM.png"  width="50%"/>
</p>


### Calculating Bounds
Loop through the provided markers and create a bound object that ensures all of the markers are visible
```dart
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
```
## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
