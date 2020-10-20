import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapPage extends StatelessWidget {
  const MapPage({
    @required this.mapboxApiKey,
    @required this.mapboxStyleString
  }) : super();

  final String mapboxApiKey;
  final String mapboxStyleString;

  static Route route(String mapboxApiKey, String mapboxStyleString) {
    return MaterialPageRoute<void>(builder: (_) => MapPage(mapboxApiKey: mapboxApiKey, mapboxStyleString: mapboxStyleString));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(title: const Text('Sailmate')),
        body: FutureBuilder<Position>(
          future: getCurrentPosition(),
          builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
            if (snapshot.hasError) {
              print('foobar');
            }
            if (!snapshot.hasData) {
              // while data is loading:
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return MapboxMap(
                accessToken: mapboxApiKey,
                styleString: mapboxStyleString,
                initialCameraPosition: CameraPosition(target: LatLng(snapshot.data.latitude, snapshot.data.longitude), zoom: 14),
                myLocationEnabled: true,
                myLocationTrackingMode: MyLocationTrackingMode.Tracking,
              );
          }
          }
        )
    );
  }
}
