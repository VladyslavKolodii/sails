import 'dart:async';
import 'dart:math';

import 'package:flutter_map/plugin_api.dart';
import 'package:hybrid_sailmate/utils/common_util.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:point_of_interest_repository/point_of_interest_repository.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();
}

class MapCreateRequested extends MapEvent {
  final String accessToken;
  final String styleString;

  const MapCreateRequested({
    @required this.accessToken,
    @required this.styleString,
  }) : assert(accessToken != null && styleString != null);

  @override
  List<Object> get props => [accessToken, styleString];
}

class MapMarkerClicked extends MapEvent {
  final PointOfInterest clickedMarker;

  MapMarkerClicked(@required this.clickedMarker) : assert(clickedMarker != null);
  @override
  List<Object> get props => [clickedMarker];

}

class MapRenderRequested extends MapEvent {
  @override
  List<Object> get props => [];
}

class CameraUpdateRequested extends MapEvent {
  final LatLng location;
  final double zoom;

  const CameraUpdateRequested({
    @required this.location,
    this.zoom,
  }) : assert(location != null);

  @override
  List<Object> get props => [location, zoom];
}

class TrackingModeUpdateRequested extends MapEvent {
  final MyLocationTrackingMode mode;

  const TrackingModeUpdateRequested({
    @required this.mode,
  }) : assert(mode != null);

  @override
  List<Object> get props => [mode];
}

class PointOfInterestsRequested extends MapEvent {
  const PointOfInterestsRequested();

  @override
  List<Object> get props => [];
}

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}
abstract class MapVisible extends MapState {
  const MapVisible();

  @override
  List<Object> get props => [];
}

class MapClicked extends MapState {}

class MapInitial extends MapState {}

class MapRenderInProgress extends MapVisible {}
class MapRendered extends MapVisible {}

class MapCreateInProgress extends MapState {}



class MapReady extends MapVisible {
  final MapboxMap mapboxMap;

  const MapReady({@required this.mapboxMap}) : assert(mapboxMap != null);

  @override
  List<Object> get props => [mapboxMap];
}

class CameraUpdateInProgress extends MapVisible {}
class CameraUpdated extends MapVisible {}

class TrackingModeUpdateInProgress extends MapVisible {}
class TrackingModeUpdated extends MapVisible {}

class PointOfInterestsLoadInProgress extends MapVisible {}

class PointOfInterestsLoadSuccess extends MapVisible {
  final List<PointOfInterest> pointOfInterests;

  const PointOfInterestsLoadSuccess({@required this.pointOfInterests}) : assert(pointOfInterests != null);

  @override
  List<Object> get props => [pointOfInterests];
}

class PointOfInterestsLoadFailure extends MapVisible {}

class MapBloc extends Bloc<MapEvent, MapState> {
  final RestClient pointOfInterestRepository;

  List<PointOfInterest> targetInterestPlaces;
  MapboxMapController _mapController;
  MapboxMap _map;


  MapBloc({@required this.pointOfInterestRepository})
      : assert(pointOfInterestRepository != null),
        super(MapInitial());

  MapboxMap _createMapSync(String accessToken, String styleString) {
    return MapboxMap(
      accessToken: accessToken,
      styleString: styleString,
      rotateGesturesEnabled: false,
      onMapClick: (point, location) {
        _mapController.updateMyLocationTrackingMode(MyLocationTrackingMode.None);
        for(var i = 0; i < targetInterestPlaces.length; i ++) {
          var distance = Common.calculateDistance(location, LatLng(targetInterestPlaces[i].lat, targetInterestPlaces[i].lon));
          if (distance < 0.3) {
            print('name:' + targetInterestPlaces[i].name);
            add(MapMarkerClicked(targetInterestPlaces[i]));
          }
        }
      },

      onMapCreated: (controller) {
        _mapController = controller;
        add(MapRenderRequested());
      },
      // TODO: not the prettiest way to hide attribution
      attributionButtonMargins: Point(0, 10000),
      onStyleLoadedCallback: () {},
      initialCameraPosition: CameraPosition(target: LatLng(60, 20), zoom: 10),
      myLocationEnabled: true,
      myLocationTrackingMode: MyLocationTrackingMode.Tracking,
    );

  }

  Future<MapboxMap> _createMap(String accessToken, String styleString) {
    final completer = Completer<MapboxMap>();
    completer.complete(_createMapSync(accessToken, styleString));
    return completer.future;
  }

  MapboxMap getMap() {
    return _map;
  }

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is MapCreateRequested) {
      yield* _mapMapCreateRequestedToState(event);
    }
    if (event is CameraUpdateRequested) {
      yield* _mapCameraUpdateRequestedToState(event);
    }
    if (event is PointOfInterestsRequested) {
      yield* _mapPointOfInterestsRequestedToState(event);
    }
    if (event is MapRenderRequested) {
      yield MapRenderInProgress();
      await Future.delayed(Duration(seconds: 1));
      yield MapRendered();
    }
    if (event is TrackingModeUpdateRequested) {
      yield TrackingModeUpdateInProgress();
      await _mapController.updateMyLocationTrackingMode(event.mode);
      yield TrackingModeUpdated();
    }

    if (event is MapMarkerClicked) {
      yield* _mapMarkerClicked(event);
    }
  }

  Stream<MapState> _mapMarkerClicked(MapMarkerClicked event) async* {
    yield MapClicked();
    // MapClicked
  }

  Stream<MapState> _mapPointOfInterestsRequestedToState(
    PointOfInterestsRequested event,
  ) async* {
    yield PointOfInterestsLoadInProgress();
    try {
      final wrapped = await pointOfInterestRepository.getPointOfInterests();
      targetInterestPlaces = wrapped.map((PointOfInterestWrapper wrapper) => wrapper.point_of_interest).toList();
      targetInterestPlaces.map((PointOfInterest poi) {
        if (poi.poi_type == 'PORT') {
          _mapController.addSymbol(SymbolOptions(
            geometry: LatLng(poi.lat, poi.lon),
            iconImage: 'assets/images/ic_port_marker.png',
          ));
        }
        // _mapController.addCircle(CircleOptions(geometry: LatLng(poi.lat, poi.lon)));
      }).toList();
      yield PointOfInterestsLoadSuccess(pointOfInterests: targetInterestPlaces);
    } catch (_) {
      yield PointOfInterestsLoadFailure();
    }
  }
  Stream<MapState> _mapCameraUpdateRequestedToState(
    CameraUpdateRequested event,
  ) async* {
    yield CameraUpdateInProgress();
    try {
      await _mapController.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: event.location,
            zoom: event.zoom
          )
        )
      );
      yield CameraUpdated();
    } catch (_) {
      yield PointOfInterestsLoadFailure();
    }
  }
  Stream<MapState> _mapMapCreateRequestedToState(
    MapCreateRequested event,
  ) async* {
    yield MapCreateInProgress();
    try {
      var map = await _createMap(event.accessToken, event.styleString);
      _map = map;
      await Future.delayed(Duration(seconds: 1));
      yield MapReady(mapboxMap: map);
    } catch (_) {
      yield PointOfInterestsLoadFailure();
    }
  }
}

