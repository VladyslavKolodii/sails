import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hybrid_sailmate/screens/search_screens/search_main.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/bottom_famouse_place.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/bottom_sheet_carousel.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/bottom_sheet_description.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/main_bottom/bottom_sheet_preview.dart';
import 'package:hybrid_sailmate/widgets/custom_buttons.dart';
import 'package:hybrid_sailmate/utils/common_util.dart';
import 'package:hybrid_sailmate/widgets/speed_and_heading_info_box.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fontisto_flutter/fontisto_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:point_of_interest_repository/point_of_interest_repository.dart';
import 'package:progress_hud/progress_hud.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    @required this.mapboxApiKey,
    @required this.mapboxStyleString,
    @required this.scaffoldKey
  }) : super();

  final String mapboxApiKey;
  final String mapboxStyleString;
  final GlobalKey<ScaffoldState> scaffoldKey;

  static Route route(String mapboxApiKey, String mapboxStyleString, GlobalKey scaffoldKey) {
    return MaterialPageRoute<void>(
        builder: (_) => MapPage(mapboxApiKey: mapboxApiKey, mapboxStyleString: mapboxStyleString, scaffoldKey: scaffoldKey)
    );
  }
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapboxMapController _mapController;
  List<PointOfInterest> targetInterestPlaces;
  RestClient pointOfInterestRepository;

  LatLng _serachedPoi;

  ProgressHUD progressHUD;

  @override
  void initState() {
    super.initState();

    Common.mapApiKey = widget.mapboxApiKey;
    Common.mapboxStyleString = widget.mapboxStyleString;

  }

  Future initInterestingData() async {
    var response = await http.get('https://api.sailmate.fi/point_of_interests.json');
    if (response.body.isNotEmpty) {
      var jsonLabel = json.decode(response.body);
      var items = jsonLabel as List;
      var wrapper = items.map<PointOfInterestWrapper>((items) => PointOfInterestWrapper.fromJson(items)).toList();
      targetInterestPlaces = wrapper.map((PointOfInterestWrapper wrapper) => wrapper.point_of_interest).toList();
      Common.gPOIs = targetInterestPlaces;
    } else {
      print('There is no data');
    }
    if (targetInterestPlaces != null) {
      targetInterestPlaces.map((PointOfInterest poi) {
        if (poi.poi_type == 'PORT') {
          _mapController.addSymbol(SymbolOptions(
            geometry: LatLng(poi.lat, poi.lon),
            iconImage: 'assets/images/ic_port_marker.png',
          ));
        }
      }).toList();
    }
  }

  void _onhandleRoute(PointOfInterest pointOfInterest) {
    var _myCurrentLocation = LatLng(60.20, 22.0);
    var _destinationLocation = LatLng(pointOfInterest.lat, pointOfInterest.lon);

    _mapController.addLine(
      LineOptions(
        geometry: [
          _myCurrentLocation,
          _destinationLocation
        ],
        lineColor: '#4B7CC6',
        lineWidth: 7.0,
        lineOpacity: 0.9,
        draggable: false,
      ),
    );

  }

  void _showBottomSheet(PointOfInterest harbour) {
    Common.prsentDraggableBottomSheet(context,
      260.0,
      Container(
        child: Column(
          children: [
            BottomSheetHeader(habur: harbour, onTapRoute: () {
              Navigator.of(context).pop();
              _onhandleRoute(harbour);
            }, onTapSave: () {

            },),
            SizedBox(height: 24.0,),
            BottomSheetCarousel(),
            SizedBox(height: 16.0,),
            BottomFamousePlace(),
            BottomSheetDescription(),
            Container(
              color: mainColorInput,
              height: 200,
            )
          ],
        ),
      ),
      SizedBox.shrink()
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      child: FutureBuilder<Position>(
        future: Geolocator.getCurrentPosition(),
        builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
          var latitude = snapshot.data?.latitude;
          var longitude = snapshot.data?.longitude;
          if (snapshot.hasError) {
            print('Error fetching current location');
          }
          return Center(
            child: Stack(
              children: [
                MapboxMap(
                  initialCameraPosition: CameraPosition(target: LatLng(60, 20), zoom: 10),
                  accessToken: widget.mapboxApiKey,
                  styleString: widget.mapboxStyleString,
                  myLocationEnabled: false,
                  myLocationTrackingMode: MyLocationTrackingMode.Tracking,
                  attributionButtonMargins: Point(0, 10000),
                  onStyleLoadedCallback: () {
                    initInterestingData();
                  },
                  rotateGesturesEnabled: false,
                  onMapClick: (point, location) {
                    _mapController.updateMyLocationTrackingMode(MyLocationTrackingMode.None);
                  },
                  onMapCreated: (controller) {
                    _mapController = controller;
                    _mapController.onSymbolTapped.add((argument) {
                      if (targetInterestPlaces != null) {
                        for(var i = 0; i < targetInterestPlaces.length; i ++) {
                          var distance = Common.calculateDistance(argument.options.geometry, LatLng(targetInterestPlaces[i].lat, targetInterestPlaces[i].lon));
                          if (distance < 0.3) {
                            _showBottomSheet(targetInterestPlaces[i]);
                          }
                        }
                      }
                    });
                  },
                ),
                SpeedAndHeadingInfoBox(top: height < 670 ? 25 : 58),
                Positioned(
                    bottom: 40,
                    right: 24,
                    child: FloatingActionButton(
                      onPressed: () {
                        _mapController.updateMyLocationTrackingMode(MyLocationTrackingMode.Tracking);
                        _mapController.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(latitude, longitude), zoom: 10.0)));
                      },
                      child: Icon(Istos.crosshairs),
                    )
                ),
                Positioned(
                  left: 24,
                  top: height < 670 ? 25 : 58,
                  child: CustomIconBtn(icon: Istos.nav_icon, function: () {
                    Scaffold.of(context).openDrawer();
                  },)
                ),
                Positioned(
                  left: 86,
                  top: height < 670 ? 25 : 58,
                  child: CustomIconBtn(icon: Istos.search, function: () {
                    _navigationToSeachMainScreen(context);
                  }, iconSize: 16.0,)
                )
              ],
            ),
          );
        },
      ),
    );
  }

  _navigationToSeachMainScreen(BuildContext context) async {
    _serachedPoi = await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => SearchMain(),
      ),
    );
    if (_serachedPoi != null) {
      await _mapController.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _serachedPoi, zoom: 10.0)));
    }
  }
}

