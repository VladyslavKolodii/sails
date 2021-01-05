import 'package:mapbox_gl/mapbox_gl.dart';

class ModelSavedPlaces {
  final int id;
  final String name;
  final String type;
  final String date;
  final int min;
  final LatLng latLng;
  final String imgUrl;

  ModelSavedPlaces(this.id, this.name, this.type, this.date, this.min, this.latLng, this.imgUrl);
}