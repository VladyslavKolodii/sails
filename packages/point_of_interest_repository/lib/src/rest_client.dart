import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://api.sailmate.fi')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/point_of_interests.json')
  Future<List<PointOfInterestWrapper>> getPointOfInterests();
}

@JsonSerializable()
class PointOfInterestWrapper {
  // ignore: non_constant_identifier_names
  PointOfInterest point_of_interest;
  // ignore: non_constant_identifier_names
  PointOfInterestWrapper({this.point_of_interest});

  factory PointOfInterestWrapper.fromJson(Map<String, dynamic> json) => _$PointOfInterestWrapperFromJson(json);
  Map<String, dynamic> toJson() => _$PointOfInterestWrapperToJson(this);
}

@JsonSerializable()
class PointOfInterest {
  int id;
  String name;
  double lat;
  double lon;
  String poi_type;

  PointOfInterest({this.id, this.name, this.lat, this.lon, this.poi_type});

  factory PointOfInterest.fromJson(Map<String, dynamic> json) => _$PointOfInterestFromJson(json);
  Map<String, dynamic> toJson() => _$PointOfInterestToJson(this);
}
