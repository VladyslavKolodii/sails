// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointOfInterestWrapper _$PointOfInterestWrapperFromJson(
    Map<String, dynamic> json) {
  return PointOfInterestWrapper(
    point_of_interest: json['point_of_interest'] == null
        ? null
        : PointOfInterest.fromJson(
            json['point_of_interest'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PointOfInterestWrapperToJson(
        PointOfInterestWrapper instance) =>
    <String, dynamic>{
      'point_of_interest': instance.point_of_interest,
    };

PointOfInterest _$PointOfInterestFromJson(Map<String, dynamic> json) {
  return PointOfInterest(
    id: json['id'] as int,
    name: json['name'] as String,
    lat: (json['lat'] as num)?.toDouble(),
    lon: (json['lon'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$PointOfInterestToJson(PointOfInterest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lat': instance.lat,
      'lon': instance.lon,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://api.sailmate.fi';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<PointOfInterestWrapper>> getPointOfInterests() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>(
        '/point_of_interests.json',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) =>
            PointOfInterestWrapper.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
